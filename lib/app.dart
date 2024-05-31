import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teachtrake/general_binding.dart';
import 'package:teachtrake/utils/constants/colors.dart';
import 'package:teachtrake/utils/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TeachTrake',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      initialBinding: GeneralBindings(),
      theme: HAppTheme.lightTheme,
      home: const Scaffold(
        backgroundColor: HColors.primary,
        body: Center(
          child: CircularProgressIndicator(
            color: HColors.white,
          ),
        ),
      ),
    );
  }
}
