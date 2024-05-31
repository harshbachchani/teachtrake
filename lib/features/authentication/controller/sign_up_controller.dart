import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teachtrake/data/repositories/authentication_repository.dart';
import 'package:teachtrake/data/repositories/user_repository.dart';
import 'package:teachtrake/data/services/network_manager.dart';
import 'package:teachtrake/features/authentication/models/user_model.dart';
import 'package:teachtrake/features/authentication/screens/signup/verfify_email.dart';
import 'package:teachtrake/utils/constants/image_string.dart';
import 'package:teachtrake/utils/popups/full_screen_loader.dart';
import 'package:teachtrake/utils/popups/loader.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();
  //Variables
  final hidePassword = true.obs;
  final email = TextEditingController();
  final lastname = TextEditingController();
  final password = TextEditingController();
  final firstname = TextEditingController();
  final phonenumber = TextEditingController();
  GlobalKey<FormState> signupFormkey = GlobalKey<FormState>();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    firstname.dispose();
    email.dispose();
    phonenumber.dispose();
    super.dispose();
  }

  //Signup
  void signUp() async {
    try {
      //start loading
      HFullScreenLoader.openLoadingDialog(
          'We are processing your information....', HImages.doceranimation);
      //check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        HFullScreenLoader.stoploading();
        return;
      }
      //Form Validation
      if (!signupFormkey.currentState!.validate()) {
        HFullScreenLoader.stoploading();
        return;
      }

      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());

      final newuser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstname.text.trim(),
        lastName: lastname.text.trim(),
        email: email.text.trim(),
        phonenumber: phonenumber.text.trim(),
      );
      final userRepository = Get.put(UserRepository());
      await userRepository.saveuserRecord(newuser);
      HFullScreenLoader.stoploading();
      HLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your account has been created! Verify email to continue');
      Get.to(() => VerifyEmailScreen(
            email: email.text.trim(),
          ));
    } catch (e) {
      HFullScreenLoader.stoploading();
      HLoaders.errorSnackBar(title: 'Oh Snap!!', message: e.toString());
    }
  }
}
