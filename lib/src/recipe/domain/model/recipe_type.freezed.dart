// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipe_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RecipeType _$RecipeTypeFromJson(Map<String, dynamic> json) {
  return _RecipeType.fromJson(json);
}

/// @nodoc
mixin _$RecipeType {
  int? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_path', fromJson: _imageFromJson, toJson: _imageToJson)
  Uint8List? get imagePath => throw _privateConstructorUsedError;

  /// Serializes this RecipeType to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RecipeType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecipeTypeCopyWith<RecipeType> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecipeTypeCopyWith<$Res> {
  factory $RecipeTypeCopyWith(
          RecipeType value, $Res Function(RecipeType) then) =
      _$RecipeTypeCopyWithImpl<$Res, RecipeType>;
  @useResult
  $Res call(
      {int? id,
      String name,
      @JsonKey(
          name: 'image_path', fromJson: _imageFromJson, toJson: _imageToJson)
      Uint8List? imagePath});
}

/// @nodoc
class _$RecipeTypeCopyWithImpl<$Res, $Val extends RecipeType>
    implements $RecipeTypeCopyWith<$Res> {
  _$RecipeTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecipeType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? imagePath = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      imagePath: freezed == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecipeTypeImplCopyWith<$Res>
    implements $RecipeTypeCopyWith<$Res> {
  factory _$$RecipeTypeImplCopyWith(
          _$RecipeTypeImpl value, $Res Function(_$RecipeTypeImpl) then) =
      __$$RecipeTypeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String name,
      @JsonKey(
          name: 'image_path', fromJson: _imageFromJson, toJson: _imageToJson)
      Uint8List? imagePath});
}

/// @nodoc
class __$$RecipeTypeImplCopyWithImpl<$Res>
    extends _$RecipeTypeCopyWithImpl<$Res, _$RecipeTypeImpl>
    implements _$$RecipeTypeImplCopyWith<$Res> {
  __$$RecipeTypeImplCopyWithImpl(
      _$RecipeTypeImpl _value, $Res Function(_$RecipeTypeImpl) _then)
      : super(_value, _then);

  /// Create a copy of RecipeType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? imagePath = freezed,
  }) {
    return _then(_$RecipeTypeImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      imagePath: freezed == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RecipeTypeImpl extends _RecipeType {
  _$RecipeTypeImpl(
      {this.id,
      required this.name,
      @JsonKey(
          name: 'image_path', fromJson: _imageFromJson, toJson: _imageToJson)
      this.imagePath})
      : super._();

  factory _$RecipeTypeImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecipeTypeImplFromJson(json);

  @override
  final int? id;
  @override
  final String name;
  @override
  @JsonKey(name: 'image_path', fromJson: _imageFromJson, toJson: _imageToJson)
  final Uint8List? imagePath;

  @override
  String toString() {
    return 'RecipeType(id: $id, name: $name, imagePath: $imagePath)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecipeTypeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other.imagePath, imagePath));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, const DeepCollectionEquality().hash(imagePath));

  /// Create a copy of RecipeType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecipeTypeImplCopyWith<_$RecipeTypeImpl> get copyWith =>
      __$$RecipeTypeImplCopyWithImpl<_$RecipeTypeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecipeTypeImplToJson(
      this,
    );
  }
}

abstract class _RecipeType extends RecipeType {
  factory _RecipeType(
      {final int? id,
      required final String name,
      @JsonKey(
          name: 'image_path', fromJson: _imageFromJson, toJson: _imageToJson)
      final Uint8List? imagePath}) = _$RecipeTypeImpl;
  _RecipeType._() : super._();

  factory _RecipeType.fromJson(Map<String, dynamic> json) =
      _$RecipeTypeImpl.fromJson;

  @override
  int? get id;
  @override
  String get name;
  @override
  @JsonKey(name: 'image_path', fromJson: _imageFromJson, toJson: _imageToJson)
  Uint8List? get imagePath;

  /// Create a copy of RecipeType
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecipeTypeImplCopyWith<_$RecipeTypeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
