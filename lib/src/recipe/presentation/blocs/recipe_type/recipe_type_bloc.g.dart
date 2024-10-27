// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_type_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RecipeTypeStateImpl _$$RecipeTypeStateImplFromJson(
        Map<String, dynamic> json) =>
    _$RecipeTypeStateImpl(
      recipeTypeStatus:
          $enumDecode(_$RecipeTypeEnumEnumMap, json['recipeTypeStatus']),
      recipeType: (json['recipeType'] as List<dynamic>)
          .map((e) => RecipeType.fromJson(e as Map<String, dynamic>))
          .toList(),
      recipeSelected: (json['recipeSelected'] as num?)?.toInt(),
      errorMsg: json['errorMsg'] as String?,
    );

Map<String, dynamic> _$$RecipeTypeStateImplToJson(
        _$RecipeTypeStateImpl instance) =>
    <String, dynamic>{
      'recipeTypeStatus': _$RecipeTypeEnumEnumMap[instance.recipeTypeStatus]!,
      'recipeType': instance.recipeType,
      'recipeSelected': instance.recipeSelected,
      'errorMsg': instance.errorMsg,
    };

const _$RecipeTypeEnumEnumMap = {
  RecipeTypeEnum.initial: 'initial',
  RecipeTypeEnum.loading: 'loading',
  RecipeTypeEnum.completed: 'completed',
  RecipeTypeEnum.error: 'error',
};
