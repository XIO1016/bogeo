import 'dart:io';
import 'package:capstone/src/components/message_popup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../pages/mainhome.dart';

enum PageName { HOME, SEARCH, PLUS, EATPILL, USER }

class BottomNavController extends GetxController {
  RxInt pageIndex = 0.obs;
  List<int> bottomHistory = [0];

  void changeBottomNav(int value, {bool hasGesture = true}) {
    var page = PageName.values[value];
    switch (page) {
      case PageName.HOME:
      // Get.to(() => const MainHome());
      // break;
      case PageName.EATPILL:
      case PageName.PLUS:
      case PageName.SEARCH:
      case PageName.USER:
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
      changeBottomNav(index, hasGesture: false);
      print(bottomHistory);

      return false;
    }
  }
}
