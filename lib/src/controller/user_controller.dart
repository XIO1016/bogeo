import 'package:capstone/src/controller/login/login_button_controller.dart';
import 'package:capstone/src/controller/seachpill_controller.dart';
import 'package:capstone/src/model/myallpills.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../http/url.dart';
import '../model/pillsdata.dart';

class UserController extends GetxController {
  RxString id = LoginButtonController.to.id;
  RxInt userage = LoginButtonController.to.age;
  RxString usergen = LoginButtonController.to.gender;
  RxList myallpills = LoginButtonController.to.myallpills;
  RxInt pillNum = LoginButtonController.to.pillNum;
  dynamic userInfo = '';
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    // apiGetProfile();
    super.onReady();
  }

  getDetail(MyAllPillsItem pill) {
    PillsItem pillsitem = PillsItem(
      item_seq: pill.medicineSeq,
      item_name: pill.medicineName,
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
}
