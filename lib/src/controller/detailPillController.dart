import 'dart:developer';

import 'package:capstone/src/controller/seachpill_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailPillController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxBool prohibitClick = false.obs;

  RxString prohibitMedicine = SearchController.to.prohibitPills;
  RxBool prohibitExist = SearchController.to.prohibitExist;
  RxInt index = 0.obs;
  late TabController tabController;
  final tabs = [
    Tab(child: const Text('기본 정보')),
    Tab(child: const Text('주의 사항')),
    Tab(child: const Text('복용 방법')),
  ];

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: tabs.length, vsync: this);
    tabController.addListener(handleTab);
  }

  handleTab() {
    if (tabController.indexIsChanging) {
      index(tabController.index);
      refresh();
    }
  }

  Future changeProhibitClick() async {
    log(prohibitClick.toString());
    if (prohibitClick == true) {
      prohibitClick(false);
    } else {
      prohibitClick(true);
    }
  }
}
