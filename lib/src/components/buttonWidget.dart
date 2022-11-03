import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget PlusWidget() {
  return GestureDetector(
    onTap: () {},
    child: Container(
      width: Get.width,
      height: 60,
      decoration: BoxDecoration(
          color: Color(0xff628EFF), borderRadius: BorderRadius.circular(15)),
      child: const Center(
        child: Text(
          '약 추가하기',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    ),
  );
}
