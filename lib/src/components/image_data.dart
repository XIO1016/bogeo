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
  static String get pillType1 => 'assets/images/pill1.png';
  static String get pillType2 => 'assets/images/pill2.png';
  static String get pillType3 => 'assets/images/pill3.png';
  static String get disease => 'assets/images/disease.png';
  static String get drugs => 'assets/images/drugs.png';
  static String get allergy => 'assets/images/allergy.png';
  static String get extra => 'assets/images/inspection.png';
}
