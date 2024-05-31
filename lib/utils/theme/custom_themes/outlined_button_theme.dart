import 'package:flutter/material.dart';
import 'package:teachtrake/utils/constants/colors.dart';
import 'package:teachtrake/utils/constants/sizes.dart';

class HOutlineButtonTheme {
  HOutlineButtonTheme._();

  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: HColors.dark,
      side: const BorderSide(color: HColors.borderPrimary),
      textStyle: const TextStyle(
          fontSize: 16, color: HColors.black, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(
          vertical: HSizes.buttonHeight, horizontal: 20),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(HSizes.buttonRadius)),
    ),
  );

  /* -- Dark Theme -- */
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: HColors.light,
      side: const BorderSide(color: HColors.borderPrimary),
      textStyle: const TextStyle(
          fontSize: 16, color: HColors.textWhite, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(
          vertical: HSizes.buttonHeight, horizontal: 20),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(HSizes.buttonRadius)),
    ),
  );
}
