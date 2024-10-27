import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/painting/text_style.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyleShared {
  TextStyleShared._();

  static const TextStyleVariationBak textStyle = TextStyleVariationBak();
}

class TextStyleVariationBak {
  const TextStyleVariationBak();

  TextStyle get title => GoogleFonts.roboto().copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      );

  TextStyle get subtitle => GoogleFonts.roboto().copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      );

  TextStyle get bodyMedium => GoogleFonts.roboto().copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      );

  TextStyle get bodySmall => GoogleFonts.roboto().copyWith(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      );

  TextStyle get button => GoogleFonts.roboto(
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      );
}
