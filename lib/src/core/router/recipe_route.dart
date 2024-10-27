import 'package:flutter/material.dart';
import 'package:food_recipe/src/core/router/route_handler.dart';
import 'package:food_recipe/src/recipe/presentation/pages/add_update_recipe.dart';
import 'package:food_recipe/src/recipe/presentation/pages/homepage.dart';
import 'package:food_recipe/src/recipe/presentation/pages/recipe_details.dart';

class RecipeRoute {
  static const routeRecipe = 'recipe';
  static const routeRecipeDetails = 'recipe_details';
  static const routeAddUpdateRecipe = 'add_update_recipe';

  static Route<dynamic> router(RouteSettings settings) {
    if (!settings.name!.split('/').first.contains(routeRecipe)) {
      return RoutesHandler.handler(settings);
    }

    final List<String> route = settings.name!.split('/:');
    Widget page = const Text('page not found');

    switch (route.first) {
      case routeRecipe:
        page = const Homepage();
        break;
      case routeRecipeDetails:
        final dynamic args = settings.arguments;
        page = RecipeDetails(
          id: args['id'],
        );
      case routeAddUpdateRecipe:
        final dynamic args = settings.arguments;

        page = AddUpdateRecipe(
          recipe: args == null ? null : args['recipe'],
        );

      default:
        page = const Homepage();
    }

    return MaterialPageRoute<dynamic>(
      builder: (context) => page,
      settings: settings,
    );
  }
}
