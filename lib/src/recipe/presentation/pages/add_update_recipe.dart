import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe/src/core/utils/styles/styles.dart';
import 'package:food_recipe/src/recipe/domain/model/ingredient.dart';
import 'package:food_recipe/src/recipe/domain/model/recipe.dart';
import 'package:food_recipe/src/recipe/domain/model/recipe_type.dart';
import 'package:food_recipe/src/recipe/domain/model/step.dart';
import 'package:food_recipe/src/recipe/presentation/blocs/recipe/recipe_bloc.dart';
import 'package:food_recipe/src/recipe/presentation/blocs/recipe_type/recipe_type_bloc.dart';
import 'package:food_recipe/src/recipe/presentation/widgets/dropdown.dart';
import 'package:food_recipe/src/recipe/presentation/widgets/textform_field.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'dart:io';

class AddUpdateRecipe extends StatefulWidget {
  const AddUpdateRecipe({
    super.key,
    this.recipe,
  });

  final Recipe? recipe;

  @override
  State<AddUpdateRecipe> createState() => _AddUpdateRecipeState();
}

class _AddUpdateRecipeState extends State<AddUpdateRecipe> {
  final TextEditingController typeIdController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final ValueNotifier<Uint8List> imagePath =
      ValueNotifier<Uint8List>(Uint8List(0));

  final List<Ingredient> _ingredients = [Ingredient.initial()];
  final List<RecipeStep> _steps = [RecipeStep.initial()];

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.recipe != null) {
      _removeIngredient(0);
      _removeStep(0);

      typeIdController.text = widget.recipe?.typeId.toString() ?? '';
      titleController.text = widget.recipe?.title ?? '';
      imagePath.value = widget.recipe?.imagePath ?? Uint8List(0);

      //the reason this works because how we structure the code
      _ingredients.addAll(context.read<RecipeBloc>().state.ingredients);
      _steps.addAll(context.read<RecipeBloc>().state.steps);
    }
    super.initState();
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final recipe = Recipe(
        id: widget.recipe != null ? widget.recipe?.id ?? 0 : null,
        typeId: int.parse(typeIdController.text),
        title: titleController.text,
        imagePath: imagePath.value,
      );

      final ingredients = _ingredients.map((ingredient) {
        return ingredient.copyWith(recipeId: recipe.id ?? 0);
      }).toList();

      final steps = _steps.asMap().entries.map((entry) {
        return entry.value.copyWith(
          recipeId: recipe.id ?? 0,
          stepNumber: entry.key + 1,
        );
      }).toList();

      if (widget.recipe == null) {
        context.read<RecipeBloc>().add(
              AddRecipe(
                recipe: recipe,
                ingredients: ingredients,
                steps: steps,
              ),
            );
      } else {
        context.read<RecipeBloc>().add(
              UpdateRecipe(
                recipe: recipe,
                ingredients: ingredients,
                steps: steps,
              ),
            );
      }
      Navigator.of(context).pop();
    }
  }

  Future<void> pickAndStoreImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      File imageFile = File(image.path);
      Uint8List imageBytes = await imageFile.readAsBytes();
      imagePath.value = imageBytes;
    }
  }

  void onChanged(RecipeType t) {
    context.read<RecipeTypeBloc>().add(
          SelectRecipe(id: t.id ?? 0),
        );
    typeIdController.text = t.id.toString();
  }

  @override
  void dispose() {
    typeIdController.dispose();
    titleController.dispose();
    imagePath.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: widget.recipe != null
            ? const Text('Update Recipe')
            : const Text('Add Recipe'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pick Type',
                  style: TextStyleShared.textStyle.subtitle,
                ),
                const SizedBox(height: 5),
                BlocBuilder<RecipeTypeBloc, RecipeTypeState>(
                  builder: (context, typeState) {
                    return SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      child: GenericDropdown<RecipeType>(
                        selectedValue: typeState.recipeType.firstWhere(
                          (e) {
                            typeIdController.text =
                                typeState.recipeSelected.toString();

                            return e.id == typeState.recipeSelected;
                          },
                          orElse: () {
                            typeIdController.text =
                                typeState.recipeType.first.id.toString();

                            return typeState.recipeType.first;
                          },
                        ),
                        items: typeState.recipeType,
                        itemLabel: (recipe) => recipe.name,
                        onChanged: onChanged,
                        hint: 'Select Recipe Type',
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  controller: titleController,
                  title: 'Recipe Title',
                  hintText: 'Recipe Title',
                  textStyleTitle: TextStyleShared.textStyle.subtitle.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    pickAndStoreImage();
                  },
                  child: ValueListenableBuilder(
                    valueListenable: imagePath,
                    builder: (context, val, child) {
                      if (val.isEmpty) {
                        return AbsorbPointer(
                          child: CustomTextFormField(
                            readOnly: true,
                            title: 'Upload Image',
                            hintText: 'Upload Image',
                            textStyleTitle:
                                TextStyleShared.textStyle.subtitle.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                        );
                      } else {
                        return Stack(
                          children: [
                            SizedBox(
                              height: 250,
                              width: MediaQuery.sizeOf(context).width,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.memory(fit: BoxFit.cover, val)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.pink,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.update,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),

                // Ingredients Section
                _buildIngredientsList(),
                // Add Ingredient Button
                const SizedBox(height: 24),

                // Steps Section
                _buildStepsList(),
                const SizedBox(height: 24),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: _submitForm,
                    child: const Text('Submit'),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIngredientsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Ingredients',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            IconButton(
              onPressed: _addIngredient,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _ingredients.length,
          itemBuilder: (context, index) {
            return Card(
              key: ValueKey(_ingredients[index].id),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        initialValue: _ingredients[index].name,
                        decoration: const InputDecoration(labelText: 'Name'),
                        onChanged: (value) {
                          setState(() {
                            _ingredients[index] = _ingredients[index].copyWith(
                              name: value,
                            );
                          });
                        },
                        validator: (value) =>
                            value?.isEmpty ?? true ? 'Required' : null,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        initialValue: _ingredients[index].quantity,
                        decoration:
                            const InputDecoration(labelText: 'Quantity'),
                        onChanged: (value) {
                          setState(() {
                            _ingredients[index] = _ingredients[index].copyWith(
                              quantity: value,
                            );
                          });
                        },
                        validator: (value) =>
                            value?.isEmpty ?? true ? 'Required' : null,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        initialValue: _ingredients[index].unit,
                        decoration: const InputDecoration(labelText: 'Unit'),
                        onChanged: (value) {
                          setState(() {
                            _ingredients[index] = _ingredients[index].copyWith(
                              unit: value,
                            );
                          });
                        },
                        validator: (value) =>
                            value?.isEmpty ?? true ? 'Required' : null,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _removeIngredient(index),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildStepsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Steps',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            IconButton(
              onPressed: _addStep,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _steps.length,
          itemBuilder: (context, index) {
            return Card(
              key: ValueKey(_steps[index].id),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      child: Text('${index + 1}'),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextFormField(
                        initialValue: _steps[index].description,
                        decoration: const InputDecoration(
                          labelText: 'Step Description',
                        ),
                        maxLines: 3,
                        onChanged: (value) {
                          setState(() {
                            _steps[index] = _steps[index].copyWith(
                              description: value,
                              stepNumber: index + 1,
                            );
                          });
                        },
                        validator: (value) =>
                            value?.isEmpty ?? true ? 'Required' : null,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _removeStep(index),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  void _addIngredient() {
    setState(() {
      _ingredients.add(Ingredient.initial());
    });
  }

  void _removeIngredient(int index) {
    setState(() {
      _ingredients.removeAt(index);
    });
  }

  void _addStep() {
    setState(() {
      _steps.add(RecipeStep.initial());
    });
  }

  void _removeStep(int index) {
    setState(() {
      _steps.removeAt(index);
    });
  }
}
