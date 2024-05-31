import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:teachtrake/common/appbar/appbar.dart';
import 'package:teachtrake/features/personalization/controllers/user_controller.dart';
import 'package:teachtrake/features/personalization/screens/profile.dart';
import 'package:teachtrake/features/record/screen/add_student/add_student.dart';
import 'package:teachtrake/features/record/screen/home/home.dart';
import 'package:teachtrake/utils/constants/colors.dart';
import 'package:teachtrake/utils/helpers/helper.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    // ignore: unused_local_variable
    final userController = Get.put(UserController());
    final dark = HHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: HAppBar(
        showbackArrow: false,
        title: const Center(child: Text('Attendance App')),
        actions: [
          IconButton(
              onPressed: () => Get.to(() => const ProfileScreen()),
              icon: const Icon(Iconsax.user))
        ],
      ),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          selectedIndex: controller.getindex(),
          elevation: 0,
          backgroundColor: dark ? HColors.black : HColors.white,
          indicatorColor: dark
              ? HColors.white.withOpacity(0.1)
              : HColors.black.withOpacity(0.1),
          onDestinationSelected: (index) => controller.updateindex(index),
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            NavigationDestination(icon: Icon(Iconsax.add), label: 'Add'),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.getindex()]),
    );
  }
}

class NavigationController extends GetxController {
  static NavigationController get instance => Get.find();
  RxInt selectedIndex = 0.obs;
  updateindex(i) {
    selectedIndex.value = i;
  }

  final screens = const [
    HomeScreen(),
    AddStudentScreen(),
  ];
  getindex() {
    return selectedIndex.value;
  }
}
