import 'dart:developer';

import 'package:capstone/src/controller/mainhome_controller.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class eatpillController extends GetxController {
  Rx<DateTime> selecteddate = DateTime.now().obs;
  Rx<DateTime> focuseddate = DateTime.now().obs;
  Rx<CalendarFormat> calendarFormat = CalendarFormat.month.obs;
  RxInt iseatclick = 0.obs;
  RxList<List> pillsdata = MainHomeController.to.pillsdata;

  changeClick() {
    if (iseatclick.value == 0) {
      iseatclick(1);
    } else {
      iseatclick(0);
    }
  }

  checkeating(List a, int j) {
    final item = a[j];
    log(item.toString());
    if (item.iseat == false) {
      item.iseat = true;
    } else {
      item.iseat = false;
    }
    pillsdata.refresh();
  }
}
