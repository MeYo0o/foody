import 'package:foody/controllers/auth_controller.dart';
import 'package:foody/controllers/general_controller.dart';
import 'package:foody/controllers/intro_controller.dart';
import 'package:foody/controllers/navigation_controller.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => GeneralController());
    Get.lazyPut(() => IntroController());
    Get.lazyPut(() => NavigationController());
  }
}
