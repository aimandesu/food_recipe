import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe/src/core/router/recipe_route.dart';
import 'package:food_recipe/src/core/utils/enum/recipe_type_enum.dart';
import 'package:food_recipe/src/core/utils/styles/styles.dart';
import 'package:food_recipe/src/recipe/domain/model/recipe_type.dart';
import 'package:food_recipe/src/recipe/presentation/blocs/recipe/recipe_bloc.dart';
import 'package:food_recipe/src/recipe/presentation/blocs/recipe_type/recipe_type_bloc.dart';
import 'package:food_recipe/src/recipe/presentation/widgets/dropdown.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    void onChanged(RecipeType t) {
      context.read<RecipeTypeBloc>().add(
            SelectRecipe(id: t.id ?? 0),
          );
    }

    return BlocBuilder<RecipeTypeBloc, RecipeTypeState>(
      builder: (context, typeState) {
        return Scaffold(
          floatingActionButton: Container(
            decoration: BoxDecoration(
              color: Colors.pink,
              borderRadius: BorderRadius.circular(20),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  RecipeRoute.routeAddUpdateRecipe,
                );
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: const Icon(Icons.menu),
            backgroundColor: Colors.white,
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (typeState.recipeTypeStatus == RecipeTypeEnum.loading) ...[
                  const Text('Loading..'),
                ] else if (typeState.recipeTypeStatus ==
                    RecipeTypeEnum.loading) ...[
                  const Text('Error..'),
                ] else if (typeState.recipeTypeStatus ==
                    RecipeTypeEnum.completed) ...[
                  Text(
                    'What are we cooking today?',
                    style: TextStyleShared.textStyle.title.copyWith(
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        'Popular Recipes',
                        style: TextStyleShared.textStyle.subtitle.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'View All',
                        style: TextStyleShared.textStyle.subtitle.copyWith(
                          color: Colors.pink,
                        ),
                      ),
                    ],
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 150,
                    ),
                    itemCount: typeState.recipeType.take(4).length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 5,
                        color: Colors.white,
                        child: Center(
                          child: Text(
                            typeState.recipeType[index].name,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      );
                    },
                  ),
                  Row(
                    children: [
                      Text(
                        'Other Recipes',
                        style: TextStyleShared.textStyle.subtitle,
                      ),
                      const Spacer(),
                      GenericDropdown<RecipeType>(
                        selectedValue: typeState.recipeType.firstWhere(
                          (e) => e.id == typeState.recipeSelected,
                          orElse: () => typeState.recipeType.first,
                        ),
                        items: typeState.recipeType,
                        itemLabel: (recipe) => recipe.name,
                        onChanged: onChanged,
                        hint: 'Select Recipe Type',
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  BlocBuilder<RecipeBloc, RecipeState>(
                    builder: (context, recipeState) {
                      // Filter the list of recipes based on the selected condition
                      final filteredRecipes = recipeState.recipe
                          .where((e) => typeState.recipeSelected == null
                              ? e.typeId == typeState.recipeType.first.id
                              : e.typeId == typeState.recipeSelected)
                          .toList();

                      return ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: filteredRecipes.length,
                        itemBuilder: (context, index) {
                          final e = filteredRecipes[index];

                          return GestureDetector(
                            onTap: () => Navigator.of(context).pushNamed(
                              RecipeRoute.routeRecipeDetails,
                              arguments: {
                                'id': e.id,
                              },
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(3),
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                width: MediaQuery.sizeOf(context).width,
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(e.title),
                                        Text(e.typeId.toString()),
                                      ],
                                    ),
                                    const Spacer(),
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.red,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  )
                ]
              ],
            ),
          ),
        );
      },
    );
  }
}