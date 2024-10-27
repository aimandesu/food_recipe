// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RecipeTypeImpl _$$RecipeTypeImplFromJson(Map<String, dynamic> json) =>
    _$RecipeTypeImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String,
      imagePath: _imageFromJson(json['image_path'] as String?),
    );

Map<String, dynamic> _$$RecipeTypeImplToJson(_$RecipeTypeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image_path': _imageToJson(instance.imagePath),
    };
