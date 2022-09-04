import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageData extends StatelessWidget {
  String icon;
  final double? width;
  ImageData(
    this.icon, {
    Key? key,
    this.width = 55,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      icon,
      width: width! / Get.mediaQuery.devicePixelRatio,
    );
  }
}

class IconsPath {
  static String get homeOn => 'assets/images/home.png';
  static String get homeOff => 'assets/images/homeoff.png';
  static String get eatpillOn => 'assets/images/eatpill.png';
  static String get eatpillOff => 'assets/images/eatpilloff.png';
  static String get pillOn => 'assets/images/pill.png';
  static String get pillOff => 'assets/images/pilloff.png';
  static String get userOn => 'assets/images/user.png';
  static String get userOff => 'assets/images/useroff.png';
  static String get plus => 'assets/images/plus.png';
}
