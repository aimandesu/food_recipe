import 'package:food_recipe/src/core/helper/db_helper.dart';

abstract class RecipeRepository {
  // database
  DatabaseHelper getDatabaseHelper();
  void populateRecipeData();

  // Recipe Type Operations
  Future<int> insertRecipeType(Map<String, dynamic> row);
  Future<List<Map<String, dynamic>>> getRecipeTypes();
}
