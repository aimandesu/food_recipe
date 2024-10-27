import 'dart:math';
import 'dart:developer' as k;

import 'package:food_recipe/src/recipe/data/local/initial_data.dart';
import 'package:food_recipe/src/user/domain/model/user_model.dart';
import 'package:food_recipe/src/user/domain/repository/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class AuthRepositoryImpl implements AuthRepository {
  final Database db;
  final SharedPreferences prefs;
  static const String KEY_SESSION_TOKEN = 'session_token';
  static const String KEY_USER_ID = 'user_id';

  AuthRepositoryImpl(this.db, this.prefs);

  @override
  Future<UserModel> signUp({
    required String username,
    required String email,
    required String password,
    String? fullName,
  }) async {
    final passwordHash = sha256.convert(utf8.encode(password)).toString();

    final userId = await db.transaction((txn) async {
      final userId = await txn.insert(
        'users',
        {
          'username': username,
          'email': email,
          'password_hash': passwordHash,
        },
      );

      if (fullName != null) {
        await txn.insert(
          'user_profiles',
          {
            'user_id': userId,
            'full_name': fullName,
          },
        );
      }

      return userId;
    });

    return UserModel(
      id: userId,
      username: username,
      email: email,
      fullName: fullName,
    );
  }

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final passwordHash = sha256.convert(utf8.encode(password)).toString();

    final user = await db.rawQuery('''
      SELECT u.*, up.full_name, up.avatar_path, up.bio
      FROM users u
      LEFT JOIN user_profiles up ON u.id = up.user_id
      WHERE u.email = ? AND u.password_hash = ?
    ''', [email, passwordHash]);

    if (user.isEmpty) {
      throw Exception('Invalid credentials');
    }

    final userData = user.first;

    final token = generateToken();

    // Create a session
    await db.insert(
      'user_sessions',
      {
        'user_id': userData['id'],
        'token': token,
        'expires_at':
            DateTime.now().add(const Duration(days: 7)).toIso8601String(),
      },
    );

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(KEY_SESSION_TOKEN, token);
    await prefs.setInt(KEY_USER_ID, int.parse(userData['id'].toString()));

    return UserModel.fromJson(userData);
  }

  @override
  Future<void> logout(int userId) async {
    await db.delete(
      'user_sessions',
      where: 'user_id = ?',
      whereArgs: [userId],
    );
  }

  @override
  String generateToken() {
    final random =
        base64UrlEncode(List<int>.generate(32, (_) => Random().nextInt(256)));
    return '${DateTime.now().millisecondsSinceEpoch}$random';
  }

  @override
  void populateUserData() {
    InitialData.seedLoginData(db);
  }

  Future<UserModel?> checkAuthStatus() async {
    try {
      final String? token = prefs.getString(KEY_SESSION_TOKEN);
      final int? userId = prefs.getInt(KEY_USER_ID);

      if (token == null || userId == null) return null;

      // Check if session is valid
      final validSession = await db.query(
        'user_sessions',
        where: 'token = ? AND user_id = ? AND expires_at > ?',
        whereArgs: [token, userId, DateTime.now().toIso8601String()],
      );

      if (validSession.isEmpty) {
        // Clear invalid session
        await prefs.remove(KEY_SESSION_TOKEN);
        await prefs.remove(KEY_USER_ID);
        return null;
      }

      // Get user data with profile
      final userData = await db.rawQuery('''
        SELECT u.*, up.full_name, up.avatar_path, up.bio
        FROM users u
        LEFT JOIN user_profiles up ON u.id = up.user_id
        WHERE u.id = ?
      ''', [userId]);

      if (userData.isEmpty) return null;

      return UserModel.fromJson(userData.first);
    } catch (e) {
      return null;
    }
  }
}
