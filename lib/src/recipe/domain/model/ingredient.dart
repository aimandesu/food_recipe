import 'package:freezed_annotation/freezed_annotation.dart';

part 'ingredient.freezed.dart';
part 'ingredient.g.dart';

@freezed
class Ingredient with _$Ingredient {
  factory Ingredient({
    int? id,
    @JsonKey(name: 'recipe_id') required final int recipeId,
    required final String name,
    required final String quantity,
    String? unit,
  }) = _Ingredient;

  factory Ingredient.initial() => Ingredient(
        recipeId: 0,
        name: '',
        quantity: '',
      );

  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);
}
