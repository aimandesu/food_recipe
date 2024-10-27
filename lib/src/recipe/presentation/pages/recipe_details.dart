import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe/src/core/router/recipe_route.dart';
import 'package:food_recipe/src/core/utils/enum/recipe_enum.dart';
import 'package:food_recipe/src/core/utils/styles/styles.dart';
import 'package:food_recipe/src/recipe/presentation/blocs/recipe/recipe_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:food_recipe/src/recipe/presentation/widgets/stepper.dart';
import 'package:intl/intl.dart';

class RecipeDetails extends StatefulWidget {
  const RecipeDetails({
    super.key,
    required this.id,
  });

  final int id;

  @override
  State<RecipeDetails> createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetails> {
  final ValueNotifier<int> _renderRecipeStep = ValueNotifier<int>(1);

  @override
  void dispose() {
    _renderRecipeStep.dispose();
    super.dispose();
  }

  @override
  void initState() {
    context.read<RecipeBloc>().add(LoadRecipeDetails(recipeId: widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<RecipeBloc, RecipeState>(
        builder: (context, state) {
          if (state.status == RecipeEnum.loading) {
            return const Text('Loading..');
          } else if (state.status == RecipeEnum.loading) {
            return const Text('Error..');
          } else if (state.status == RecipeEnum.completed) {
            return Column(
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * .4,
                  width: MediaQuery.sizeOf(context).width,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      SizedBox(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: state.selectedRecipe.imagePath != null
                              ? Image.memory(
                                  fit: BoxFit.cover,
                                  state.selectedRecipe.imagePath!,
                                )
                              : CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl:
                                      'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg',
                                ),
                        ),
                      ),
                      Align(
                        alignment: const Alignment(-0.9, -0.7),
                        child: IconButton(
                          color: Colors.white,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.cancel,
                            size: 32,
                          ),
                        ),
                      ),
                      Align(
                        alignment: const Alignment(0.9, -0.7),
                        child: IconButton(
                          color: Colors.white,
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                                RecipeRoute.routeAddUpdateRecipe,
                                arguments: {
                                  'recipe': state.selectedRecipe,
                                });
                          },
                          icon: const Icon(
                            Icons.update,
                            size: 32,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.selectedRecipe.title,
                        style: TextStyleShared.textStyle.title.copyWith(
                          fontSize: 30,
                        ),
                      ),
                      Text(
                        DateFormat('d MMMM yyyy').format(
                          DateTime.parse(state.selectedRecipe.createdAt ??
                              DateTime.now().toIso8601String()),
                        ),
                        style: TextStyleShared.textStyle.subtitle.copyWith(),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Ingredients',
                        style: TextStyleShared.textStyle.title,
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: state.ingredients.map((ingredient) {
                          return Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              ingredient.name,
                              style:
                                  TextStyleShared.textStyle.bodyMedium.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Steps to make',
                        style: TextStyleShared.textStyle.title,
                      ),
                      const SizedBox(height: 10),
                      ValueListenableBuilder(
                        valueListenable: _renderRecipeStep,
                        builder: (context, value, child) {
                          if (state.steps.isEmpty) {
                            return const SizedBox.shrink();
                          } else {
                            return Column(
                              children: [
                                ProgressStepper<int>(
                                    enumSelection: state.steps
                                        .map((e) => e.stepNumber)
                                        .toList(),
                                    btnTitles: state.steps
                                        .map((e) => (e.stepNumber).toString())
                                        .toList(),
                                    currentTab: value,
                                    onTapCallbacks: state.steps.map((e) {
                                      return () {
                                        _renderRecipeStep.value = e.stepNumber;
                                      };
                                    }).toList()),
                                Text(
                                  state.steps[_renderRecipeStep.value - 1]
                                      .description,
                                  style: TextStyleShared.textStyle.subtitle,
                                )
                              ],
                            );
                          }
                        },
                      ),
                    ],
                  ),
                )
              ],
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
