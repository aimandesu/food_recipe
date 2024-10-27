import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';
import 'package:food_recipe/gen/assets.gen.dart';
import 'package:food_recipe/src/core/helper/db_helper.dart';
import 'package:food_recipe/src/recipe/domain/model/ingredient.dart';
import 'package:food_recipe/src/recipe/domain/model/recipe.dart';
import 'package:food_recipe/src/recipe/domain/model/recipe_type.dart';
import 'package:food_recipe/src/recipe/domain/model/step.dart';
import 'package:sqflite/sqflite.dart';

class InitialData {
  static Future<Uint8List> loadAssetAsUint8List(String path) async {
    ByteData data = await rootBundle.load(path);
    return data.buffer.asUint8List();
  }

  static Future<void> populate(DatabaseHelper dbHelper) async {
    // Load images once and reuse
    final images = {
      'breakfast':
          await loadAssetAsUint8List(Assets.lib.src.core.images.breakfast.path),
      'lunch':
          await loadAssetAsUint8List(Assets.lib.src.core.images.lunch.path),
      'dinner':
          await loadAssetAsUint8List(Assets.lib.src.core.images.dinner.path),
      'dessert':
          await loadAssetAsUint8List(Assets.lib.src.core.images.dessert.path),
      'snack':
          await loadAssetAsUint8List(Assets.lib.src.core.images.snack.path),
    };

    // Recipe type definitions
    final recipeTypes = [
      RecipeType(name: 'Breakfast', imagePath: images['breakfast']!),
      RecipeType(name: 'Lunch', imagePath: images['lunch']!),
      RecipeType(name: 'Dinner', imagePath: images['dinner']!),
      RecipeType(name: 'Dessert', imagePath: images['dessert']!),
      RecipeType(name: 'Snack', imagePath: images['snack']!),
    ];

    // Insert recipe types
    for (var type in recipeTypes) {
      await dbHelper.insertRecipeType(type.toDatabase());
    }

    // Recipe data structure
    final recipeData = {
      'Breakfast': [
        {
          'title': 'Classic Pancakes',
          'ingredients': [
            {'name': 'All-purpose flour', 'quantity': '1.5', 'unit': 'cups'},
            {'name': 'Milk', 'quantity': '1.25', 'unit': 'cups'},
            {'name': 'Egg', 'quantity': '1', 'unit': 'piece'},
            {'name': 'Baking powder', 'quantity': '3.5', 'unit': 'teaspoons'},
            {'name': 'Salt', 'quantity': '0.25', 'unit': 'teaspoon'},
            {'name': 'Sugar', 'quantity': '1', 'unit': 'tablespoon'},
            {'name': 'Melted butter', 'quantity': '3', 'unit': 'tablespoons'},
          ],
          'steps': [
            'In a large bowl, whisk together flour, baking powder, salt, and sugar.',
            'In another bowl, whisk together milk, egg, and melted butter.',
            'Pour the wet ingredients into the dry ingredients and whisk until just combined.',
            'Heat a non-stick pan over medium heat.',
            'Pour batter and cook until bubbles form.',
            'Flip and cook until golden brown.',
          ],
        },
        {
          'title': 'Overnight Oats',
          'ingredients': [
            {'name': 'Rolled oats', 'quantity': '0.5', 'unit': 'cup'},
            {'name': 'Milk', 'quantity': '0.5', 'unit': 'cup'},
            {'name': 'Yogurt', 'quantity': '0.25', 'unit': 'cup'},
            {'name': 'Chia seeds', 'quantity': '1', 'unit': 'tablespoon'},
            {'name': 'Honey', 'quantity': '1', 'unit': 'tablespoon'},
          ],
          'steps': [
            'Combine oats, milk, and yogurt in a jar.',
            'Add chia seeds and honey, stir well.',
            'Cover and refrigerate overnight.',
            'Top with fresh fruits in the morning.',
            'Stir and enjoy cold or warm.',
          ],
        },
        {
          'title': 'Avocado Toast',
          'ingredients': [
            {'name': 'Bread slices', 'quantity': '2', 'unit': 'pieces'},
            {'name': 'Ripe avocado', 'quantity': '1', 'unit': 'piece'},
            {'name': 'Lime juice', 'quantity': '1', 'unit': 'teaspoon'},
            {'name': 'Salt', 'quantity': '0.25', 'unit': 'teaspoon'},
            {
              'name': 'Red pepper flakes',
              'quantity': '0.25',
              'unit': 'teaspoon'
            },
          ],
          'steps': [
            'Toast the bread until golden brown.',
            'Mash the avocado with lime juice and salt.',
            'Spread avocado mixture on toast.',
            'Sprinkle with red pepper flakes.',
            'Serve immediately while warm.',
          ],
        },
        {
          'title': 'Breakfast Smoothie Bowl',
          'ingredients': [
            {'name': 'Frozen berries', 'quantity': '1', 'unit': 'cup'},
            {'name': 'Banana', 'quantity': '1', 'unit': 'piece'},
            {'name': 'Greek yogurt', 'quantity': '0.5', 'unit': 'cup'},
            {'name': 'Almond milk', 'quantity': '0.25', 'unit': 'cup'},
            {'name': 'Granola', 'quantity': '0.25', 'unit': 'cup'},
          ],
          'steps': [
            'Blend frozen berries, banana, yogurt, and milk.',
            'Pour into a bowl.',
            'Top with granola and fresh fruits.',
            'Add honey if desired.',
            'Serve immediately.',
          ],
        },
        {
          'title': 'Breakfast Burrito',
          'ingredients': [
            {'name': 'Eggs', 'quantity': '3', 'unit': 'pieces'},
            {'name': 'Tortillas', 'quantity': '2', 'unit': 'pieces'},
            {'name': 'Cheese', 'quantity': '0.5', 'unit': 'cup'},
            {'name': 'Bell pepper', 'quantity': '0.5', 'unit': 'piece'},
            {'name': 'Onion', 'quantity': '0.25', 'unit': 'piece'},
          ],
          'steps': [
            'Scramble eggs in a pan.',
            'Sauté diced peppers and onions.',
            'Warm tortillas slightly.',
            'Fill tortillas with eggs, vegetables, and cheese.',
            'Roll up and serve hot.',
          ],
        },
      ],
      'Lunch': [
        {
          'title': 'Quinoa Bowl',
          'ingredients': [
            {'name': 'Quinoa', 'quantity': '1', 'unit': 'cup'},
            {'name': 'Chicken breast', 'quantity': '1', 'unit': 'piece'},
            {'name': 'Avocado', 'quantity': '1', 'unit': 'piece'},
            {'name': 'Cherry tomatoes', 'quantity': '1', 'unit': 'cup'},
            {'name': 'Olive oil', 'quantity': '2', 'unit': 'tablespoons'},
          ],
          'steps': [
            'Cook quinoa according to package instructions.',
            'Grill seasoned chicken breast.',
            'Slice avocado and halve tomatoes.',
            'Combine all ingredients in a bowl.',
            'Drizzle with olive oil and serve.',
          ],
        },
        // Add 4 more lunch recipes similarly
      ],
      'Dinner': [
        {
          'title': 'Salmon with Roasted Vegetables',
          'ingredients': [
            {'name': 'Salmon fillet', 'quantity': '6', 'unit': 'ounces'},
            {'name': 'Broccoli', 'quantity': '2', 'unit': 'cups'},
            {'name': 'Carrots', 'quantity': '2', 'unit': 'pieces'},
            {'name': 'Olive oil', 'quantity': '2', 'unit': 'tablespoons'},
            {'name': 'Lemon', 'quantity': '1', 'unit': 'piece'},
          ],
          'steps': [
            'Preheat oven to 400°F.',
            'Season salmon with salt and pepper.',
            'Toss vegetables with olive oil.',
            'Roast vegetables for 20 minutes.',
            'Add salmon and cook for 12 more minutes.',
          ],
        },
        // Add 4 more dinner recipes similarly
      ],
      'Dessert': [
        {
          'title': 'Chocolate Chip Cookies',
          'ingredients': [
            {'name': 'Flour', 'quantity': '2.25', 'unit': 'cups'},
            {'name': 'Butter', 'quantity': '1', 'unit': 'cup'},
            {'name': 'Brown sugar', 'quantity': '0.75', 'unit': 'cup'},
            {'name': 'White sugar', 'quantity': '0.75', 'unit': 'cup'},
            {'name': 'Chocolate chips', 'quantity': '2', 'unit': 'cups'},
          ],
          'steps': [
            'Cream butter and sugars together.',
            'Mix in dry ingredients.',
            'Fold in chocolate chips.',
            'Drop spoonfuls onto baking sheet.',
            'Bake at 375°F for 10 minutes.',
          ],
        },
        // Add 4 more dessert recipes similarly
      ],
      'Snack': [
        {
          'title': 'Trail Mix',
          'ingredients': [
            {'name': 'Almonds', 'quantity': '1', 'unit': 'cup'},
            {'name': 'Cashews', 'quantity': '1', 'unit': 'cup'},
            {'name': 'Dried cranberries', 'quantity': '0.5', 'unit': 'cup'},
            {'name': 'Dark chocolate chips', 'quantity': '0.25', 'unit': 'cup'},
            {'name': 'Pumpkin seeds', 'quantity': '0.25', 'unit': 'cup'},
          ],
          'steps': [
            'Combine all nuts in a large bowl.',
            'Add dried cranberries.',
            'Mix in chocolate chips.',
            'Add pumpkin seeds.',
            'Store in an airtight container.',
          ],
        },
        // Add 4 more snack recipes similarly
      ],
    };

    // Insert recipes, ingredients, and steps
    for (var typeIndex = 0; typeIndex < recipeTypes.length; typeIndex++) {
      final typeName = recipeTypes[typeIndex].name;
      final typeId = typeIndex + 1;
      final recipes = recipeData[typeName]!;

      for (var recipe in recipes) {
        final recipeEntry = Recipe(
          typeId: typeId,
          title: recipe['title'] as String,
          imagePath: images[typeName.toLowerCase()]!,
        );

        final recipeId = await dbHelper.insertRecipe(recipeEntry.toDatabase());

        // Insert ingredients
        for (var ingredient
            in recipe['ingredients'] as List<Map<String, String>>) {
          await dbHelper.insertIngredient(
            Ingredient(
              recipeId: recipeId,
              name: ingredient['name']!,
              quantity: ingredient['quantity']!,
              unit: ingredient['unit']!,
            ).toJson(),
          );
        }

        // Insert steps
        final steps = recipe['steps'] as List<String>;
        for (var i = 0; i < steps.length; i++) {
          await dbHelper.insertStep(
            RecipeStep(
              recipeId: recipeId,
              stepNumber: i + 1,
              description: steps[i],
            ).toJson(),
          );
        }
      }
    }
  }

  static Future<void> seedLoginData(Database db) async {
    // Create some initial users
    final List<Map<String, dynamic>> initialUsers = [
      {
        'username': 'admin',
        'email': 'admin@example.com',
        'password': 'admin123',
        'fullName': 'Admin User'
      },
      {
        'username': 'test_user',
        'email': 'test@example.com',
        'password': 'test123',
        'fullName': 'Test User'
      },
    ];

    for (var userData in initialUsers) {
      final passwordHash =
          sha256.convert(utf8.encode(userData['password'])).toString();

      await db.transaction((txn) async {
        final userId = await txn.insert(
          'users',
          {
            'username': userData['username'],
            'email': userData['email'],
            'password_hash': passwordHash,
          },
        );

        await txn.insert(
          'user_profiles',
          {
            'user_id': userId,
            'full_name': userData['fullName'],
          },
        );
      });
    }
  }
}
