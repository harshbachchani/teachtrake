import 'package:flutter/material.dart';
import 'package:teachtrake/common/spacing_style.dart';
import 'package:teachtrake/features/authentication/screens/login/widgets/login_form.dart';
import 'package:teachtrake/features/authentication/screens/login/widgets/login_header.dart';
import 'package:teachtrake/utils/constants/sizes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: HSpacigStyle.paddingwithAppBarHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LoginHeader(),
              LoginForm(),
              SizedBox(height: HSizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }
}
