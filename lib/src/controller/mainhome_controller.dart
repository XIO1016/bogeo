import 'package:capstone/src/components/image_data.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MainHomeController extends GetxController {
  var strToday = DateFormat('MM/dd').format(DateTime.now()).obs;
  var strday = DateFormat.E('ko').format(DateTime.now()).obs;
  var eating = true.obs;
  RxInt period = 0.obs;
  var image = "".obs;
  @override
  void onInit() {
    super.onInit();
    getImage(1);
  }

  void changeate() {
    if (eating == true) {
      eating(false);
    } else {
      eating(true);
    }
  }

  void changeDropMenu(int? itemIndex) {
    period(itemIndex);
  }

  void getImage(int index) {
    switch (index) {
      case 0:
        //조제약
        image(IconsPath.pillType1);
        return;
      //상비약
      case 1:
        image(IconsPath.pillType2);
        return;
      //비타민
      case 2:
        image(IconsPath.pillType3);
        return;
    }
  }
}
