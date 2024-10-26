import 'package:freezed_annotation/freezed_annotation.dart';

part 'step.freezed.dart';
part 'step.g.dart';

@freezed
class Step with _$Step {
  factory Step({
    int? id,
    @JsonKey(name: 'recipe_id') required final int recipeId,
    @JsonKey(name: 'step_number') required final int stepNumber,
    required final String description,
  }) = _Step;

  factory Step.initial() => Step(
        recipeId: 0,
        stepNumber: 0,
        description: '',
      );

  factory Step.fromJson(Map<String, dynamic> json) => _$StepFromJson(json);
}
