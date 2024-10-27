import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:food_recipe/src/core/utils/enum/recipe_enum.dart';
import 'package:food_recipe/src/core/helper/db_helper.dart';
import 'package:food_recipe/src/recipe/domain/model/ingredient.dart';
import 'package:food_recipe/src/recipe/domain/model/recipe.dart';
import 'package:food_recipe/src/recipe/domain/model/step.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_bloc.freezed.dart';
part 'recipe_bloc.g.dart';
part 'recipe_event.dart';
part 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final DatabaseHelper _dbHelper;

  RecipeBloc({required DatabaseHelper dbHelper})
      : _dbHelper = dbHelper,
        super(RecipeState.initial()) {
    on<LoadRecipes>(_onLoadRecipes);
    on<AddRecipe>(_onAddRecipe);
    on<UpdateRecipe>(_onUpdateRecipe);
    on<DeleteRecipe>(_onDeleteRecipe);
    on<LoadRecipeDetails>(_onLoadRecipeDetails);
  }

  Future<void> _onLoadRecipes(
    LoadRecipes event,
    Emitter<RecipeState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          status: RecipeEnum.loading,
        ),
      );

      final recipeMaps = await _dbHelper.getRecipes(typeId: event.typeId);
      final recipes = recipeMaps.map((map) {
        return Recipe(
          id: map['id'],
          typeId: map['type_id'],
          title: map['title'],
          imagePath: map['image_path'],
          createdAt: map['created_at'],
          updatedAt: map['updated_at'],
        );
      }).toList();

      emit(
        state.copyWith(
          status: RecipeEnum.completed,
          recipe: recipes,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: RecipeEnum.error,
          errorMsg: 'Failed to load recipes: $e',
        ),
      );
    }
  }

  Future<void> _onAddRecipe(
    AddRecipe event,
    Emitter<RecipeState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          status: RecipeEnum.loading,
        ),
      );

      // Convert Recipe to Map
      final recipeMap = {
        'type_id': event.recipe.typeId,
        'title': event.recipe.title,
        'image_path': event.recipe.imagePath,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      };

      // Insert recipe and get its ID
      final recipeId = await _dbHelper.insertRecipe(recipeMap);

      // Insert ingredients
      for (var ingredient in event.ingredients) {
        final ingredientMap = {
          'recipe_id': recipeId,
          'name': ingredient.name,
          'quantity': ingredient.quantity,
          'unit': ingredient.unit,
        };
        await _dbHelper.insertIngredient(ingredientMap);
      }

      // Insert steps
      for (var step in event.steps) {
        final stepMap = {
          'recipe_id': recipeId,
          'step_number': step.stepNumber,
          'description': step.description,
        };
        await _dbHelper.insertStep(stepMap);
      }

      emit(
        state.copyWith(
          status: RecipeEnum.completed,
          errorMsg: 'Recipe added successfully',
        ),
      );

      add(LoadRecipes());
    } catch (e) {
      emit(
        state.copyWith(
          status: RecipeEnum.error,
          errorMsg: 'Failed to add recipe: $e',
        ),
      );
    }
  }

  Future<void> _onUpdateRecipe(
    UpdateRecipe event,
    Emitter<RecipeState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          status: RecipeEnum.loading,
        ),
      );

      // Convert Recipe to Map
      final recipeMap = {
        'id': event.recipe.id,
        'type_id': event.recipe.typeId,
        'title': event.recipe.title,
        'image_path': event.recipe.imagePath,
        'updated_at': DateTime.now().toIso8601String(),
      };

      // Update recipe
      await _dbHelper.updateRecipe(recipeMap);

      // Delete existing ingredients and steps
      final ingredients = await _dbHelper.getIngredients(event.recipe.id!);
      final steps = await _dbHelper.getSteps(event.recipe.id!);

      for (var ingredient in ingredients) {
        await _dbHelper.deleteIngredient(ingredient['id']);
      }

      for (var step in steps) {
        await _dbHelper.deleteStep(step['id']);
      }

      // Insert new ingredients and steps
      for (var ingredient in event.ingredients) {
        final ingredientMap = {
          'recipe_id': event.recipe.id,
          'name': ingredient.name,
          'quantity': ingredient.quantity,
          'unit': ingredient.unit,
        };
        await _dbHelper.insertIngredient(ingredientMap);
      }

      for (var step in event.steps) {
        final stepMap = {
          'recipe_id': event.recipe.id,
          'step_number': step.stepNumber,
          'description': step.description,
        };
        await _dbHelper.insertStep(stepMap);
      }

      emit(
        state.copyWith(
          status: RecipeEnum.completed,
          errorMsg: 'Recipe updated successfully',
        ),
      );

      add(
        LoadRecipeDetails(recipeId: event.recipe.id!),
      );
      add(LoadRecipes());
    } catch (e) {
      emit(
        state.copyWith(
          status: RecipeEnum.error,
          errorMsg: 'Failed to update recipe: $e',
        ),
      );
    }
  }

  Future<void> _onLoadRecipeDetails(
    LoadRecipeDetails event,
    Emitter<RecipeState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          status: RecipeEnum.loading,
        ),
      );

      final recipeMap = await _dbHelper.getRecipe(event.recipeId);
      if (recipeMap == null) {
        emit(state.copyWith(
          status: RecipeEnum.error,
          errorMsg: 'Recipe not found',
        ));
        return;
      }

      // Load ingredients
      final ingredientMaps = await _dbHelper.getIngredients(event.recipeId);
      final ingredients = ingredientMaps
          .map((map) => Ingredient(
                id: map['id'],
                recipeId: map['recipe_id'],
                name: map['name'],
                quantity: map['quantity'],
                unit: map['unit'],
              ))
          .toList();

      // Load steps
      final stepMaps = await _dbHelper.getSteps(event.recipeId);
      final steps = stepMaps
          .map((map) => RecipeStep(
                id: map['id'],
                recipeId: map['recipe_id'],
                stepNumber: map['step_number'],
                description: map['description'],
              ))
          .toList();

      // Create recipe with all details
      final recipe = Recipe(
        id: recipeMap['id'],
        typeId: recipeMap['type_id'],
        title: recipeMap['title'],
        imagePath: recipeMap['image_path'],
        createdAt: recipeMap['created_at'],
        updatedAt: recipeMap['updated_at'],
      );

      emit(
        state.copyWith(
          // recipe: [recipe],
          selectedRecipe: recipe,
          ingredients: ingredients,
          steps: steps,
          status: RecipeEnum.completed,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: RecipeEnum.error,
          errorMsg: 'Failed to load recipe details: $e',
        ),
      );
    }
  }

  Future<void> _onDeleteRecipe(
    DeleteRecipe event,
    Emitter<RecipeState> emit,
  ) async {
    try {
      emit(state.copyWith(status: RecipeEnum.loading));

      await _dbHelper.deleteRecipe(event.recipeId);

      emit(state.copyWith(
        status: RecipeEnum.completed,
        errorMsg: 'Recipe deleted successfully',
      ));

      add(LoadRecipes());
    } catch (e) {
      emit(state.copyWith(
        status: RecipeEnum.error,
        errorMsg: 'Failed to delete recipe: $e',
      ));
    }
  }
}
