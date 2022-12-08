import 'dart:convert';
import 'dart:developer';

import 'package:capstone/src/controller/login/login_button_controller.dart';
import 'package:capstone/src/controller/mainhome_controller.dart';
import 'package:capstone/src/controller/seachpill_controller.dart';
import 'package:capstone/src/model/pillsdata.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:table_calendar/table_calendar.dart';

import '../components/message_popup.dart';
import '../http/url.dart';
import '../model/mypills.dart';

class eatpillController extends GetxController {
  Rx<DateTime> selecteddate = DateTime
      .now()
      .obs;
  Rx<DateTime> focuseddate = DateTime
      .now()
      .obs;
  Rx<CalendarFormat> calendarFormat = CalendarFormat.week.obs;
  RxInt iseatclick = 0.obs;
  RxList<List> pillsdata = MainHomeController.to.pillsdata;
  RxString id = LoginButtonController.to.id;
  RxString token1 = LoginButtonController.to.token1;
  RxList pillItems = [].obs;
  RxList pillItemsOtherDay = [].obs;

  changeClick() {
    if (iseatclick.value == 0) {
      iseatclick(1);
    } else {
      iseatclick(0);
    }
  }

  checkeating(MyPillsItem item) async {
    if (item.iseat == false) {
      item.iseat = true;
    } else {
      item.iseat = false;
    }
    pillItems.refresh();
    pillItemsOtherDay.refresh();

    log(item.iseat.toString());
    await http
        .patch(Uri.parse('${urlBase}medicine?id=${item.medicineScheduleId}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          // ignore: prefer_interpolation_to_compose_strings
          'Authorization': 'Bearer ' + token1.value,
        });
  }

  Future<void> getDayMedicine() async {
    pillItemsOtherDay([]);
    var pills = [];
    var selectedDateYear = selecteddate.value.year;
    var selectedDateMonth = selecteddate.value.month;
    var selectedDateDay = selecteddate.value.day;

    var getMedicineRequest = await http.get(
        Uri.parse(
            '${urlBase}medicine?id=${id}&year=$selectedDateYear&month=$selectedDateMonth&day=$selectedDateDay'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          // ignore: prefer_interpolation_to_compose_strings
          'Authorization': 'Bearer ' + token1.value,
        });

    if (getMedicineRequest.statusCode == 200) {
      List<dynamic> pillslist = jsonDecode(getMedicineRequest.body);
      log(pillslist.length.toString());
      for (int i = 0; i < pillslist.length; i++) {
        int eatingTime3 = 2; //오전 오후
        Map pilllist = pillslist[i];
        var pillsitem;
        int eatingTime;

        if (pilllist['hasMedicineTime']) {
          var time = pilllist['medicineTime'].split(':');
          if (int.parse(time[0]) >= 12) {
            eatingTime3 = 1;
            eatingTime = int.parse(time[0]) - 12;
          } else {
            eatingTime3 = 0;
            eatingTime = int.parse(time[0]);
          }
          pillsitem = MyPillsItem(
            item_seq: pilllist['medicineSeq'] ?? '',
            item_name: pilllist['medicineName'],
            eatingNum: pilllist['dosage'],
            eatingTime: eatingTime,
            eatingTime2: time[1],
            eatingTime3: eatingTime3,
            endDay: (pilllist['hasEndDay']) ? pilllist['endDay'] : '',
            hasEndDay: pilllist['hasEndDay'],
            iseat: pilllist['activated'],
            period: pilllist['period'],
            image: (pilllist['medicineImage'] == null)
                ? ''
                : pilllist['medicineImage'],
            medicineID: pilllist['medicineId'],
            medicineScheduleId: pilllist['medicineScheduleId'],
            customMedicineId: pilllist['customMedicineId'] ?? -1,
          );
        } else {
          pillsitem = MyPillsItem(
            item_seq: pilllist['medicineSeq'] ?? '',
            item_name: pilllist['medicineName'],
            eatingNum: pilllist['dosage'],
            eatingTime: 0,
            eatingTime2: '0',
            eatingTime3: eatingTime3,
            endDay: (pilllist['hasEndDay']) ? pilllist['endDay'] : '',
            hasEndDay: pilllist['hasEndDay'],
            iseat: pilllist['activated'],
            period: pilllist['period'],
            image: (pilllist['medicineImage'] == null)
                ? ''
                : pilllist['medicineImage'],
            medicineID: pilllist['medicineId'],
            medicineScheduleId: pilllist['medicineScheduleId'],
            customMedicineId: pilllist['customMedicineId'] ?? -1,
          );
        }
        pills.add(pillsitem);
      }
      pillItemsOtherDay(pills);
    }
  }

  getDetail(MyPillsItem pill) {
    PillsItem pillsitem = PillsItem(
      item_seq: pill.item_seq,
      item_name: pill.item_name,
      medicineCode: '',
      image: pill.image,
      class_name: '',
      entp_name: "",
      dosage: '',
      effect: '',
      ingredient: '',
      method: '',
      validterm: '',
      warning: '',
      combinations: [],
      combinationsnum: 0,
    );
    SearchController.to.getDetail(pillsitem);
  }

  deleteMedicine(MyPillsItem item, int j) {
    showDialog(
        context: Get.context!,
        builder: (context) =>
            MessagePopup(
                title: '약 삭제',
                message: '${item.item_name}을 삭제하시겠습니까?',
                cancelCallback: () => Get.back(),
                okCallback: (() async {
                  log('deleting');
                  pillItems.remove(item);

                  pillItems.refresh();
                  await http.delete(
                      Uri.parse(
                          '${urlBase}medicine?id=${item.medicineScheduleId}'),
                      headers: {
                        'Content-Type': 'application/json; charset=UTF-8',
                        // ignore: prefer_interpolation_to_compose_strings
                        'Authorization': 'Bearer ' + token1.value,
                      });

                  Get.back();
                  // Get.back();
                })));
  }
}
