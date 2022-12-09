import 'package:capstone/src/pages/mainhome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/add/addPillWithCameraController.dart';
import '../searchpill.dart';

class AddPillwithOcr extends GetView<AddPillwithCameraController> {
  List ocrList = Get.arguments[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text('OCR 결과', style: TextStyle(fontSize: 16)),
        centerTitle: true,
        leading: IconButton(
          color: MainHome.blackcolor,
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
            children:
                List.generate(ocrList.length, (index) => box(ocrList[index]))),
      ),
    );
  }

  Widget box(String i) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Get.to(() => SearchPillPage(), arguments: [true, 2]);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 1,
                color: Color(0xffE4E4E4),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(30, 40, 30, 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$i 추가하기',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: MainHome.blackcolor),
                ),
                const Icon(
                  Icons.search,
                  color: Colors.grey,
                  size: 40,
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}
