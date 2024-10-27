import 'package:food_recipe/src/user/domain/model/user_model.dart';

abstract class AuthRepository {
  Future<UserModel> signUp({
    required String username,
    required String email,
    required String password,
    String? fullName,
  });
  Future<UserModel> login({
    required String email,
    required String password,
  });
  Future<void> logout(int userId);
  String generateToken();
  void populateUserData();
  // Future<Map<String, dynamic>?> getSession();
  // Future<UserModel> getUserById(int userId);
}
