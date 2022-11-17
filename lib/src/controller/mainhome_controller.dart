import 'dart:convert';
import 'dart:developer';

import 'package:capstone/src/components/image_data.dart';
import 'package:capstone/src/components/message_popup.dart';
import 'package:capstone/src/model/mypills.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../http/url.dart';
import '../model/pillsdata.dart';
import 'login/login_button_controller.dart';

class MainHomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var strToday = DateFormat('MM월 dd일').format(DateTime.now()).obs;
  var strday = DateFormat.E('ko').format(DateTime.now()).obs;

  var image = "".obs;
  RxInt index = 0.obs;
  RxList<List> pillsdata = LoginButtonController.to.pillsdata;
  RxInt pillNum = LoginButtonController.to.pillNum;
  static MainHomeController get to => Get.find<MainHomeController>();
  late TabController tabController;
  RxString token1 = LoginButtonController.to.token1;
  RxString token2 = LoginButtonController.to.token2;
  var id = LoginButtonController.to.id;

  final tabs = [
    Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset('assets/icons/morning.svg'),
          const SizedBox(
            width: 5,
          ),
          const Text('아침')
        ],
      ),
    ),
    Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/icons/noon.svg'),
          const SizedBox(
            width: 5,
          ),
          const Text('점심')
        ],
      ),
    ),
    Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SvgPicture.asset('assets/icons/night.svg'),
          const SizedBox(
            width: 5,
          ),
          const Text('저녁')
        ],
      ),
    ),
  ];

  @override
  Future<void> onInit() async {
    super.onInit();
    tabController = TabController(length: tabs.length, vsync: this);
    tabController.addListener(handleTab);
    // await getMyPills();
    // getMyPills();
    if (DateTime.now().hour <= 10) {
      tabController.index = 0;
      index(0);
    } else if (10 < DateTime.now().hour && DateTime.now().hour <= 17) {
      tabController.index = 1;
      index(1);
    } else {
      tabController.index = 2;
      index(2);
    }
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  handleTab() {
    if (tabController.indexIsChanging) {
      index(tabController.index);
      refresh();
    }
  }

  checkeating(int i, int j) async {
    final item = pillsdata[i][j];

    if (item.iseat == false) {
      item.iseat = true;
    } else {
      item.iseat = false;
    }
    pillsdata.refresh();
    await http
        .patch(Uri.parse('${urlBase}medicine?id=${item.medicineID}'), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      // ignore: prefer_interpolation_to_compose_strings
      'Authorization': 'Bearer ' + token1.value,
    });
  }

  deleteMedicine(MyPillsItem item, int i, int j) {
    showDialog(
        context: Get.context!,
        builder: (context) => MessagePopup(
            title: '약 삭제',
            message: '${item.item_name}을 삭제하시겠습니까?',
            cancelCallback: () => Get.back(),
            okCallback: (() async {
              log('deleting');

              Get.dialog(Center(child: CircularProgressIndicator()),
                  barrierDismissible: false);
              await http.delete(
                  Uri.parse('${urlBase}medicine?id=${item.medicineID}'),
                  headers: {
                    'Content-Type': 'application/json; charset=UTF-8',
                    // ignore: prefer_interpolation_to_compose_strings
                    'Authorization': 'Bearer ' + token1.value,
                  });
              pillsdata[i].remove(item);

              pillsdata.refresh();
              Get.back();
              Get.back();
            })));
  }
}
