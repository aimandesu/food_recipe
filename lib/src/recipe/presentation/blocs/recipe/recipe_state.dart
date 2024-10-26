part of 'recipe_bloc.dart';

@freezed
class RecipeState with _$RecipeState {
  factory RecipeState({
    required RecipeEnum status,
    required List<Recipe> recipe,
    required final List<Ingredient> ingredients,
    required final List<Step> steps,
    String? errorMsg,
  }) = _RecipeState;

  factory RecipeState.initial() => RecipeState(
        status: RecipeEnum.initial,
        recipe: [],
        ingredients: [],
        steps: [],
      );

  factory RecipeState.fromJson(Map<String, dynamic> json) =>
      _$RecipeStateFromJson(json);
}
