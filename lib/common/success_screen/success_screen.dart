import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:teachtrake/common/spacing_style.dart';
import 'package:teachtrake/utils/constants/sizes.dart';
import 'package:teachtrake/utils/helpers/helper.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen(
      {super.key,
      required this.image,
      required this.title,
      required this.subtitle,
      required this.onpressed});
  final String image, title, subtitle;
  final VoidCallback onpressed;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: HSpacigStyle.paddingwithAppBarHeight * 2,
          child: Column(
            children: [
              Lottie.asset(
                image,
                width: HHelperFunctions.screenWidth() * 0.6,
              ),
              const SizedBox(height: HSizes.spaceBtwSections),

              //Title & Subtitle
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: HSizes.spaceBtwItems),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: HSizes.spaceBtwSections),

              //buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onpressed,
                  child: const Text('Continue'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
