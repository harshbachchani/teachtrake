import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:teachtrake/data/repositories/authentication_repository.dart';
import 'package:teachtrake/data/repositories/student_repository.dart';
import 'package:teachtrake/data/services/network_manager.dart';
import 'package:teachtrake/features/record/models/student_model.dart';
import 'package:teachtrake/navigation_menu.dart';
import 'package:teachtrake/utils/constants/image_string.dart';
import 'package:teachtrake/utils/popups/full_screen_loader.dart';
import 'package:teachtrake/utils/popups/loader.dart';

class UpdateController extends GetxController {
  static UpdateController get instance => Get.find();
  final String uid = AuthenticationRepository.instance.authUser!.uid;
  GlobalKey<FormState> updateKey = GlobalKey<FormState>();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  RxString gender = ''.obs;
  final studentRepo = Get.put(StudentRepository());
  RxString dob = ''.obs;
  String docid = '';

  void updateDetails(StudentModel s) {
    docid = s.id;
    dob.value = DateFormat('yyyy-MM-dd').format(s.dob!);
    gender.value = s.gender;
    firstName.text = s.firstName;
    lastName.text = s.lastName;
  }

  Future<void> updateStudent() async {
    try {
      HFullScreenLoader.openLoadingDialog(
          'Adding Student Record', HImages.doceranimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        HFullScreenLoader.stoploading();
        return;
      }

      if (!updateKey.currentState!.validate()) {
        HFullScreenLoader.stoploading();
        return;
      }

      if (dob.value == '') {
        HLoaders.warningSnackBar(title: 'Date Field Is Required');
        HFullScreenLoader.stoploading();
        return;
      }

      StudentModel s = StudentModel(
          firstName: firstName.text.trim(),
          lastName: lastName.text.trim(),
          gender: gender.value,
          dob: stod(dob.value),
          teacherId: uid);
      await studentRepo.updateStudent(s, docid);

      HFullScreenLoader.stoploading();

      HLoaders.successSnackBar(
          title: 'Congratulations', message: 'Student has been Updated');
      resetValues();
      Get.offAll(() => const NavigationMenu());
    } catch (e) {
      HFullScreenLoader.stoploading();
      HLoaders.errorSnackBar(title: 'Error in updating the data');
    }
  }

  void resetValues() {
    firstName.text = '';
    lastName.text = '';
    gender.value = '';
    dob.value = '';
  }

  Future<void> deleteStudent() async {
    try {
      HFullScreenLoader.openLoadingDialog(
          'Deleting Student Record', HImages.doceranimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        HFullScreenLoader.stoploading();
        return;
      }

      await studentRepo.deleteStudent(docid);

      HFullScreenLoader.stoploading();

      HLoaders.successSnackBar(
          title: 'Congratulations', message: 'Student has been Deleted');
      resetValues();
      Get.offAll(() => const NavigationMenu());
    } catch (e) {
      HFullScreenLoader.stoploading();
      HLoaders.errorSnackBar(title: 'Error in deleting the data');
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) dob.value = DateFormat('yyyy-MM-dd').format(picked);
  }

  DateTime stod(String a) {
    return DateFormat('yyyy-MM-dd').parse(a);
  }
}
