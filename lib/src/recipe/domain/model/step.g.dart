// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'step.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StepImpl _$$StepImplFromJson(Map<String, dynamic> json) => _$StepImpl(
      id: (json['id'] as num?)?.toInt(),
      recipeId: (json['recipe_id'] as num).toInt(),
      stepNumber: (json['step_number'] as num).toInt(),
      description: json['description'] as String,
    );

Map<String, dynamic> _$$StepImplToJson(_$StepImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'recipe_id': instance.recipeId,
      'step_number': instance.stepNumber,
      'description': instance.description,
    };
