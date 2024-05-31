import 'package:flutter/material.dart';
import 'package:teachtrake/utils/constants/colors.dart';
import 'package:teachtrake/utils/constants/sizes.dart';

class HAppBarTheme {
  HAppBarTheme._();

  static const lightAppbarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: HColors.black, size: HSizes.iconMd),
    actionsIconTheme: IconThemeData(color: HColors.black, size: HSizes.iconMd),
    titleTextStyle: TextStyle(
        fontSize: 18, fontWeight: FontWeight.w600, color: HColors.black),
  );
  static const darkAppbarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: HColors.black, size: HSizes.iconMd),
    actionsIconTheme: IconThemeData(color: Colors.black, size: HSizes.iconMd),
    titleTextStyle: TextStyle(
        fontSize: 18, fontWeight: FontWeight.w600, color: HColors.white),
  );
}
