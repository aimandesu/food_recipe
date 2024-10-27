import 'package:freezed_annotation/freezed_annotation.dart';

part 'step.freezed.dart';
part 'step.g.dart';

@freezed
class RecipeStep with _$RecipeStep {
  factory RecipeStep({
    int? id,
    @JsonKey(name: 'recipe_id') required final int recipeId,
    @JsonKey(name: 'step_number') required final int stepNumber,
    required final String description,
  }) = _Step;

  factory RecipeStep.initial() => RecipeStep(
        recipeId: 0,
        stepNumber: 0,
        description: '',
      );

  factory RecipeStep.fromJson(Map<String, dynamic> json) =>
      _$RecipeStepFromJson(json);
}
