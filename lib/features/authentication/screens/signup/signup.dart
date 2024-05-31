import 'package:flutter/material.dart';
import 'package:teachtrake/features/authentication/screens/signup/widgets/signupform.dart';
import 'package:teachtrake/utils/constants/sizes.dart';
import 'package:teachtrake/utils/constants/text_string.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(HSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Title
              Text(HTextString.signupTitle,
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: HSizes.spaceBtwSections),
              //Form
              const SignUpForm(),
              const SizedBox(height: HSizes.spaceBtwItems),
            ],
          ),
        ),
      ),
    );
  }
}
