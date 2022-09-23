import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MainHomeController extends GetxController {
  var strToday = DateFormat('MM/dd').format(DateTime.now()).obs;
  var strday = DateFormat.E('ko').format(DateTime.now()).obs;
  var eating = true.obs;
  RxInt period = 0.obs;
  @override
  void onInit() {
    super.onInit();
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
}
