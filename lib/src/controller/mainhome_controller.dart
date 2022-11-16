import 'dart:convert';
import 'dart:developer';

import 'package:capstone/src/components/image_data.dart';
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
  void onInit() {
    super.onInit();
    tabController = TabController(length: tabs.length, vsync: this);
    tabController.addListener(handleTab);
    // getMyPills();
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
    log('token1');
    log(token1.value);

    var todayyear = DateTime.now().year;
    var todaymonth = DateTime.now().month;
    var todayday = DateTime.now().day;
    var getMedicineRequest = await http.get(
        Uri.parse(
            '${urlBase}medicine?id=${id}&year=$todayyear&month=$todaymonth&day=$todayday'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          // ignore: prefer_interpolation_to_compose_strings
          'Authorization': 'Bearer ' + token1.value,
          'refreshToken': 'Bearer ' + token2.value,
        });
    log(getMedicineRequest.body);
    if (getMedicineRequest.statusCode == 200) {
      List<dynamic> pillslist = jsonDecode(getMedicineRequest.body);
      pillNum(pillslist.length);
      for (int i = 0; i < pillslist.length; i++) {
        int eatingTime3 = 2; //오전 오후
        Map pilllist = pillslist[i];
        var pillsitem;

        if (pilllist['hasMedicineTime']) {
          List time = pilllist['medicineTime'].split(':')[0];

          if (int.parse(time[0]) >= 12) {
            eatingTime3 = 1;
          } else {
            eatingTime3 = 2;
          }
          pillsitem = MyPillsItem(
            item_seq: pilllist['medicineSeq'],
            item_name: pilllist['medicineName'],
            eatingNum: pilllist['dosage'],
            eatingTime: time[0],
            eatingTime3: eatingTime3,
            endDay: (pilllist['hasEndDay']) ? pilllist['endDay'] : '',
            hasEndDay: pilllist['hasEndDay'],
            iseat: pilllist['activated'],
            period: pilllist['period'],
          );
          if (int.parse(time[0]) <= 9) {
            pillsdata[0].add(pillsitem);
          } else if (9 < int.parse(time[0]) && int.parse(time[0]) <= 17) {
            pillsdata[1].add(pillsitem);
          } else {
            pillsdata[2].add(pillsitem);
          }
        } else {
          pillsitem = MyPillsItem(
            item_seq: pilllist['medicineSeq'],
            item_name: pilllist['medicineName'],
            eatingNum: pilllist['dosage'],
            eatingTime: '0',
            eatingTime3: eatingTime3,
            endDay: (pilllist['hasEndDay']) ? pilllist['endDay'] : '',
            hasEndDay: pilllist['hasEndDay'],
            iseat: pilllist['activated'],
            period: pilllist['period'],
          );
          pillsdata[3].add(pillsitem);
        }
      }
    }
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
