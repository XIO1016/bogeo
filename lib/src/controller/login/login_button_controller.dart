import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:capstone/network/dio_client.dart';
import 'package:capstone/src/controller/mainhome_controller.dart';
import 'package:dio/dio.dart';

import '../../components/message_popup2.dart';
import '../../http/url.dart';
import 'package:capstone/src/http/url.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../components/message_popup.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../model/mypills.dart';
import '../../model/userData.dart';

enum PageName { ID, PASSWORD }

class LoginButtonController extends GetxController {
  static LoginButtonController get to => Get.find<LoginButtonController>();

  RxInt pageIndex = 0.obs;
  List<int> bottomHistory = [0];
  late TextEditingController idController;
  late TextEditingController passwordController;
  static final storage = FlutterSecureStorage();
  dynamic userInfo = '';

  RxString id = "".obs;
  RxInt age = 0.obs;
  RxString gender = "".obs;
  RxString token1 = "".obs;
  RxString token2 = "".obs;

  RxList<List> pillsdata = [[], [], [], []].obs;
  RxInt pillNum = 0.obs;
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
    print(userInfo);

    // user의 정보가 있다면 로그인 후 들어가는 첫 페이지로 넘어가게 합니다.
    if (userInfo != null) {
      id(jsonDecode(userInfo)['user_id']);
      idController.text = id.toString();
      passwordController.text = jsonDecode(userInfo)['password'];
      apiLogin(1);

      getMyPills();
    } else {
      print('로그인이 필요합니다');
    }
  }

  void apiLogin(int i) async {
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

    if (request.statusCode == 200) {
      log('login----------');
      log(request.body);
      var val = jsonEncode(Login(passwordController.text, idController.text));
      if (i == 0) {
        await storage.write(
          key: 'login',
          value: val,
        );
      }
      token1(jsonDecode(request.body)['accessToken']);
      token2(jsonDecode(request.body)['refreshToken']);
      print(token1);
      print(token2);

      _getProfile(token1.value, token2.value);
      Get.back();
      Get.toNamed('App');
    } else {
      Map<String, dynamic> body = jsonDecode(request.body);
      print(body);
      LoginError('아이디 혹은 비밀번호가 틀렸습니다.');
    }
  }

  @override
  void onClose() {
    idController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> _getProfile(String t1, String t2) async {
    // log('++++++++++++++++++++++++token');
    // log(token1.value);
    // log(token2.value);
    var profileRequest =
        await http.get(Uri.parse('$urlBase$urlProfile?id=$id'), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      // ignore: prefer_interpolation_to_compose_strings
      'Authorization': 'Bearer ' + token1.value,
    });
    if (profileRequest.statusCode == 401) {
      print(profileRequest.headers);

      profileRequest =
          await http.get(Uri.parse('$urlBase$urlProfile?id=$id'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        // ignore: prefer_interpolation_to_compose_strings
        'Authorization': 'Bearer ' + token1.value,
        'refreshToken': 'Bearer ' + token2.value
      });
    } else if (profileRequest.statusCode == 200) {
      print('success!');
      // print(profileRequest.body);
    } else {
      // print(profileRequest.body);
    }
    age(jsonDecode(profileRequest.body)['age']);
    if (jsonDecode(profileRequest.body)['gender'] == 'WOMAN') {
      gender('여자');
    } else {
      gender('남자');
    }
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

  void getUserProfile() async {
    var request = await http.post(Uri.parse(urlBase + urlLogin),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'id': idController.text,
          'password': passwordController.text
        }));
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
}
