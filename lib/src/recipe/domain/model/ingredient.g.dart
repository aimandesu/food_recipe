// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$IngredientImpl _$$IngredientImplFromJson(Map<String, dynamic> json) =>
    _$IngredientImpl(
      id: (json['id'] as num?)?.toInt(),
      recipeId: (json['recipe_id'] as num).toInt(),
      name: json['name'] as String,
      quantity: json['quantity'] as String,
      unit: json['unit'] as String?,
    );

Map<String, dynamic> _$$IngredientImplToJson(_$IngredientImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'recipe_id': instance.recipeId,
      'name': instance.name,
      'quantity': instance.quantity,
      'unit': instance.unit,
    };
