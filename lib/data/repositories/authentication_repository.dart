import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:teachtrake/features/authentication/screens/login/login.dart';
import 'package:teachtrake/features/authentication/screens/signup/verfify_email.dart';
import 'package:teachtrake/navigation_menu.dart';
import 'package:teachtrake/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:teachtrake/utils/exceptions/firebase_exceptions.dart';
import 'package:teachtrake/utils/exceptions/format_exceptions.dart';
import 'package:teachtrake/utils/exceptions/platform_exceptions.dart';
import 'package:teachtrake/utils/helpers/helper.dart';
import 'package:teachtrake/utils/local_storage/storage_utility.dart';
import 'package:teachtrake/utils/popups/loader.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  User? get authUser => _auth.currentUser;
  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  screenRedirect() async {
    User? user = _auth.currentUser;
    if (user != null) {
      if (user.emailVerified) {
        //Initialize user specific storage
        await HLocalStorage.init(user.uid);
        Get.offAll(() => NavigationMenu());
      } else {
        Get.offAll(() => VerifyEmailScreen(email: _auth.currentUser?.email));
      }
    } else {
      //Local Storage
      Get.offAll(() => const LoginScreen());
    }
  }

  /*---------------Email & Password Sign In-------------*/
  // Email Authentication - SignIN
  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      HLoaders.warningSnackBar(
          title: e.code, message: HFirebaseAuthException(e.code).message);
      throw HFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw HFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const HFormatException();
    } on PlatformException catch (e) {
      throw HPlatformException(e.code).message;
    } catch (e) {
      throw 'Something Went Wrong!! Please try again ';
    }
  }

  // Email Authentication - Register
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print("The error is : ");
      print(e);

      throw HFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw HFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const HFormatException();
    } on PlatformException catch (e) {
      throw HPlatformException(e.code).message;
    } catch (e) {
      throw 'Something Went Wrong!!';
    }
  }

  //Reauthenticate
  //Email Verification -- Mail verification
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      HLoaders.warningSnackBar(
          title: e.code, message: HFirebaseAuthException(e.code).message);
      throw HFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw HFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const HFormatException();
    } on PlatformException catch (e) {
      throw HPlatformException(e.code).message;
    } catch (e) {
      throw 'Something Went Wrong!!';
    }
  }

  //Email Verification -- forgot password
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      HLoaders.warningSnackBar(
          title: e.code, message: HFirebaseAuthException(e.code).message);
      throw HFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw HFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const HFormatException();
    } on PlatformException catch (e) {
      throw HPlatformException(e.code).message;
    } catch (e) {
      throw 'Something Went Wrong!!';
    }
  }

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      HHelperFunctions.navigateToScreenWithPopping(
          Get.context!, const LoginScreen());
    } on FirebaseAuthException catch (e) {
      HLoaders.warningSnackBar(
          title: e.code, message: HFirebaseAuthException(e.code).message);
      throw HFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw HFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const HFormatException();
    } on PlatformException catch (e) {
      throw HPlatformException(e.code).message;
    } catch (e) {
      throw 'Something Went Wrong!! ${e.toString()}';
    }
  }
}
