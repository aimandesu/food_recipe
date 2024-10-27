// database_helper.dart
import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'recipe_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      username TEXT NOT NULL UNIQUE,
      email TEXT NOT NULL UNIQUE,
      password_hash TEXT NOT NULL,
      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');

// User profiles table (for additional user information)
    await db.execute('''
      CREATE TABLE user_profiles(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      user_id INTEGER NOT NULL,
      full_name TEXT,
      avatar_path BLOB,
      bio TEXT,
      FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
      )
    ''');

// User sessions table (for managing active sessions)
    await db.execute('''
      CREATE TABLE user_sessions(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      user_id INTEGER NOT NULL,
      token TEXT NOT NULL UNIQUE,
      last_activity TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      expires_at TIMESTAMP NOT NULL,
      FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
      )
    ''');

    // Recipe Types table
    await db.execute('''
      CREATE TABLE recipe_types(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        image_path BLOB
      )
    ''');

    // Recipes table
    await db.execute('''
      CREATE TABLE recipes(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        type_id INTEGER,
        title TEXT NOT NULL,
        image_path BLOB,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (type_id) REFERENCES recipe_types (id)
      )
    ''');

    // Ingredients table
    await db.execute('''
      CREATE TABLE ingredients(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        recipe_id INTEGER,
        name TEXT NOT NULL,
        quantity TEXT NOT NULL,
        unit TEXT,
        FOREIGN KEY (recipe_id) REFERENCES recipes (id) ON DELETE CASCADE
      )
    ''');

    // Steps table
    await db.execute('''
      CREATE TABLE steps(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        recipe_id INTEGER,
        step_number INTEGER NOT NULL,
        description TEXT NOT NULL,
        FOREIGN KEY (recipe_id) REFERENCES recipes (id) ON DELETE CASCADE
      )
    ''');

    // Link recipes to users (assuming you want users to own recipes)
    await db.execute('''
      ALTER TABLE recipes 
      ADD COLUMN user_id INTEGER REFERENCES users(id)
    ''');
  }

  // Recipe Type Operations
  Future<int> insertRecipeType(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('recipe_types', row);
  }

  Future<List<Map<String, dynamic>>> getRecipeTypes() async {
    Database db = await database;
    return await db.query('recipe_types');
  }

  // Recipe Operations
  Future<int> insertRecipe(Map<String, dynamic> row) async {
    Database db = await database;
    row['created_at'] = DateTime.now().toIso8601String();
    row['updated_at'] = DateTime.now().toIso8601String();
    return await db.insert('recipes', row);
  }

  Future<List<Map<String, dynamic>>> getRecipes({int? typeId}) async {
    Database db = await database;
    if (typeId != null) {
      return await db
          .query('recipes', where: 'type_id = ?', whereArgs: [typeId]);
    }
    return await db.query('recipes');
  }

  Future<Map<String, dynamic>?> getRecipe(int id) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'recipes',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }

  Future<int> updateRecipe(Map<String, dynamic> row) async {
    Database db = await database;
    row['updated_at'] = DateTime.now().toIso8601String();
    return await db.update(
      'recipes',
      row,
      where: 'id = ?',
      whereArgs: [row['id']],
    );
  }

  Future<int> deleteRecipe(int id) async {
    Database db = await database;
    return await db.delete(
      'recipes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Ingredient Operations
  Future<int> insertIngredient(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('ingredients', row);
  }

  Future<List<Map<String, dynamic>>> getIngredients(int recipeId) async {
    Database db = await database;
    return await db.query(
      'ingredients',
      where: 'recipe_id = ?',
      whereArgs: [recipeId],
    );
  }

  Future<int> updateIngredient(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.update(
      'ingredients',
      row,
      where: 'id = ?',
      whereArgs: [row['id']],
    );
  }

  Future<int> deleteIngredient(int id) async {
    Database db = await database;
    return await db.delete(
      'ingredients',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Step Operations
  Future<int> insertStep(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('steps', row);
  }

  Future<List<Map<String, dynamic>>> getSteps(int recipeId) async {
    Database db = await database;
    return await db.query(
      'steps',
      where: 'recipe_id = ?',
      whereArgs: [recipeId],
      orderBy: 'step_number ASC',
    );
  }

  Future<int> updateStep(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.update(
      'steps',
      row,
      where: 'id = ?',
      whereArgs: [row['id']],
    );
  }

  Future<int> deleteStep(int id) async {
    Database db = await database;
    return await db.delete(
      'steps',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
