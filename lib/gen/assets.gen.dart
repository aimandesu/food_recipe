/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $LibGen {
  const $LibGen();

  /// Directory path: lib/src
  $LibSrcGen get src => const $LibSrcGen();
}

class $LibSrcGen {
  const $LibSrcGen();

  /// Directory path: lib/src/core
  $LibSrcCoreGen get core => const $LibSrcCoreGen();
}

class $LibSrcCoreGen {
  const $LibSrcCoreGen();

  /// Directory path: lib/src/core/images
  $LibSrcCoreImagesGen get images => const $LibSrcCoreImagesGen();
}

class $LibSrcCoreImagesGen {
  const $LibSrcCoreImagesGen();

  /// File path: lib/src/core/images/breakfast.jpg
  AssetGenImage get breakfast =>
      const AssetGenImage('lib/src/core/images/breakfast.jpg');

  /// File path: lib/src/core/images/dessert.jpg
  AssetGenImage get dessert =>
      const AssetGenImage('lib/src/core/images/dessert.jpg');

  /// File path: lib/src/core/images/dinner.jpg
  AssetGenImage get dinner =>
      const AssetGenImage('lib/src/core/images/dinner.jpg');

  /// File path: lib/src/core/images/lunch.jpg
  AssetGenImage get lunch =>
      const AssetGenImage('lib/src/core/images/lunch.jpg');

  /// File path: lib/src/core/images/snack.jpg
  AssetGenImage get snack =>
      const AssetGenImage('lib/src/core/images/snack.jpg');

  /// List of all assets
  List<AssetGenImage> get values => [breakfast, dessert, dinner, lunch, snack];
}

class Assets {
  Assets._();

  static const $LibGen lib = $LibGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
