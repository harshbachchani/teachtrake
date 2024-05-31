import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/state_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:teachtrake/common/appbar/appbar.dart';
import 'package:teachtrake/common/text/section_heading.dart';
import 'package:teachtrake/data/repositories/authentication_repository.dart';
import 'package:teachtrake/features/personalization/controllers/user_controller.dart';
import 'package:teachtrake/features/personalization/screens/change_name.dart';
import 'package:teachtrake/features/personalization/screens/profile_menu.dart';
import 'package:teachtrake/utils/constants/sizes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return Scaffold(
      appBar: const HAppBar(
        showbackArrow: true,
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(HSizes.defaultSpace),
          child: Column(
            children: [
              const HSectionHeading(
                  title: 'Profile Information', showActionButton: false),
              HProfileMenu(
                onPressed: () => Get.to(() => const ChangeName()),
                title: 'Name',
                value: controller.user.value.fullName,
              ),
              const SizedBox(height: HSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: HSizes.spaceBtwItems),

              //Heading Personal Info
              const HSectionHeading(
                  title: 'Personal Information', showActionButton: false),
              const SizedBox(height: HSizes.spaceBtwItems),

              Obx(
                () => HProfileMenu(
                    onPressed: () {},
                    title: 'User_Id',
                    value: controller.user.value.id,
                    icon: Iconsax.copy),
              ),
              Obx(
                () => HProfileMenu(
                  onPressed: () {},
                  title: 'E-mail',
                  value: controller.user.value.email,
                ),
              ),
              Obx(
                () => HProfileMenu(
                  onPressed: () {},
                  title: 'Phone Number',
                  value: controller.user.value.phonenumber,
                ),
              ),
              const Divider(),
              const SizedBox(height: HSizes.spaceBtwItems),

              Center(
                child: TextButton(
                  onPressed: () => AuthenticationRepository.instance.logout(),
                  child: const Text(
                    'Logout',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
