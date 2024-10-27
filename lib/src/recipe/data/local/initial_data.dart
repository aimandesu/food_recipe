import 'package:food_recipe/src/recipe/data/local/db_helper.dart';
import 'package:food_recipe/src/recipe/domain/model/ingredient.dart';
import 'package:food_recipe/src/recipe/domain/model/recipe.dart';
import 'package:food_recipe/src/recipe/domain/model/recipe_type.dart';
import 'package:food_recipe/src/recipe/domain/model/step.dart';

class InitialData {
  static Future<void> populate(DatabaseHelper dbHelper) async {
    // Populate recipe types
    final recipeTypes = [
      RecipeType(name: 'Breakfast'),
      RecipeType(name: 'Lunch'),
      RecipeType(name: 'Dinner'),
      RecipeType(name: 'Dessert'),
      RecipeType(name: 'Snack'),
    ];

    for (var type in recipeTypes) {
      await dbHelper.insertRecipeType(type.toJson());
    }

    // Example recipe with ingredients and steps
    final breakfast = Recipe(
      typeId: 1, // Breakfast type
      title: 'Classic Pancakes',
      imagePath: null,
    );

    final recipeId = await dbHelper.insertRecipe(breakfast.toJson());

    final ingredients = [
      Ingredient(
          recipeId: recipeId,
          name: 'All-purpose flour',
          quantity: '1.5',
          unit: 'cups'),
      Ingredient(
        recipeId: recipeId,
        name: 'Milk',
        quantity: '1.25',
        unit: 'cups',
      ),
      Ingredient(
        recipeId: recipeId,
        name: 'Egg',
        quantity: '1',
        unit: 'piece',
      ),
      Ingredient(
          recipeId: recipeId,
          name: 'Baking powder',
          quantity: '3.5',
          unit: 'teaspoons'),
      Ingredient(
        recipeId: recipeId,
        name: 'Salt',
        quantity: '1/4',
        unit: 'teaspoon',
      ),
      Ingredient(
        recipeId: recipeId,
        name: 'Sugar',
        quantity: '1',
        unit: 'tablespoon',
      ),
      Ingredient(
        recipeId: recipeId,
        name: 'Melted butter',
        quantity: '3',
        unit: 'tablespoons',
      ),
    ];

    for (var ingredient in ingredients) {
      await dbHelper.insertIngredient(ingredient.toJson());
    }

    final steps = [
      RecipeStep(
        recipeId: recipeId,
        stepNumber: 1,
        description:
            'In a large bowl, whisk together flour, baking powder, salt, and sugar.',
      ),
      RecipeStep(
        recipeId: recipeId,
        stepNumber: 2,
        description:
            'In another bowl, whisk together milk, egg, and melted butter.',
      ),
      RecipeStep(
        recipeId: recipeId,
        stepNumber: 3,
        description:
            'Pour the wet ingredients into the dry ingredients and whisk until just combined. Don\'t overmix; some small lumps are okay.',
      ),
      RecipeStep(
        recipeId: recipeId,
        stepNumber: 4,
        description:
            'Heat a non-stick pan or griddle over medium heat. Lightly grease if needed.',
      ),
      RecipeStep(
        recipeId: recipeId,
        stepNumber: 5,
        description:
            'Pour about 1/4 cup of batter for each pancake. Cook until bubbles form on top.',
      ),
      RecipeStep(
        recipeId: recipeId,
        stepNumber: 6,
        description: 'Flip and cook until golden brown on the other side.',
      ),
    ];

    for (var step in steps) {
      await dbHelper.insertStep(step.toJson());
    }
  }
}
