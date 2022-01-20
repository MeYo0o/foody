import 'package:foody/controllers/intro_controller.dart';
import 'package:foody/controllers/navigation_controller.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => IntroController());
    Get.lazyPut(() => NavigationController());
  }
}
