import 'package:get/get.dart';
import 'package:teachtrake/data/repositories/user_repository.dart';
import 'package:teachtrake/features/authentication/models/user_model.dart';
import 'package:teachtrake/utils/popups/loader.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();
  final userrepository = Get.put(UserRepository());
  Rx<UserModel> user = UserModel.empty().obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  Future<void> fetchUserRecord() async {
    try {
      final user = await userrepository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
      HLoaders.errorSnackBar(title: 'Cannot get user details');
    }
  }
}
