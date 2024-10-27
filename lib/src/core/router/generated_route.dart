import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_recipe/src/core/router/login_route.dart';
import 'package:food_recipe/src/core/router/recipe_route.dart';
import 'package:food_recipe/src/core/router/route_handler.dart';

Route<dynamic>? generatedRoute(RouteSettings settings) {
  final page = settings.name!;

  log('page: $page');

  if (page == LoginRoute.routeName) {
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => const LoginPage(),
    );
  } else {
    return RoutesHandler.handler(settings);
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: TextButton(
        onPressed: () {
          Navigator.of(context).pushNamed(RecipeRoute.routeRecipe);
        },
        child: const Text('login page'),
      )),
    );
  }
}
