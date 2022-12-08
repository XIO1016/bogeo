import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:capstone/src/http/url.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

import '../../app.dart';
import '../../model/pillsdata.dart';
import '../login/login_button_controller.dart';

class AddPillToDataController extends GetxController {
  static AddPillToDataController get to => Get.find<AddPillToDataController>();
  var id = LoginButtonController.to.id;
  RxString token1 = LoginButtonController.to.token1;
  RxInt postType = 0.obs;
  RxInt eatPeriod = 0.obs;
  List week = ['월', '화', '수', '목', '금', '토', '일'];
  TextEditingController pillName = TextEditingController();
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
  var selectedImagePath = ''.obs;

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
        if (time == 24) {
          time = 0;
        }
      }
    } else {
      time = -1;
    }
    var request;
    if (postType.value == 1) {
      request = await http.post(
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
      log(utf8.decode(request.bodyBytes));
      if (request.statusCode == 200) {
        Get.to(App());

        LoginButtonController.to.getMyPills();
        LoginButtonController.to.getMyallPills();
      }
    } else if (postType.value == 2) {
      request = http.MultipartRequest(
        'POST',
        Uri.parse('${urlBase}custom/medicine'),
      );
      log('시작');
      request.headers.addAll({
        "Accept": "application/json",
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + token1.value,
      });
      var f =
          await http.MultipartFile.fromPath('file', selectedImagePath.value);
      request.files.add(f);
      request.files.add(
        http.MultipartFile.fromBytes(
          'medicineDto',
          utf8.encode(jsonEncode(<String, dynamic>{
            'userId': id.value,
            'medicineName': pillName.text,
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
          })),
          contentType: MediaType(
            'application',
            'json',
            {'charset': 'utf-8'},
          ),
        ),
      );
      log('성공');
      var response = await request.send();
      log(response.statusCode.toString());
      // log(player.fields.values.toString());
      log(request.files.toString());

      if (response.statusCode == 200) {
        Get.to(App());

        LoginButtonController.to.getMyPills();
        LoginButtonController.to.getMyallPills();
      }
    } else {
      log('ERROR');
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

  void getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      selectedImagePath(pickedFile.path);
      update();
    } else {}
  }

  Widget validateImage(String imageUrl) {
    if (Uri.parse(imageUrl).isAbsolute) {
      return Image.network(
        imageUrl,
        width: 117,
        height: 65,
      );
    } else {
      return Image(
        image: FileImage(File(selectedImagePath.value)),
        width: 117,
        height: 65,
      );
    }
  }
}
