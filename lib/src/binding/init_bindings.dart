import 'package:capstone/src/controller/addpill_controller.dart';
import 'package:capstone/src/controller/bottom_nav_controller.dart';
import 'package:capstone/src/controller/login/login_button_controller.dart';
import 'package:get/get.dart';

import '../controller/login/signup_button_controller.dart';
import '../controller/mainhome_controller.dart';
import '../controller/seachpill_controller.dart';
import '../controller/user_controller.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BottomNavController(), permanent: true);
    Get.put(LoginButtonController(), permanent: true);
    Get.put(SignUpButtonController(), permanent: true);
    Get.put(MainHomeController(), permanent: true);
    Get.put(UserController(), permanent: true);
    Get.put(AddPillController(), permanent: true);

    Get.put(SearchController(), permanent: true);
  }
}
