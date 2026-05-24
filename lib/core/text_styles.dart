import 'package:flutter/material.dart';
import 'color_constants.dart';

class AppTextStyles {
  AppTextStyles._();

  // Pacifico
  static const TextStyle brandTitle = TextStyle(
    fontFamily: 'Pacifico',
    fontSize: 28,
    color: AppColors.brand,
  );

  // BricolageGrotesque
  static const TextStyle username = TextStyle(
    fontFamily: 'BricolageGrotesque',
    fontSize: 14,
    color: AppColors.black,
  );

  // JetBrainsMono
  static const TextStyle monoSm = TextStyle(
    fontFamily: 'JetBrainsMono',
    fontSize: 12,
  );

  static const TextStyle monoMd = TextStyle(
    fontFamily: 'JetBrainsMono',
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );

  // Newsreader
  static const TextStyle body = TextStyle(
    fontFamily: 'Newsreader',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.black,
  );

  static const TextStyle titleItalic = TextStyle(
    fontFamily: 'Newsreader',
    fontSize: 18,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle headingItalic = TextStyle(
    fontFamily: 'Newsreader',
    fontSize: 26,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.w400,
  );

  // JetBrainsMono (extra small)
  static const TextStyle monoXs = TextStyle(
    fontFamily: 'JetBrainsMono',
    fontSize: 11,
  );
}
