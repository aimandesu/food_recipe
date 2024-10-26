part of 'recipe_type_bloc.dart';

@freezed
class RecipeTypeState with _$RecipeTypeState {
  factory RecipeTypeState({
    required RecipeTypeEnum recipeTypeStatus,
    required List<RecipeType> recipeType,
    String? errorMsg,
  }) = _RecipeTypeState;

  factory RecipeTypeState.initial() => RecipeTypeState(
        recipeTypeStatus: RecipeTypeEnum.initial,
        recipeType: [],
      );

  factory RecipeTypeState.fromJson(Map<String, dynamic> json) =>
      _$RecipeTypeStateFromJson(json);
}