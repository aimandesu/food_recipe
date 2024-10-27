import 'package:flutter/material.dart';
import 'package:food_recipe/src/core/router/recipe_route.dart';
import 'package:food_recipe/src/core/router/recipe_start_page.dart';

class RoutesHandler {
  RoutesHandler._();

  static const List<String> routes = [
    RecipeRoute.routeRecipe,
  ];

  static Route<dynamic> handler(RouteSettings settings) {
    Widget page = const Text('page not found');
    if (settings.name?.contains(RecipeRoute.routeRecipe) ?? false) {
      page = RecipeStartPage(
        startPage: settings.name!,
        settings: settings,
      );
    }

    return MaterialPageRoute(
      builder: (context) => page,
      settings: settings,
    );
  }
}
