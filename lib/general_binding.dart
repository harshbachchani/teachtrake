import 'package:get/get.dart';
import 'package:teachtrake/data/services/network_manager.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
  }
}
