import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:teachtrake/data/repositories/authentication_repository.dart';
import 'package:teachtrake/data/services/network_manager.dart';
import 'package:teachtrake/utils/constants/image_string.dart';
import 'package:teachtrake/utils/popups/full_screen_loader.dart';
import 'package:teachtrake/utils/popups/loader.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();
  //vaiables
  final localStorage = GetStorage();
  final hidePassword = true.obs;
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  Future<void> emailAndPasswordSignIn() async {
    try {
      HFullScreenLoader.openLoadingDialog(
          'Logging You in ...', HImages.doceranimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        HFullScreenLoader.stoploading();
        HLoaders.warningSnackBar(title: 'No Internet Connection');
        return;
      }

      //Form Validation
      if (!loginFormKey.currentState!.validate()) {
        HFullScreenLoader.stoploading();
        return;
      }

      await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      //remove loader
      HFullScreenLoader.stoploading();
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      HFullScreenLoader.stoploading();
      HLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
