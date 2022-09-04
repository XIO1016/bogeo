import 'package:capstone/src/controller/bottom_nav_controller.dart';
import 'package:capstone/src/controller/login_button_controller.dart';
import 'package:get/get.dart';

import '../controller/signup_button_controller.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BottomNavController(), permanent: true);
    Get.put(LoginButtonController(), permanent: true);
    Get.put(SignUpButtonController(), permanent: true);
  }
}
