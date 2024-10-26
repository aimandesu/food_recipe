part of 'recipe_type_bloc.dart';

abstract class RecipeTypeEvent {}

class LoadRecipeTypes extends RecipeTypeEvent {}

class AddRecipeType extends RecipeTypeEvent {
  final RecipeType recipeType;
  AddRecipeType({required this.recipeType});
}
