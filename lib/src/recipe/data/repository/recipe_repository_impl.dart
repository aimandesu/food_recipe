import 'package:food_recipe/src/recipe/data/local/db_helper.dart';
import 'package:food_recipe/src/recipe/data/local/initial_data.dart';
import 'package:food_recipe/src/recipe/domain/repository/recipe_repository.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  @override
  DatabaseHelper getDatabaseHelper() {
    final DatabaseHelper databaseHelper = DatabaseHelper();
    return databaseHelper;
  }

  @override
  Future<int> insertRecipeType(Map<String, dynamic> row) {
    return getDatabaseHelper().insertRecipeType(row);
  }

  @override
  void populateInitialData() {
    InitialData.populate(getDatabaseHelper());
  }

  @override
  Future<List<Map<String, dynamic>>> getRecipeTypes() {
    return getDatabaseHelper().getRecipeTypes();
  }
}
