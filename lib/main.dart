import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe/src/recipe/data/repository/recipe_repository_impl.dart';
import 'package:food_recipe/src/recipe/presentation/blocs/recipe/recipe_bloc.dart';
import 'package:food_recipe/src/recipe/presentation/blocs/recipe_type/recipe_type_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final recipeTypes = await RecipeRepositoryImpl().getRecipeTypes();

  if (recipeTypes.isEmpty) {
    RecipeRepositoryImpl().populateInitialData();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => RecipeBloc(
              dbHelper: RecipeRepositoryImpl().getDatabaseHelper(),
            )..add(LoadRecipes()),
          ),
          BlocProvider(
            create: (context) => RecipeTypeBloc(
              dbHelper: RecipeRepositoryImpl().getDatabaseHelper(),
            ),
          ),
        ],
        child: const Scaffold(
          body: Test(),
        ),
      ),
    );
  }
}

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(
      builder: (context, state) {
        return Text('${state.recipe}');
      },
    );
  }
}
