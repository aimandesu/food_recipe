import 'dart:typed_data'; // For Uint8List
import 'dart:convert'; // For base64 encoding/decoding
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe.freezed.dart';
part 'recipe.g.dart';

@freezed
class Recipe with _$Recipe {
  Recipe._();

  factory Recipe({
    int? id,
    @JsonKey(name: 'type_id') required final int typeId,
    required final String title,
    @JsonKey(name: 'image_path', fromJson: _imageFromJson, toJson: _imageToJson)
    Uint8List? imagePath,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _Recipe;

  factory Recipe.initial() => Recipe(typeId: 0, title: 'title');

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);

  factory Recipe.fromDatabase(Map<String, dynamic> map) {
    return Recipe(
      id: map['id'] as int?,
      typeId: map['type_id'] as int,
      title: map['title'] as String,
      imagePath: map['image_path'] as Uint8List?,
      createdAt: map['created_at'] as String?,
      updatedAt: map['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toDatabase() {
    return {
      'id': id,
      'type_id': typeId,
      'title': title,
      'image_path': imagePath,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

// Custom function to decode a Base64 string to Uint8List
Uint8List? _imageFromJson(String? base64String) {
  return base64String != null ? base64Decode(base64String) : null;
}

// Custom function to encode Uint8List to a Base64 string
String? _imageToJson(Uint8List? imagePath) {
  return imagePath != null ? base64Encode(imagePath) : null;
}
