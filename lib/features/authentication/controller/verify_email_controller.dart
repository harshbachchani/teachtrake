import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:teachtrake/common/success_screen/success_screen.dart';
import 'package:teachtrake/data/repositories/authentication_repository.dart';
import 'package:teachtrake/utils/constants/image_string.dart';
import 'package:teachtrake/utils/constants/text_string.dart';
import 'package:teachtrake/utils/popups/loader.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  //Send Email Verficatiton link
  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      HLoaders.successSnackBar(
          title: 'Email Sent',
          message: 'Check Your inbox and verify your email.');
    } catch (e) {
      HLoaders.errorSnackBar(title: 'Oh Snap!!', message: e.toString());
    }
  }

  //Timer to automatically redirect an email verification
  setTimerForAutoRedirect() {
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) async {
        await FirebaseAuth.instance.currentUser?.reload();
        final user = FirebaseAuth.instance.currentUser;
        if (user?.emailVerified ?? false) {
          timer.cancel();
          Get.off(
            () => SuccessScreen(
              image: HImages.successAnimation,
              title: HTextString.yourAccountCreatedTitle,
              subtitle: '',
              onpressed: () =>
                  AuthenticationRepository.instance.screenRedirect(),
            ),
          );
        }
      },
    );
  }

  //Manually check if email verified
  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(
        () => SuccessScreen(
            image: HImages.successAnimation,
            title: HTextString.yourAccountCreatedTitle,
            subtitle: '',
            onpressed: () =>
                AuthenticationRepository.instance.screenRedirect()),
      );
    }
  }
}
