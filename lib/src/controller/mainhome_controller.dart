import 'dart:developer';

import 'package:capstone/src/components/image_data.dart';
import 'package:capstone/src/model/mypills.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MainHomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var strToday = DateFormat('MM월 dd일').format(DateTime.now()).obs;
  var strday = DateFormat.E('ko').format(DateTime.now()).obs;
  RxInt pillNum = 0.obs;
  var image = "".obs;
  RxInt index = 0.obs;
  RxList<List> pillsdata = [[], [], [], []].obs;

  late TabController tabController;

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
  void onInit() {
    super.onInit();
    tabController = TabController(length: tabs.length, vsync: this);
    tabController.addListener(handleTab);
    getMyPills();
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

  checkeating(int i, int j) {
    final item = pillsdata[i][j];
    log(item.toString());
    if (item.iseat == false) {
      item.iseat = true;
    } else {
      item.iseat = false;
    }
    pillsdata.refresh();
  }

  Future getMyPills() async {
    pillNum(3);
    pillsdata[0].add(MyPillsItem(
        item_seq: '1',
        item_name: '타이레놀',
        eatingTime: '7',
        eatingTime3: 0,
        iseat: false,
        eatingNum: 1,
        eatingTime2: 0));

    pillsdata[0].add(MyPillsItem(
        item_seq: '2',
        item_name: '타이레놀3정하이고얍e33333333333333333333e',
        eatingTime: '9',
        eatingTime3: 0,
        iseat: false,
        eatingNum: 1,
        eatingTime2: 0));

    pillsdata[3].add(MyPillsItem(
        item_seq: '3',
        item_name: '타이레아무때나333e',
        eatingTime: '0',
        eatingTime3: 2,
        iseat: false,
        eatingNum: 3,
        eatingTime2: 3));
    pillsdata[3].add(MyPillsItem(
        item_seq: '3',
        item_name: '타이레아무때나333e',
        eatingTime: '0',
        eatingTime3: 2,
        iseat: false,
        eatingNum: 3,
        eatingTime2: 3));
  }

  void getImage(int index) {
    switch (index) {
      case 0:
        //조제약
        image(IconsPath.pillType1);
        return;
      //상비약
      case 1:
        image(IconsPath.pillType2);
        return;
      //비타민
      case 2:
        image(IconsPath.pillType3);
        return;
    }
  }
}
