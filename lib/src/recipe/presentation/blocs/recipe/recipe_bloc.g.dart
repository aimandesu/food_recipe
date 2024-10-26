// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RecipeStateImpl _$$RecipeStateImplFromJson(Map<String, dynamic> json) =>
    _$RecipeStateImpl(
      status: $enumDecode(_$RecipeEnumEnumMap, json['status']),
      recipe: (json['recipe'] as List<dynamic>)
          .map((e) => Recipe.fromJson(e as Map<String, dynamic>))
          .toList(),
      ingredients: (json['ingredients'] as List<dynamic>)
          .map((e) => Ingredient.fromJson(e as Map<String, dynamic>))
          .toList(),
      steps: (json['steps'] as List<dynamic>)
          .map((e) => Step.fromJson(e as Map<String, dynamic>))
          .toList(),
      errorMsg: json['errorMsg'] as String?,
    );

Map<String, dynamic> _$$RecipeStateImplToJson(_$RecipeStateImpl instance) =>
    <String, dynamic>{
      'status': _$RecipeEnumEnumMap[instance.status]!,
      'recipe': instance.recipe,
      'ingredients': instance.ingredients,
      'steps': instance.steps,
      'errorMsg': instance.errorMsg,
    };

const _$RecipeEnumEnumMap = {
  RecipeEnum.initial: 'initial',
  RecipeEnum.loading: 'loading',
  RecipeEnum.completed: 'completed',
  RecipeEnum.error: 'error',
};
