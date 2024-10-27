import 'package:bloc/bloc.dart';
import 'package:food_recipe/src/core/utils/enum/recipe_type_enum.dart';
import 'package:food_recipe/src/recipe/data/local/db_helper.dart';
import 'package:food_recipe/src/recipe/domain/model/recipe_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_type_event.dart';
part 'recipe_type_state.dart';
part 'recipe_type_bloc.freezed.dart';
part 'recipe_type_bloc.g.dart';

class RecipeTypeBloc extends Bloc<RecipeTypeEvent, RecipeTypeState> {
  final DatabaseHelper _dbHelper;

  RecipeTypeBloc({required DatabaseHelper dbHelper})
      : _dbHelper = dbHelper,
        super(RecipeTypeState.initial()) {
    on<LoadRecipeTypes>(_onLoadRecipeTypes);
    on<AddRecipeType>(_onAddRecipeType);
    on<SelectRecipe>(_selectRecipe);
  }

  Future<void> _selectRecipe(
    SelectRecipe event,
    Emitter emit,
  ) async {
    emit(
      state.copyWith(
        recipeSelected: event.id,
      ),
    );
  }

  Future<void> _onLoadRecipeTypes(
    LoadRecipeTypes event,
    Emitter<RecipeTypeState> emit,
  ) async {
    try {
      emit(state.copyWith(recipeTypeStatus: RecipeTypeEnum.loading));

      final typeMaps = await _dbHelper.getRecipeTypes();
      final types = typeMaps
          .map((map) => RecipeType(
                id: map['id'],
                name: map['name'],
              ))
          .toList();

      emit(state.copyWith(
        recipeTypeStatus: RecipeTypeEnum.completed,
        recipeType: types,
      ));
    } catch (e) {
      emit(state.copyWith(
        recipeTypeStatus: RecipeTypeEnum.error,
        errorMsg: 'Failed to load recipe types: $e',
      ));
    }
  }

  Future<void> _onAddRecipeType(
    AddRecipeType event,
    Emitter<RecipeTypeState> emit,
  ) async {
    try {
      emit(state.copyWith(recipeTypeStatus: RecipeTypeEnum.loading));

      final typeMap = {
        'name': event.recipeType.name,
      };

      await _dbHelper.insertRecipeType(typeMap);

      add(LoadRecipeTypes());
    } catch (e) {
      emit(state.copyWith(
        recipeTypeStatus: RecipeTypeEnum.error,
        errorMsg: 'Failed to add recipe type: $e',
      ));
    }
  }
}
