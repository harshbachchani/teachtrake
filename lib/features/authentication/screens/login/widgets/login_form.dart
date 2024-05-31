import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:teachtrake/features/authentication/controller/login_controller.dart';
import 'package:teachtrake/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:teachtrake/features/authentication/screens/signup/signup.dart';
import 'package:teachtrake/utils/constants/sizes.dart';
import 'package:teachtrake/utils/constants/text_string.dart';
import 'package:teachtrake/utils/validators/validartor.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: HSizes.spaceBtwSections),
        child: Column(
          children: [
            TextFormField(
              controller: controller.email,
              validator: (value) => HValidator.validateEmail(value),
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person), labelText: HTextString.email),
            ),
            const SizedBox(height: HSizes.spaceBtwInputFields),
            Obx(
              () => TextFormField(
                controller: controller.password,
                obscureText: controller.hidePassword.value,
                validator: (value) =>
                    HValidator.validateEmptyText('Password', value),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Iconsax.password_check),
                  labelText: HTextString.password,
                  suffixIcon: IconButton(
                    onPressed: () => controller.hidePassword.value ^= true,
                    icon: controller.hidePassword.value
                        ? const Icon(Iconsax.eye_slash)
                        : const Icon(Iconsax.eye),
                  ),
                ),
              ),
            ),
            const SizedBox(height: HSizes.spaceBtwInputFields / 2),
            TextButton(
              onPressed: () => Get.to(() => const ForgetPasswordScreen()),
              child: const Text(HTextString.forgetPassword),
            ),
            const SizedBox(height: HSizes.spaceBtwSections),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.emailAndPasswordSignIn(),
                child: const Text("Sign In"),
              ),
            ),
            const SizedBox(height: HSizes.spaceBtwItems),
            //create account button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Get.to(() => const SignUpPage()),
                child: const Text(HTextString.createAccount),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
