import 'dart:convert';
import 'dart:developer';

import 'package:capstone/src/http/url.dart';
import 'package:capstone/src/pages/add/addpilltodata.dart';
import 'package:capstone/src/pages/mainhome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../app.dart';
import '../../model/pillsdata.dart';
import '../login/login_button_controller.dart';

class AddPillToDataController extends GetxController {
  static AddPillToDataController get to => Get.find<AddPillToDataController>();
  var id = LoginButtonController.to.id;
  RxString token1 = LoginButtonController.to.token1;

  RxInt eatPeriod = 0.obs;
  List week = ['월', '화', '수', '목', '금', '토', '일'];
  TextEditingController interval = TextEditingController();
  TextEditingController pillNum = TextEditingController();
  TextEditingController timehour = TextEditingController();
  TextEditingController timeminute = TextEditingController();
  RxInt ampm = 1.obs;
  dynamic period;

  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxInt pageIndex = 0.obs;

  late PillsItem pill;
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
  RxBool hasmedicinetime = false.obs;
  @override
  void onInit() {
    super.onInit();
    timehour.text = '07';
    timeminute.text = '00';
  }

  checkPeriod(int i) {
    if (eatPeriod != i) {
      eatPeriod(i);
    }
  }

  checkEnding(int i) {
    eatEnding(i);
  }

  weekCheckPeriod(int i) {
    if (weekCheck[i].value) {
      weekCheck[i](false);
    } else {
      weekCheck[i](true);
    }
  }

  changePage() {
    if (pageIndex < 3) {
      pillNum.text = '';
      pageIndex.value++;
    }
    if (pageIndex == 3 && pillNum.text != '') {
      postAdd();
    }
  }

  Future postAdd() async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);

    if (eatPeriod.value == 0) {
      String period1 = '';
      for (int i = 0; i < 7; i++) {
        if (weekCheck[i] == true) {
          period1 += (i + 1).toString();

          period1 += ',';
        }
        if (i == 6) {
          period1 = period1.substring(0, period1.length - 1);
        }
        log(period1);
        period = period1;
      }
    } else if (eatPeriod.value == 1) {
      int period = int.parse(interval.text);
      log(period.toString());
    } else if (eatPeriod.value == 2) {
      var period = null;
    }

    int time = 0;
    if (hasmedicinetime.value) {
      if (ampm.value == 1) {
        time = int.parse(timehour.text);
      } else if (ampm.value == 2) {
        time = int.parse(timehour.text) + 12;
      }
    } else {
      time = -1;
    }

    var request = await http.post(
        Uri.parse('${urlBase}medicine?id=$id&seq=${pill.item_seq}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          // ignore: prefer_interpolation_to_compose_strings
          'Authorization': 'Bearer ' + token1.value,
        },
        body: jsonEncode(<String, dynamic>{
          'medicineSeq': pill.item_seq,
          'periodType': eatPeriod.value,
          'period': period,
          'hasEndDay': (eatEnding == 0) ? false : true,
          'endDay': (eatEnding == 1)
              ? '${selectedDate.value.year}-${selectedDate.value.month}-${selectedDate.value.day}'
              : null,
          'hasMedicineTime': hasmedicinetime.value,
          'medicineHour': time,
          'medicineMinute':
              (hasmedicinetime.value) ? int.parse(timeminute.text) : -1,
          'dosage': int.parse(pillNum.text)
        }));

    if (request.statusCode == 200) {
      Get.to(App());

      LoginButtonController.to.getMyPills();
      LoginButtonController.to.getMyallPills();
    }
  }

  backButton() {
    switch (pageIndex.value) {
      case 0:
        Get.back();
        break;
      case 1:
      case 2:
      case 3:
        pageIndex(pageIndex.value - 1);
        break;
    }
  }
}
