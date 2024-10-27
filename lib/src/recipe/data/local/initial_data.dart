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
        {
          'title': 'Grilled Cheese Sandwich',
          'ingredients': [
            {'name': 'Bread slices', 'quantity': '2', 'unit': 'pieces'},
            {'name': 'Cheddar cheese', 'quantity': '2', 'unit': 'slices'},
            {'name': 'Butter', 'quantity': '1', 'unit': 'tablespoon'},
          ],
          'steps': [
            'Butter the bread slices on one side.',
            'Place cheese between the bread slices, buttered side out.',
            'Cook in a skillet over medium heat until golden brown on both sides.',
          ],
        },
        {
          'title': 'Caesar Salad',
          'ingredients': [
            {'name': 'Romaine lettuce', 'quantity': '1', 'unit': 'head'},
            {'name': 'Croutons', 'quantity': '0.5', 'unit': 'cup'},
            {'name': 'Parmesan cheese', 'quantity': '0.25', 'unit': 'cup'},
            {'name': 'Caesar dressing', 'quantity': '3', 'unit': 'tablespoons'},
          ],
          'steps': [
            'Chop the romaine lettuce and place in a large bowl.',
            'Add croutons and Parmesan cheese.',
            'Drizzle with Caesar dressing and toss to combine.',
          ],
        },
        {
          'title': 'Tuna Salad Wrap',
          'ingredients': [
            {'name': 'Tuna', 'quantity': '1', 'unit': 'can'},
            {'name': 'Mayonnaise', 'quantity': '2', 'unit': 'tablespoons'},
            {'name': 'Celery', 'quantity': '0.25', 'unit': 'cup'},
            {'name': 'Tortilla', 'quantity': '1', 'unit': 'piece'},
          ],
          'steps': [
            'Mix tuna, mayonnaise, and diced celery in a bowl.',
            'Spoon the mixture onto a tortilla.',
            'Wrap up and serve cold.',
          ],
        },
        {
          'title': 'Vegetable Stir-fry',
          'ingredients': [
            {'name': 'Broccoli', 'quantity': '1', 'unit': 'cup'},
            {'name': 'Carrots', 'quantity': '1', 'unit': 'piece'},
            {'name': 'Soy sauce', 'quantity': '2', 'unit': 'tablespoons'},
            {'name': 'Garlic', 'quantity': '1', 'unit': 'clove'},
          ],
          'steps': [
            'Sauté garlic in a pan.',
            'Add vegetables and stir-fry until tender.',
            'Add soy sauce and stir until well coated.',
            'Serve with rice or noodles.',
          ],
        },
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
        {
          'title': 'Spaghetti Bolognese',
          'ingredients': [
            {'name': 'Ground beef', 'quantity': '1', 'unit': 'pound'},
            {'name': 'Spaghetti', 'quantity': '12', 'unit': 'ounces'},
            {'name': 'Tomato sauce', 'quantity': '1', 'unit': 'cup'},
            {'name': 'Onion', 'quantity': '1', 'unit': 'piece'},
            {'name': 'Garlic', 'quantity': '2', 'unit': 'cloves'},
          ],
          'steps': [
            'Cook spaghetti according to package instructions.',
            'Sauté onion and garlic until translucent.',
            'Add ground beef and cook until browned.',
            'Stir in tomato sauce and simmer for 15 minutes.',
            'Serve the sauce over the spaghetti.',
          ],
        },
        {
          'title': 'Chicken Stir-fry',
          'ingredients': [
            {'name': 'Chicken breast', 'quantity': '1', 'unit': 'piece'},
            {'name': 'Bell pepper', 'quantity': '1', 'unit': 'piece'},
            {'name': 'Soy sauce', 'quantity': '2', 'unit': 'tablespoons'},
            {'name': 'Garlic', 'quantity': '1', 'unit': 'clove'},
          ],
          'steps': [
            'Sauté garlic in a pan.',
            'Add sliced chicken breast and cook until browned.',
            'Add bell peppers and stir-fry for 5 minutes.',
            'Add soy sauce and cook for 2 more minutes.',
            'Serve hot with rice.',
          ],
        },
        {
          'title': 'Beef Tacos',
          'ingredients': [
            {'name': 'Ground beef', 'quantity': '1', 'unit': 'pound'},
            {'name': 'Taco shells', 'quantity': '6', 'unit': 'pieces'},
            {'name': 'Cheese', 'quantity': '0.5', 'unit': 'cup'},
            {'name': 'Lettuce', 'quantity': '1', 'unit': 'cup'},
            {'name': 'Tomato', 'quantity': '1', 'unit': 'piece'},
          ],
          'steps': [
            'Cook ground beef in a pan until browned.',
            'Warm the taco shells in the oven.',
            'Assemble tacos with beef, cheese, lettuce, and tomato.',
            'Serve with salsa and sour cream.',
          ],
        },
        {
          'title': 'Vegetarian Lasagna',
          'ingredients': [
            {'name': 'Lasagna noodles', 'quantity': '9', 'unit': 'pieces'},
            {'name': 'Ricotta cheese', 'quantity': '1', 'unit': 'cup'},
            {'name': 'Mozzarella cheese', 'quantity': '1', 'unit': 'cup'},
            {'name': 'Spinach', 'quantity': '2', 'unit': 'cups'},
            {'name': 'Tomato sauce', 'quantity': '1.5', 'unit': 'cups'},
          ],
          'steps': [
            'Preheat oven to 375°F.',
            'Cook lasagna noodles according to package instructions.',
            'Layer noodles, ricotta, spinach, and sauce in a baking dish.',
            'Top with mozzarella cheese.',
            'Bake for 25-30 minutes until bubbly.',
          ],
        },
      ],
      'Dessert': [
        {
          'title': 'Chocolate Brownies',
          'ingredients': [
            {'name': 'Butter', 'quantity': '0.5', 'unit': 'cup'},
            {'name': 'Sugar', 'quantity': '1', 'unit': 'cup'},
            {'name': 'Cocoa powder', 'quantity': '0.33', 'unit': 'cup'},
            {'name': 'Eggs', 'quantity': '2', 'unit': 'pieces'},
            {'name': 'Vanilla extract', 'quantity': '1', 'unit': 'teaspoon'},
            {'name': 'Flour', 'quantity': '0.5', 'unit': 'cup'},
          ],
          'steps': [
            'Preheat oven to 350°F (175°C).',
            'Melt butter and mix in sugar and cocoa powder.',
            'Add eggs and vanilla, stirring until smooth.',
            'Fold in flour and pour into a greased baking pan.',
            'Bake for 20-25 minutes and cool before cutting.',
          ],
        },
        {
          'title': 'Cheesecake',
          'ingredients': [
            {'name': 'Cream cheese', 'quantity': '16', 'unit': 'ounces'},
            {'name': 'Sugar', 'quantity': '0.75', 'unit': 'cup'},
            {'name': 'Eggs', 'quantity': '3', 'unit': 'pieces'},
            {'name': 'Vanilla extract', 'quantity': '1', 'unit': 'teaspoon'},
            {'name': 'Graham cracker crust', 'quantity': '1', 'unit': 'piece'},
          ],
          'steps': [
            'Preheat oven to 325°F (160°C).',
            'Beat cream cheese and sugar until smooth.',
            'Add eggs and vanilla, mix until well combined.',
            'Pour mixture into crust and bake for 45 minutes.',
            'Cool before refrigerating for at least 4 hours.',
          ],
        },
        {
          'title': 'Apple Pie',
          'ingredients': [
            {'name': 'Apples', 'quantity': '6', 'unit': 'pieces'},
            {'name': 'Sugar', 'quantity': '0.75', 'unit': 'cup'},
            {'name': 'Cinnamon', 'quantity': '1', 'unit': 'teaspoon'},
            {'name': 'Flour', 'quantity': '2', 'unit': 'tablespoons'},
            {'name': 'Pie crust', 'quantity': '1', 'unit': 'piece'},
          ],
          'steps': [
            'Preheat oven to 375°F (190°C).',
            'Peel and slice apples, then toss with sugar, cinnamon, and flour.',
            'Place mixture into pie crust and top with another crust.',
            'Bake for 50-60 minutes until golden brown.',
            'Let cool before serving.',
          ],
        },
        {
          'title': 'Lemon Bars',
          'ingredients': [
            {'name': 'Butter', 'quantity': '1', 'unit': 'cup'},
            {'name': 'Sugar', 'quantity': '1.5', 'unit': 'cups'},
            {'name': 'Lemon juice', 'quantity': '0.5', 'unit': 'cup'},
            {'name': 'Flour', 'quantity': '2', 'unit': 'cups'},
            {'name': 'Eggs', 'quantity': '4', 'unit': 'pieces'},
          ],
          'steps': [
            'Preheat oven to 350°F (175°C).',
            'Mix flour and butter to form crust, press into a pan, and bake for 20 minutes.',
            'Whisk sugar, eggs, and lemon juice together.',
            'Pour over the crust and bake for another 20 minutes.',
            'Cool and cut into bars.',
          ],
        },
        {
          'title': 'Tiramisu',
          'ingredients': [
            {'name': 'Mascarpone cheese', 'quantity': '1', 'unit': 'cup'},
            {'name': 'Heavy cream', 'quantity': '1', 'unit': 'cup'},
            {'name': 'Coffee', 'quantity': '1', 'unit': 'cup'},
            {'name': 'Ladyfingers', 'quantity': '24', 'unit': 'pieces'},
            {'name': 'Cocoa powder', 'quantity': '2', 'unit': 'tablespoons'},
          ],
          'steps': [
            'Whisk mascarpone and cream until smooth.',
            'Dip ladyfingers in coffee and layer them in a dish.',
            'Spread mascarpone mixture over ladyfingers and repeat layers.',
            'Dust with cocoa powder and refrigerate for at least 4 hours.',
          ],
        }
      ],
      'Snack': [
        {
          'title': 'Hummus and Veggie Platter',
          'ingredients': [
            {'name': 'Chickpeas', 'quantity': '1', 'unit': 'cup'},
            {'name': 'Tahini', 'quantity': '0.25', 'unit': 'cup'},
            {'name': 'Lemon juice', 'quantity': '2', 'unit': 'tablespoons'},
            {'name': 'Olive oil', 'quantity': '2', 'unit': 'tablespoons'},
            {'name': 'Garlic', 'quantity': '1', 'unit': 'clove'},
            {'name': 'Carrot sticks', 'quantity': '1', 'unit': 'cup'},
            {'name': 'Cucumber slices', 'quantity': '1', 'unit': 'cup'},
          ],
          'steps': [
            'Blend chickpeas, tahini, lemon juice, olive oil, and garlic until smooth.',
            'Serve with carrot sticks and cucumber slices for dipping.',
          ],
        },
        {
          'title': 'Fruit Salad',
          'ingredients': [
            {'name': 'Strawberries', 'quantity': '1', 'unit': 'cup'},
            {'name': 'Blueberries', 'quantity': '0.5', 'unit': 'cup'},
            {'name': 'Kiwi', 'quantity': '2', 'unit': 'pieces'},
            {'name': 'Orange juice', 'quantity': '0.25', 'unit': 'cup'},
            {'name': 'Honey', 'quantity': '1', 'unit': 'tablespoon'},
          ],
          'steps': [
            'Chop strawberries and kiwi into bite-sized pieces.',
            'Mix with blueberries in a large bowl.',
            'Drizzle with orange juice and honey, toss gently to combine.',
            'Serve chilled.',
          ],
        },
        {
          'title': 'Popcorn',
          'ingredients': [
            {'name': 'Popcorn kernels', 'quantity': '0.5', 'unit': 'cup'},
            {'name': 'Olive oil', 'quantity': '2', 'unit': 'tablespoons'},
            {'name': 'Salt', 'quantity': '0.5', 'unit': 'teaspoon'},
          ],
          'steps': [
            'Heat olive oil in a large pot.',
            'Add popcorn kernels and cover with a lid.',
            'Shake pot occasionally until popping slows down.',
            'Remove from heat and season with salt.',
          ],
        },
        {
          'title': 'Yogurt Parfait',
          'ingredients': [
            {'name': 'Greek yogurt', 'quantity': '1', 'unit': 'cup'},
            {'name': 'Granola', 'quantity': '0.5', 'unit': 'cup'},
            {'name': 'Honey', 'quantity': '1', 'unit': 'tablespoon'},
            {'name': 'Fresh berries', 'quantity': '0.5', 'unit': 'cup'},
          ],
          'steps': [
            'Layer Greek yogurt, granola, and fresh berries in a glass or bowl.',
            'Drizzle with honey and serve immediately.',
          ],
        },
        {
          'title': 'Stuffed Dates',
          'ingredients': [
            {'name': 'Medjool dates', 'quantity': '10', 'unit': 'pieces'},
            {'name': 'Almonds', 'quantity': '10', 'unit': 'pieces'},
            {'name': 'Cream cheese', 'quantity': '0.25', 'unit': 'cup'},
          ],
          'steps': [
            'Slice dates open and remove pits.',
            'Stuff each date with an almond and cream cheese.',
            'Serve as a quick and healthy snack.',
          ],
        }
      ]
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
