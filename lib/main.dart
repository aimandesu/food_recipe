import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe/src/core/helper/db_helper.dart';
import 'package:food_recipe/src/core/router/generated_route.dart';
import 'package:food_recipe/src/core/router/login_route.dart';
import 'package:food_recipe/src/core/router/recipe_route.dart';
import 'package:food_recipe/src/recipe/data/repository/recipe_repository_impl.dart';
import 'package:food_recipe/src/recipe/presentation/blocs/recipe/recipe_bloc.dart';
import 'package:food_recipe/src/recipe/presentation/blocs/recipe_type/recipe_type_bloc.dart';
import 'package:food_recipe/src/recipe/presentation/pages/homepage.dart';
import 'package:food_recipe/src/user/data/repository/auth_repository_impl.dart';
import 'package:food_recipe/src/user/presentation/blocs/authentication/auth_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final db = await DatabaseHelper().database;
  final prefs = await SharedPreferences.getInstance();

  final recipeTypes = await RecipeRepositoryImpl().getRecipeTypes();

  final authRepository = AuthRepositoryImpl(db, prefs);

  if (recipeTypes.isEmpty) {
    RecipeRepositoryImpl().populateRecipeData();
    authRepository.populateUserData();
  }

  runApp(
    BlocProvider<AuthBloc>(
      create: (context) =>
          AuthBloc(authRepository)..add(CheckAuthStatusEvent()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink.shade200),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: generatedRoute,
      initialRoute: LoginRoute.routeLogin,
    );
  }
}
