import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_recipe/src/core/router/login_route.dart';
import 'package:food_recipe/src/core/router/recipe_route.dart';
import 'package:food_recipe/src/core/router/route_handler.dart';
import 'package:food_recipe/src/user/presentation/pages/login_page.dart';

Route<dynamic>? generatedRoute(RouteSettings settings) {
  final page = settings.name!;

  log('page: $page');

  if (page == LoginRoute.routeLogin) {
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => LoginPage(),
    );
  } else {
    return RoutesHandler.handler(settings);
  }
}
