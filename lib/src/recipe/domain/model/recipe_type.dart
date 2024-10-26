import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_type.freezed.dart';
part 'recipe_type.g.dart';

@freezed
class RecipeType with _$RecipeType {
  factory RecipeType({
    int? id,
    required final String name,
  }) = _RecipeType;

  factory RecipeType.initial() => RecipeType(name: '');

  factory RecipeType.fromJson(Map<String, dynamic> json) =>
      _$RecipeTypeFromJson(json);
}
