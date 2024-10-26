import 'dart:convert';

import 'package:food_recipe/src/recipe/domain/model/ingredient.dart';
import 'package:food_recipe/src/recipe/domain/model/step.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe.freezed.dart';
part 'recipe.g.dart';

@freezed
class Recipe with _$Recipe {
  factory Recipe({
    int? id,
    @JsonKey(name: 'type_id') required final int typeId,
    required final String title,
    @JsonKey(name: 'image_path') String? imagePath,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _Recipe;

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);

  factory Recipe.fromDatabase(Map<String, dynamic> map) {
    return Recipe(
      id: map['id'] as int?,
      typeId: map['type_id'] as int,
      title: map['title'] as String,
      imagePath: map['image_path'] as String?,
      createdAt: map['created_at'] as String?,
      updatedAt: map['updated_at'] as String?,
    );
  }
}
