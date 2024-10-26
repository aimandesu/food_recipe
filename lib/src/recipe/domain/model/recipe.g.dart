// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RecipeImpl _$$RecipeImplFromJson(Map<String, dynamic> json) => _$RecipeImpl(
      id: (json['id'] as num?)?.toInt(),
      typeId: (json['type_id'] as num).toInt(),
      title: json['title'] as String,
      imagePath: json['image_path'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$$RecipeImplToJson(_$RecipeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type_id': instance.typeId,
      'title': instance.title,
      'image_path': instance.imagePath,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
