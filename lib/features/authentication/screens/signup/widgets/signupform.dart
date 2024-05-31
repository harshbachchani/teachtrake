import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:teachtrake/utils/constants/sizes.dart';
import 'package:teachtrake/utils/constants/text_string.dart';
import 'package:teachtrake/utils/validators/validartor.dart';

import '../../../controller/sign_up_controller.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    return Form(
      key: controller.signupFormkey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.firstname,
                  expands: false,
                  validator: (value) =>
                      HValidator.validateEmptyText('firstName', value),
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    labelText: HTextString.firstName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
              const SizedBox(width: HSizes.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                  controller: controller.lastname,
                  validator: (value) =>
                      HValidator.validateEmptyText('lastName', value),
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    labelText: HTextString.lastName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: HSizes.spaceBtwInputFields),
          TextFormField(
            controller: controller.email,
            validator: (value) => HValidator.validateEmail(value),
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: HTextString.email,
              prefixIcon: Icon(Iconsax.direct),
            ),
          ),
          const SizedBox(height: HSizes.spaceBtwInputFields),
          TextFormField(
            controller: controller.phonenumber,
            keyboardType: TextInputType.phone,
            validator: (value) => HValidator.validatePhoneNumber(value),
            decoration: const InputDecoration(
              labelText: HTextString.phoneNo,
              prefixIcon: Icon(Iconsax.call),
            ),
          ),
          const SizedBox(height: HSizes.spaceBtwInputFields),
          Obx(
            () => TextFormField(
              validator: (value) => HValidator.validatePassword(value),
              obscureText: controller.hidePassword.value,
              controller: controller.password,
              decoration: InputDecoration(
                labelText: HTextString.password,
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  onPressed: () => controller.hidePassword.value ^= true,
                  icon: controller.hidePassword.value
                      ? const Icon(Iconsax.eye_slash)
                      : const Icon(Iconsax.eye),
                ),
              ),
            ),
          ),

          const SizedBox(height: HSizes.spaceBtwInputFields),

          //Signup Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.signUp(),
              child: const Text(
                HTextString.createAccount,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
