import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teachtrake/features/authentication/controller/forget_password_controller.dart';
import 'package:teachtrake/features/authentication/screens/login/login.dart';
import 'package:teachtrake/utils/constants/image_string.dart';
import 'package:teachtrake/utils/constants/sizes.dart';
import 'package:teachtrake/utils/constants/text_string.dart';
import 'package:teachtrake/utils/helpers/helper.dart';

class ResetPassWordScreen extends StatelessWidget {
  const ResetPassWordScreen({super.key, required this.email});
  final String email;
  @override
  Widget build(BuildContext context) {
    final controller = ForgetPasswordController.instance;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(HSizes.defaultSpace),
        child: Column(
          children: [
            Image(
              image: const AssetImage(HImages.resendmailimg),
              width: HHelperFunctions.screenWidth() * 0.6,
            ),
            const SizedBox(height: HSizes.spaceBtwSections),

            //Email,Title & Subtitle
            Text(email,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center),
            const SizedBox(height: HSizes.spaceBtwItems),
            Text(
              HTextString.changeYourPasswordTitle,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: HSizes.spaceBtwItems),
            Text(
              HTextString.changeYourPasswordSubTitle,
              style: Theme.of(context).textTheme.labelMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: HSizes.spaceBtwSections),

            //buttons
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.offAll(() => const LoginScreen()),
                child: const Text('Done'),
              ),
            ),
            const SizedBox(height: HSizes.spaceBtwItems),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => controller.resendPasswordResetEmail(email),
                child: const Text(HTextString.resendEmail),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
