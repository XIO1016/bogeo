import 'package:capstone/src/controller/login/login_button_controller.dart';
import 'package:capstone/src/model/myallpills.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../http/url.dart';

class UserController extends GetxController {
  RxString id = LoginButtonController.to.id;
  RxInt userage = LoginButtonController.to.age;
  RxString usergen = LoginButtonController.to.gender;

  dynamic userInfo = '';
  int allPillNum = 0;
  RxList allPill = [].obs;
  @override
  void onInit() {
    super.onInit();
    _asyncMethod();
  }

  @override
  void onReady() {
    // apiGetProfile();
    super.onReady();
  }

  _asyncMethod() async {
    allPillNum = 1;
    allPill.add(MyAllPillsItem(day: '2022-10-11', item_name: '타이레놀 100mg 정'));
  }

  // void apiGetProfile() async {
  //   var request =
  //       await http.get(Uri.parse('$urlBase$urlProfile?id=$id'), headers: {
  //     'Content-Type': 'application/json; charset=UTF-8',
  //     'Authorization': 'Bearer ' + token1,
  //     'refreshToken': 'Bearer ' + token2
  //   });

  //   print("profile error");
  //   print(request.body);
  // }
}
