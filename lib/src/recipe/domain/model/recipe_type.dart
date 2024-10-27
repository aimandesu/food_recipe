import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:typed_data'; // For Uint8List
import 'dart:convert'; // For base64 encoding/decoding
part 'recipe_type.freezed.dart';
part 'recipe_type.g.dart';

@freezed
class RecipeType with _$RecipeType {
  RecipeType._();

  factory RecipeType({
    int? id,
    required final String name,
    @JsonKey(name: 'image_path', fromJson: _imageFromJson, toJson: _imageToJson)
    Uint8List? imagePath,
  }) = _RecipeType;

  factory RecipeType.initial() => RecipeType(name: '');

  factory RecipeType.fromJson(Map<String, dynamic> json) =>
      _$RecipeTypeFromJson(json);

  Map<String, dynamic> toDatabase() {
    return {
      'id': id,
      'name': name,
      'image_path': imagePath,
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
