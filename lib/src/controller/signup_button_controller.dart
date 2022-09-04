import 'dart:io';

import 'package:capstone/src/http/request.dart';
import 'package:capstone/src/http/url.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app.dart';
import '../components/message_popup.dart';

enum PageName { ID, PASSWORD, CONFIRMPASS, AGE, GENDER }

class SignUpButtonController extends GetxController {
  RxList<Map<String, dynamic>> gen = [
    {'state': '남자', 'isCheck': false},
    {'state': '여자', 'isCheck': false},
  ].obs;

  RxInt pageIndex = 0.obs;
  List<int> bottomHistory = [0];
  late TextEditingController idController;
  late TextEditingController passwordController;
  late TextEditingController confirmpasswordController;
  late TextEditingController ageController;
  late TextEditingController genderController;
  @override
  void onInit() {
    idController = TextEditingController();
    passwordController = TextEditingController();
    confirmpasswordController = TextEditingController();
    ageController = TextEditingController();
    genderController = TextEditingController();

    super.onInit();
  }

  void Idoverlap() async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
  }

  void Passconfirm() async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
  }

  void apiSignUp() async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    Request request = Request(url: urlSignUp, body: {
      'id': idController.text,
      'password': passwordController.text,
      'confirmpassword': confirmpasswordController.text,
      'age': ageController.text,
      'gender': genderController.text
    });
    request.post().then((value) {
      Get.back();
      Get.offNamed('App');
    }).catchError((onError) {});
  }

  @override
  void onClose() {
    idController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();
    ageController.dispose();
    genderController.dispose();
    super.onClose();
  }

  void changeGen(int index) {
    for (int bi = 0; bi < 2; bi++) {
      if (bi == index) {
        gen[index]['isCheck'] = true;
      } else {
        gen[bi]['isCheck'] = false;
      }
    }
    gen.refresh();
    print(gen.value[0]);
  }

  void changesignuppage(int value, {bool hasGesture = true}) {
    var page = PageName.values[value];
    switch (page) {
      case PageName.ID:
      // Get.to(() => const MainHome());
      // break;
      case PageName.PASSWORD:
      case PageName.CONFIRMPASS:
      case PageName.AGE:
      case PageName.GENDER:
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
      changesignuppage(index, hasGesture: false);
      print(bottomHistory);

      return false;
    }
  }
}
