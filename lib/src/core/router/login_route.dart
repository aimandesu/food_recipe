import 'package:flutter/material.dart';
import 'package:food_recipe/src/user/presentation/pages/login_page.dart';
import 'package:food_recipe/src/user/presentation/pages/sign_up.dart';

class LoginRoute {
  static const routeLogin = '/login_route';
  static const routeSignUp = '/sign_up';

  static Route<dynamic> router(RouteSettings settings) {
    final List<String> route = settings.name!.split('/:');
    Widget page = const Text('page not found');

    switch (route.first) {
      case routeLogin:
        page = LoginPage();
        break;

      case routeSignUp:
        final dynamic args = settings.arguments;

        page = const SignUp();

      default:
        page = LoginPage();
    }

    return MaterialPageRoute<dynamic>(
      builder: (context) => page,
      settings: settings,
    );
  }
}
