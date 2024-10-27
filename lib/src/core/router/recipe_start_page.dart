import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe/src/core/router/recipe_route.dart';
import 'package:food_recipe/src/recipe/data/repository/recipe_repository_impl.dart';
import 'package:food_recipe/src/recipe/presentation/blocs/recipe/recipe_bloc.dart';
import 'package:food_recipe/src/recipe/presentation/blocs/recipe_type/recipe_type_bloc.dart';

class RecipeStartPage extends StatefulWidget {
  const RecipeStartPage({
    super.key,
    this.startPage = RecipeRoute.routeRecipe,
    this.settings,
  });

  final String startPage;
  final RouteSettings? settings;

  @override
  State<RecipeStartPage> createState() => _RecipeStartPageState();
}

class _RecipeStartPageState extends State<RecipeStartPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RecipeBloc>(
          create: (context) => RecipeBloc(
            dbHelper: RecipeRepositoryImpl().getDatabaseHelper(),
          )..add(LoadRecipes()),
        ),
        BlocProvider<RecipeTypeBloc>(
          create: (context) => RecipeTypeBloc(
            dbHelper: RecipeRepositoryImpl().getDatabaseHelper(),
          )..add(LoadRecipeTypes()),
        ),
      ],
      child: Navigator(
        initialRoute: widget.startPage,
        onGenerateRoute: RecipeRoute.router,
      ),
    );
  }
}
