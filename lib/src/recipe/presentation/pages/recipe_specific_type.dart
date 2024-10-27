import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe/src/core/router/recipe_route.dart';
import 'package:food_recipe/src/recipe/presentation/blocs/recipe/recipe_bloc.dart';
import 'package:intl/intl.dart';

class RecipeSpecificType extends StatelessWidget {
  const RecipeSpecificType({
    super.key,
    this.id,
    required this.title,
  });

  final int? id;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(title),
      ),
      body: BlocBuilder<RecipeBloc, RecipeState>(
        builder: (context, recipeState) {
          final filteredRecipes = id == null
              ? recipeState.recipe
              : recipeState.recipe.where((e) => e.typeId == id).toList();

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: filteredRecipes.length,
            itemBuilder: (context, index) {
              final recipe = filteredRecipes[index];

              return GestureDetector(
                onTap: () => Navigator.of(context).pushNamed(
                  RecipeRoute.routeRecipeDetails,
                  arguments: {'id': recipe.id},
                ),
                child: Card(
                  color: Colors.white,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        // Display recipe image if available, else fallback to a placeholder
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: recipe.imagePath != null
                              ? Image.memory(
                                  recipe.imagePath!,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  width: 80,
                                  height: 80,
                                  color: Colors.grey[300],
                                  child: const Icon(
                                    Icons.fastfood,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                recipe.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              // Display the formatted creation date
                              if (recipe.createdAt != null)
                                Text(
                                  "Created: ${_formatDate(recipe.createdAt!)}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.pink,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  String _formatDate(String date) {
    final dateTime = DateTime.parse(date);
    return DateFormat.yMMMd().format(dateTime);
  }
}
