import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class KChipTheme {
  KChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    checkmarkColor: KColors.white,
    selectedColor: KColors.primary,
    disabledColor: KColors.grey.withOpacity(0.4),
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    labelStyle: const TextStyle(color: KColors.black, fontFamily: 'Urbanist'),
  );

  static ChipThemeData darkChipTheme = const ChipThemeData(
    checkmarkColor: KColors.white,
    selectedColor: KColors.primary,
    disabledColor: KColors.darkerGrey,
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    labelStyle: TextStyle(color: KColors.white, fontFamily: 'Urbanist'),
  );
}
