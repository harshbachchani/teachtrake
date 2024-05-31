import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:teachtrake/features/record/controllers/update_controller.dart';
import 'package:teachtrake/utils/constants/sizes.dart';
import 'package:teachtrake/utils/constants/text_string.dart';
import 'package:teachtrake/utils/validators/validartor.dart';

class UpdateStudentForm extends StatelessWidget {
  const UpdateStudentForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UpdateController.instance;
    return Form(
      key: controller.updateKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
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
                  controller: controller.lastName,
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
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: 'Gender'),
            items: ['Male', 'Female', 'Other'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (newValue) => controller.gender.value = newValue ?? '',
            validator: (value) => HValidator.validateEmptyText('Gender', value),
          ),
          const SizedBox(height: HSizes.spaceBtwSections),
          InkWell(
            onTap: () => controller.selectDate(context),
            child: InputDecorator(
              decoration: const InputDecoration(
                labelText: 'Date of Birth',
              ),
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    controller.dob.value == ''
                        ? const Text('Select your date of birth')
                        : Text(controller.dob.value),
                    const Icon(Icons.calendar_today),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: HSizes.spaceBtwSections),
          SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => controller.updateStudent(),
                      child: const Text('Update'),
                    ),
                  ),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => controller.deleteStudent(),
                      child: const Text('Delete'),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
