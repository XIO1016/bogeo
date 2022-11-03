import 'package:get/get.dart';

class DetailPillController extends GetxController {
  RxBool prohibitClick = false.obs;

  Future changeProhibitClick() async {
    if (prohibitClick == true) {
      prohibitClick(false);
    } else {
      prohibitClick(true);
    }
  }
}
