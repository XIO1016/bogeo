import 'dart:ui';

import 'package:capstone/src/pages/mainhome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final notifications = FlutterLocalNotificationsPlugin();

//1. 앱로드시 실행할 기본설정
initNotification() async {
  //안드로이드용 아이콘파일 이름
  var androidSetting = AndroidInitializationSettings('app_icon');

  //ios에서 앱 로드시 유저에게 권한요청하려면
  // var iosSetting = IOSInitializationSettings(
  //   requestAlertPermission: true,
  //   requestBadgePermission: true,
  //   requestSoundPermission: true,
  // );

  var initializationSettings = InitializationSettings(
    android: androidSetting,
    // iOS: iosSetting
  );
  await notifications.initialize(initializationSettings,
      onDidReceiveNotificationResponse: (payload) {
    Get.to(() => MainHome());
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (c) => Text('새로운페이지')));
  }
      //알림 누를때 함수실행하고 싶으면
      //onSelectNotification: 함수명추가

      );
}

//2. 이 함수 원하는 곳에서 실행하면 알림 뜸
showNotification() async {
  var androidDetails = const AndroidNotificationDetails(
    '유니크한 알림 채널 ID',
    '알림종류 설명',
    priority: Priority.high,
    importance: Importance.max,
    color: Color.fromARGB(255, 255, 0, 0),
  );

  // var iosDetails = IOSNotificationDetails(
  //   presentAlert: true,
  //   presentBadge: true,
  //   presentSound: true,
  // );

  // 알림 id, 제목, 내용 맘대로 채우기
  notifications.show(
      1,
      '제목1',
      '내용1',
      NotificationDetails(
        android: androidDetails,
        // iOS: iosDetails
      ),
      payload: '부가정보' // 부가정보
      );
}

showNotification2(String name, int time1, int time2, int id) async {
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Asia/Seoul'));
  var androidDetails = AndroidNotificationDetails(
    id.toString(),
    '약 복용할 시간입니다',
    priority: Priority.high,
    importance: Importance.max,
    color: Color.fromARGB(255, 255, 0, 0),
  );
  // var iosDetails = const IOSNotificationDetails(
  //   presentAlert: true,
  //   presentBadge: true,
  //   presentSound: true,
  // );

  notifications.zonedSchedule(
      2,
      '복어',
      '$name을 복용할 시간입니다!',
      // tz.TZDateTime.now(tz.local).add(Duration(seconds: 5)),
      makeDate(time1, time2, 0),
      NotificationDetails(
        android: androidDetails,
        // iOS: iosDetails
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime);
}

makeDate(hour, min, sec) {
  var now = tz.TZDateTime.now(tz.local);

  var when =
      tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, min, sec);

  if (when.isBefore(now)) {
    return when.add(Duration(days: 1));
  } else {
    return when;
  }
}
