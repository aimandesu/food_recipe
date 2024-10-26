// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipe_type_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RecipeTypeState _$RecipeTypeStateFromJson(Map<String, dynamic> json) {
  return _RecipeTypeState.fromJson(json);
}

/// @nodoc
mixin _$RecipeTypeState {
  RecipeTypeEnum get recipeTypeStatus => throw _privateConstructorUsedError;
  List<RecipeType> get recipeType => throw _privateConstructorUsedError;
  String? get errorMsg => throw _privateConstructorUsedError;

  /// Serializes this RecipeTypeState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RecipeTypeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecipeTypeStateCopyWith<RecipeTypeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecipeTypeStateCopyWith<$Res> {
  factory $RecipeTypeStateCopyWith(
          RecipeTypeState value, $Res Function(RecipeTypeState) then) =
      _$RecipeTypeStateCopyWithImpl<$Res, RecipeTypeState>;
  @useResult
  $Res call(
      {RecipeTypeEnum recipeTypeStatus,
      List<RecipeType> recipeType,
      String? errorMsg});
}

/// @nodoc
class _$RecipeTypeStateCopyWithImpl<$Res, $Val extends RecipeTypeState>
    implements $RecipeTypeStateCopyWith<$Res> {
  _$RecipeTypeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecipeTypeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recipeTypeStatus = null,
    Object? recipeType = null,
    Object? errorMsg = freezed,
  }) {
    return _then(_value.copyWith(
      recipeTypeStatus: null == recipeTypeStatus
          ? _value.recipeTypeStatus
          : recipeTypeStatus // ignore: cast_nullable_to_non_nullable
              as RecipeTypeEnum,
      recipeType: null == recipeType
          ? _value.recipeType
          : recipeType // ignore: cast_nullable_to_non_nullable
              as List<RecipeType>,
      errorMsg: freezed == errorMsg
          ? _value.errorMsg
          : errorMsg // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecipeTypeStateImplCopyWith<$Res>
    implements $RecipeTypeStateCopyWith<$Res> {
  factory _$$RecipeTypeStateImplCopyWith(_$RecipeTypeStateImpl value,
          $Res Function(_$RecipeTypeStateImpl) then) =
      __$$RecipeTypeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {RecipeTypeEnum recipeTypeStatus,
      List<RecipeType> recipeType,
      String? errorMsg});
}

/// @nodoc
class __$$RecipeTypeStateImplCopyWithImpl<$Res>
    extends _$RecipeTypeStateCopyWithImpl<$Res, _$RecipeTypeStateImpl>
    implements _$$RecipeTypeStateImplCopyWith<$Res> {
  __$$RecipeTypeStateImplCopyWithImpl(
      _$RecipeTypeStateImpl _value, $Res Function(_$RecipeTypeStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of RecipeTypeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recipeTypeStatus = null,
    Object? recipeType = null,
    Object? errorMsg = freezed,
  }) {
    return _then(_$RecipeTypeStateImpl(
      recipeTypeStatus: null == recipeTypeStatus
          ? _value.recipeTypeStatus
          : recipeTypeStatus // ignore: cast_nullable_to_non_nullable
              as RecipeTypeEnum,
      recipeType: null == recipeType
          ? _value._recipeType
          : recipeType // ignore: cast_nullable_to_non_nullable
              as List<RecipeType>,
      errorMsg: freezed == errorMsg
          ? _value.errorMsg
          : errorMsg // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RecipeTypeStateImpl implements _RecipeTypeState {
  _$RecipeTypeStateImpl(
      {required this.recipeTypeStatus,
      required final List<RecipeType> recipeType,
      this.errorMsg})
      : _recipeType = recipeType;

  factory _$RecipeTypeStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecipeTypeStateImplFromJson(json);

  @override
  final RecipeTypeEnum recipeTypeStatus;
  final List<RecipeType> _recipeType;
  @override
  List<RecipeType> get recipeType {
    if (_recipeType is EqualUnmodifiableListView) return _recipeType;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recipeType);
  }

  @override
  final String? errorMsg;

  @override
  String toString() {
    return 'RecipeTypeState(recipeTypeStatus: $recipeTypeStatus, recipeType: $recipeType, errorMsg: $errorMsg)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecipeTypeStateImpl &&
            (identical(other.recipeTypeStatus, recipeTypeStatus) ||
                other.recipeTypeStatus == recipeTypeStatus) &&
            const DeepCollectionEquality()
                .equals(other._recipeType, _recipeType) &&
            (identical(other.errorMsg, errorMsg) ||
                other.errorMsg == errorMsg));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, recipeTypeStatus,
      const DeepCollectionEquality().hash(_recipeType), errorMsg);

  /// Create a copy of RecipeTypeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecipeTypeStateImplCopyWith<_$RecipeTypeStateImpl> get copyWith =>
      __$$RecipeTypeStateImplCopyWithImpl<_$RecipeTypeStateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecipeTypeStateImplToJson(
      this,
    );
  }
}

abstract class _RecipeTypeState implements RecipeTypeState {
  factory _RecipeTypeState(
      {required final RecipeTypeEnum recipeTypeStatus,
      required final List<RecipeType> recipeType,
      final String? errorMsg}) = _$RecipeTypeStateImpl;

  factory _RecipeTypeState.fromJson(Map<String, dynamic> json) =
      _$RecipeTypeStateImpl.fromJson;

  @override
  RecipeTypeEnum get recipeTypeStatus;
  @override
  List<RecipeType> get recipeType;
  @override
  String? get errorMsg;

  /// Create a copy of RecipeTypeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecipeTypeStateImplCopyWith<_$RecipeTypeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
