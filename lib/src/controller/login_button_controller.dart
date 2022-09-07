import 'dart:io';

import 'package:capstone/src/app.dart';
import 'package:capstone/src/http/url.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/message_popup.dart';
import '../http/request.dart';

enum PageName { ID, PASSWORD }

class LoginButtonController extends GetxController {
  RxInt pageIndex = 0.obs;
  List<int> bottomHistory = [0];
  late TextEditingController idController;
  late TextEditingController passwordController;

  @override
  void onInit() {
    idController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
  }

  void apiLogin() async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    Request request = Request(
        url: urlLogin,
        body: {'id': idController.text, 'password': passwordController.text});
    request.post().then((value) {
      Get.back();
      Get.offNamed('App');
    }).catchError((onError) {});
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
}