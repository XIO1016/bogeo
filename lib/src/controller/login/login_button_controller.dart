import 'dart:convert';
import 'dart:io';
import '../../components/message_popup2.dart';
import '../../http/url.dart';
import 'package:capstone/src/http/url.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../components/message_popup.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../model/userData.dart';

enum PageName { ID, PASSWORD }

class LoginButtonController extends GetxController {
  RxInt pageIndex = 0.obs;
  List<int> bottomHistory = [0];
  late TextEditingController idController;
  late TextEditingController passwordController;
  static final storage = FlutterSecureStorage();
  dynamic userInfo = '';
  @override
  void onInit() {
    idController = TextEditingController();
    passwordController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
    super.onInit();
  }

  _asyncMethod() async {
    // read 함수로 key값에 맞는 정보를 불러오고 데이터타입은 String 타입
    // 데이터가 없을때는 null을 반환
    userInfo = await storage.read(key: 'login');

    // user의 정보가 있다면 로그인 후 들어가는 첫 페이지로 넘어가게 합니다.
    if (userInfo != null) {
      Get.offNamed('/App');
    } else {
      print('로그인이 필요합니다');
    }
  }

  void apiLogin() async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    var request = await http.post(Uri.parse(urlBase + urlLogin),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'id': idController.text,
          'password': passwordController.text
        }));
    print(request);
    print(idController.text);
    print(passwordController.text);

    if (request.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(request.body);
      var val = jsonEncode(Login(passwordController.text, idController.text));
      await storage.write(
        key: 'login',
        value: val,
      );
      print(body);
      Get.back();
      Get.offNamed('App');
    } else {
      Map<String, dynamic> body = jsonDecode(request.body);
      print(body);
      LoginError(body['message']);
    }
    // request.post().then((value) {
    //   Get.back();
    //   Get.offNamed('App');
    // }).catchError((onError) {});
  }

  @override
  void onClose() {
    idController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void changeloginpage(int value, {bool hasGesture = true}) {
    var page = PageName.values[value];
    switch (page) {
      case PageName.ID:
      case PageName.PASSWORD:
        _changePage(value, hasGesture: hasGesture);
        break;
    }
  }

  void _changePage(int value, {bool hasGesture = true}) {
    pageIndex(value);
    if (!hasGesture) return;
    if (bottomHistory.contains(value)) {
      bottomHistory.remove(value);
    }
    bottomHistory.add(value);
    print(bottomHistory);
  }

  Future<bool> willPopAction() async {
    if (bottomHistory.length == 1) {
      showDialog(
          context: Get.context!,
          builder: (context) => MessagePopup(
                message: '종료하시겠습니까?',
                okCallback: () {
                  exit(0);
                },
                cancelCallback: Get.back,
                title: '복어',
              ));
      return true;
    } else {
      bottomHistory.removeLast();
      var index = bottomHistory.last;
      changeloginpage(index, hasGesture: false);
      print(bottomHistory);

      return false;
    }
  }

  Future<bool> LoginError(String message) async {
    showDialog(
        context: Get.context!,
        builder: (context) => MessagePopup2(
              message: message,
              okCallback: () {
                Get.back();
                Get.back();
              },
              title: '복어',
            ));
    return true;
  }
}
