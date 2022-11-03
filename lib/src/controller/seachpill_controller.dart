import 'dart:convert';
import 'dart:developer';
import 'package:xml/xml.dart';

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
  late XmlDocument pillSearchXml;
  List<PillsItem> pillsitems = [];
  late PillsItem pillsitem;
  RxInt resultNum = 0.obs;
  int pageNo = 1;
  int numOfRows = 100;
  RxString prohibitPills = "".obs;
  RxBool prohibitExist = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  getPillsFromData() async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    pillsitems = [];
    var profileRequest = await http.get(
      Uri.parse(
          '$pillurl&pageNo=$pageNo&numOfRows=$numOfRows&type=xml&item_name=${searchTextEditingController.text}'),
    );
    pillSearchXml = XmlDocument.parse(utf8.decode(profileRequest.bodyBytes));
    log('${profileRequest.statusCode}');
    if (profileRequest.statusCode == 200) {
      Get.back();
    }

    final items = pillSearchXml.findAllElements('item');
    resultNum(
        int.parse(pillSearchXml.findAllElements('totalCount').first.text));
    log('${items.length}');
    items.forEach((element) {
      // print('eeeeeeeeeeeee')
      // print(element);

      pillsitem = PillsItem(
          item_seq: element.findAllElements('ITEM_SEQ').first.text,
          item_name: element.findAllElements('ITEM_NAME').first.text,
          entp_name: element.findAllElements('ENTP_NAME').first.text,
          etc_otc_code: element.findAllElements('ETC_OTC_CODE').first.text,
          material_name: element.findAllElements('MATERIAL_NAME').first.text,
          storage_method: element.findAllElements('STORAGE_METHOD').first.text,
          valid_term: element.findAllElements('VALID_TERM').first.text,
          caution: element.findAllElements('NB_DOC_DATA').first.text,
          effect: element.findAllElements('EE_DOC_DATA').first.text);
      pillsitems.add(pillsitem);
      // log(pillsitem.item_name);
    });
    log('${pillsitems.length}');

    // print(profileRequest.body);
    // print('eeeeeeeeeeeeeeeeeee');
    // print(resultNum);
    // print(pillsitem);
  }

  Future getProhibit() async {
    prohibitExist(true);
    prohibitPills('타이레놀, 비타민C 1000: 중증의 위장관계 이상 초래');
  }
}
