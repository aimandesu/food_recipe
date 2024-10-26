// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipe_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RecipeState _$RecipeStateFromJson(Map<String, dynamic> json) {
  return _RecipeState.fromJson(json);
}

/// @nodoc
mixin _$RecipeState {
  RecipeEnum get status => throw _privateConstructorUsedError;
  List<Recipe> get recipe => throw _privateConstructorUsedError;
  List<Ingredient> get ingredients => throw _privateConstructorUsedError;
  List<Step> get steps => throw _privateConstructorUsedError;
  String? get errorMsg => throw _privateConstructorUsedError;

  /// Serializes this RecipeState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RecipeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecipeStateCopyWith<RecipeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecipeStateCopyWith<$Res> {
  factory $RecipeStateCopyWith(
          RecipeState value, $Res Function(RecipeState) then) =
      _$RecipeStateCopyWithImpl<$Res, RecipeState>;
  @useResult
  $Res call(
      {RecipeEnum status,
      List<Recipe> recipe,
      List<Ingredient> ingredients,
      List<Step> steps,
      String? errorMsg});
}

/// @nodoc
class _$RecipeStateCopyWithImpl<$Res, $Val extends RecipeState>
    implements $RecipeStateCopyWith<$Res> {
  _$RecipeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecipeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? recipe = null,
    Object? ingredients = null,
    Object? steps = null,
    Object? errorMsg = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as RecipeEnum,
      recipe: null == recipe
          ? _value.recipe
          : recipe // ignore: cast_nullable_to_non_nullable
              as List<Recipe>,
      ingredients: null == ingredients
          ? _value.ingredients
          : ingredients // ignore: cast_nullable_to_non_nullable
              as List<Ingredient>,
      steps: null == steps
          ? _value.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as List<Step>,
      errorMsg: freezed == errorMsg
          ? _value.errorMsg
          : errorMsg // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecipeStateImplCopyWith<$Res>
    implements $RecipeStateCopyWith<$Res> {
  factory _$$RecipeStateImplCopyWith(
          _$RecipeStateImpl value, $Res Function(_$RecipeStateImpl) then) =
      __$$RecipeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {RecipeEnum status,
      List<Recipe> recipe,
      List<Ingredient> ingredients,
      List<Step> steps,
      String? errorMsg});
}

/// @nodoc
class __$$RecipeStateImplCopyWithImpl<$Res>
    extends _$RecipeStateCopyWithImpl<$Res, _$RecipeStateImpl>
    implements _$$RecipeStateImplCopyWith<$Res> {
  __$$RecipeStateImplCopyWithImpl(
      _$RecipeStateImpl _value, $Res Function(_$RecipeStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of RecipeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? recipe = null,
    Object? ingredients = null,
    Object? steps = null,
    Object? errorMsg = freezed,
  }) {
    return _then(_$RecipeStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as RecipeEnum,
      recipe: null == recipe
          ? _value._recipe
          : recipe // ignore: cast_nullable_to_non_nullable
              as List<Recipe>,
      ingredients: null == ingredients
          ? _value._ingredients
          : ingredients // ignore: cast_nullable_to_non_nullable
              as List<Ingredient>,
      steps: null == steps
          ? _value._steps
          : steps // ignore: cast_nullable_to_non_nullable
              as List<Step>,
      errorMsg: freezed == errorMsg
          ? _value.errorMsg
          : errorMsg // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RecipeStateImpl implements _RecipeState {
  _$RecipeStateImpl(
      {required this.status,
      required final List<Recipe> recipe,
      required final List<Ingredient> ingredients,
      required final List<Step> steps,
      this.errorMsg})
      : _recipe = recipe,
        _ingredients = ingredients,
        _steps = steps;

  factory _$RecipeStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecipeStateImplFromJson(json);

  @override
  final RecipeEnum status;
  final List<Recipe> _recipe;
  @override
  List<Recipe> get recipe {
    if (_recipe is EqualUnmodifiableListView) return _recipe;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recipe);
  }

  final List<Ingredient> _ingredients;
  @override
  List<Ingredient> get ingredients {
    if (_ingredients is EqualUnmodifiableListView) return _ingredients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ingredients);
  }

  final List<Step> _steps;
  @override
  List<Step> get steps {
    if (_steps is EqualUnmodifiableListView) return _steps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_steps);
  }

  @override
  final String? errorMsg;

  @override
  String toString() {
    return 'RecipeState(status: $status, recipe: $recipe, ingredients: $ingredients, steps: $steps, errorMsg: $errorMsg)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecipeStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._recipe, _recipe) &&
            const DeepCollectionEquality()
                .equals(other._ingredients, _ingredients) &&
            const DeepCollectionEquality().equals(other._steps, _steps) &&
            (identical(other.errorMsg, errorMsg) ||
                other.errorMsg == errorMsg));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      const DeepCollectionEquality().hash(_recipe),
      const DeepCollectionEquality().hash(_ingredients),
      const DeepCollectionEquality().hash(_steps),
      errorMsg);

  /// Create a copy of RecipeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecipeStateImplCopyWith<_$RecipeStateImpl> get copyWith =>
      __$$RecipeStateImplCopyWithImpl<_$RecipeStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecipeStateImplToJson(
      this,
    );
  }
}

abstract class _RecipeState implements RecipeState {
  factory _RecipeState(
      {required final RecipeEnum status,
      required final List<Recipe> recipe,
      required final List<Ingredient> ingredients,
      required final List<Step> steps,
      final String? errorMsg}) = _$RecipeStateImpl;

  factory _RecipeState.fromJson(Map<String, dynamic> json) =
      _$RecipeStateImpl.fromJson;

  @override
  RecipeEnum get status;
  @override
  List<Recipe> get recipe;
  @override
  List<Ingredient> get ingredients;
  @override
  List<Step> get steps;
  @override
  String? get errorMsg;

  /// Create a copy of RecipeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecipeStateImplCopyWith<_$RecipeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
