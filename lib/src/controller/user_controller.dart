import 'dart:convert';
import 'package:capstone/network/dio_client.dart';
import 'package:capstone/src/controller/login/login_button_controller.dart';
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

  var dioClient = DioClient(Dio());

  static final storage = FlutterSecureStorage();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    // apiGetProfile();
    super.onReady();
  }

  _asyncMethod() async {
    // print(jwttoken + '222222222');
    // username(jsonDecode(userInfo)['user_id']);

    // print(token1);
    // print(token2);
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
