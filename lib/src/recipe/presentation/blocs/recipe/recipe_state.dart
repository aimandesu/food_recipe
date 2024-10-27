part of 'recipe_bloc.dart';

@freezed
class RecipeState with _$RecipeState {
  factory RecipeState({
    required RecipeEnum status,
    required List<Recipe> recipe,
    required Recipe selectedRecipe,
    required final List<Ingredient> ingredients,
    required final List<RecipeStep> steps,
    String? errorMsg,
  }) = _RecipeState;

  factory RecipeState.initial() => RecipeState(
        status: RecipeEnum.initial,
        recipe: [],
        selectedRecipe: Recipe.initial(),
        ingredients: [],
        steps: [],
      );

  factory RecipeState.fromJson(Map<String, dynamic> json) =>
      _$RecipeStateFromJson(json);
}
