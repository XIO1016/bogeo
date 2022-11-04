import 'dart:convert';
import 'dart:developer';
import 'package:capstone/src/controller/login/login_button_controller.dart';

import 'package:capstone/network/dio_client.dart';
import 'package:capstone/src/model/pillsdata.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../http/url.dart';

class SearchController extends GetxController {
  static SearchController get to => Get.find<SearchController>();
  TextEditingController searchTextEditingController = TextEditingController();

  RxList pillsitems = [].obs;
  late PillsItem pillsitem;
  RxInt resultNum = 0.obs;
  RxString token1 = LoginButtonController.to.token1;
  var token2 = LoginButtonController.to.token2;

  RxString prohibitPills = "".obs;
  RxBool prohibitExist = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  getPillsFromData() async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    pillsitems([]);
    resultNum(0);

    var SearchRequest = await http.get(
        Uri.parse('$pillurl${searchTextEditingController.text}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          // ignore: prefer_interpolation_to_compose_strings
          'Authorization': 'Bearer ' + token1.value,
        });
    if (SearchRequest.statusCode == 200) {
      Get.back();
      List<dynamic> pillslist = jsonDecode(SearchRequest.body);
      resultNum(pillslist.length);
      for (int i = 0; i < pillslist.length; i++) {
        Map pilllist = pillslist[i];
        pillsitem = PillsItem(
            item_seq: pilllist['itemSeq'],
            item_name: pilllist['itemName'],
            medicineCode: pilllist['medicineCode'],
            image: pilllist['image'] ?? '',
            class_name: pilllist['className'] ?? '');

        pillsitems.add(pillsitem);
      }

      pillsitems.sort((a, b) => b.image.compareTo(a.image));
      print(pillsitems.toString());
      // log('${pillslist.length}');
    }

    Future getProhibit() async {
      prohibitExist(true);
      prohibitPills('타이레놀, 비타민C 1000: 중증의 위장관계 이상 초래');
    }
  }
}
