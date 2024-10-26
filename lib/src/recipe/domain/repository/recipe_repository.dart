import 'package:food_recipe/src/recipe/data/local/db_helper.dart';

abstract class RecipeRepository {
  // database
  DatabaseHelper getDatabaseHelper();
  void populateInitialData();

  // Recipe Type Operations
  Future<int> insertRecipeType(Map<String, dynamic> row);
  Future<List<Map<String, dynamic>>> getRecipeTypes();
}
