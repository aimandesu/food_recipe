part of 'recipe_bloc.dart';

abstract class RecipeEvent {}

class LoadRecipes extends RecipeEvent {
  final int? typeId;
  LoadRecipes({this.typeId});
}

class AddRecipe extends RecipeEvent {
  final Recipe recipe;
  final List<Ingredient> ingredients;
  final List<RecipeStep> steps;

  AddRecipe({
    required this.recipe,
    required this.ingredients,
    required this.steps,
  });
}

class UpdateRecipe extends RecipeEvent {
  final Recipe recipe;
  final List<Ingredient> ingredients;
  final List<RecipeStep> steps;

  UpdateRecipe({
    required this.recipe,
    required this.ingredients,
    required this.steps,
  });
}

class DeleteRecipe extends RecipeEvent {
  final int recipeId;
  DeleteRecipe({required this.recipeId});
}

class LoadRecipeDetails extends RecipeEvent {
  final int recipeId;
  LoadRecipeDetails({required this.recipeId});
}
