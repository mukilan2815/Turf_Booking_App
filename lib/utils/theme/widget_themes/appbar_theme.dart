import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';

class KAppBarTheme{
  KAppBarTheme._();

  static const lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    iconTheme: IconThemeData(color: KColors.iconPrimary, size: KSizes.iconMd),
    actionsIconTheme: IconThemeData(color: KColors.iconPrimary, size: KSizes.iconMd),
    titleTextStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: KColors.black, fontFamily: 'Urbanist'),
  );
  static const darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: KColors.dark,
    surfaceTintColor: KColors.dark,
    iconTheme: IconThemeData(color: KColors.black, size: KSizes.iconMd),
    actionsIconTheme: IconThemeData(color: KColors.white, size: KSizes.iconMd),
    titleTextStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: KColors.white, fontFamily: 'Urbanist'),
  );
}