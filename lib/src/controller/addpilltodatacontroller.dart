import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddPillToDataController extends GetxController {
  RxInt eatPeriod = 0.obs;
  List week = ['월', '화', '수', '목', '금', '토', '일'];
  TextEditingController interval = TextEditingController();
  TextEditingController pillNum = TextEditingController();
  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxInt pageIndex = 0.obs;
  RxList weekCheck = [
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
  ].obs;
  RxInt eatEnding = 0.obs;

  checkPeriod(int i) {
    if (eatPeriod != i) {
      eatPeriod(i);
    }
  }

  checkEnding(int i) {
    if (eatEnding != i) {
      eatEnding(i);
    }
  }

  weekCheckPeriod(int i) {
    if (weekCheck[i].value) {
      weekCheck[i](false);
    } else {
      weekCheck[i](true);
    }
  }

  changePage() {
    if (pageIndex < 2) {
      pageIndex.value++;
    }
  }

  changeselectedDate(DateTime selectedDay) {
    selectedDate(
        DateTime(selectedDay.year, selectedDay.month, selectedDay.day));
    selectedDate.refresh();
  }
}
