import 'dart:io';

import 'package:capstone/src/controller/add/addpilltodatacontroller.dart';
import 'package:capstone/src/pages/add/addpilltodata.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../components/text_component.dart';
import '../../model/pillsdata.dart';
import '../mainhome.dart';

class addBySelfPage extends GetView<AddPillToDataController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Padding(
        padding: const EdgeInsets.all(20.0),
        child: NextWidget(),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('약 추가하기'),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_left_rounded,
              color: Colors.black),
          onPressed: () {
            controller.backButton();
          },
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    '약 이름을 입력하세요',
                    style: TextStyle(
                        color: MainHome.blackcolor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text1('추가하고 싶은 약 이름을 입력해주세요.', Color(0xffBABABA)),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 80,
                    width: 250,
                    child: TextField(
                      controller: controller.pillName,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1.8, color: Color(0xff628EFF)),
                            borderRadius: BorderRadius.circular(20)),
                        hintText: '약 이름',
                        hintStyle: const TextStyle(
                            color: Color(0xffE4E4E4), fontSize: 12),
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(width: 1.5),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ),
                ]),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    '약 사진을 추가해주세요',
                    style: TextStyle(
                        color: MainHome.blackcolor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text1('추가하지 않으면 빈 사진으로 저장됩니다.', Color(0xffBABABA)),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                      color: Colors.grey[100],
                      width: 200,
                      height: 200,
                      child: Obx(() => picture())),
                ])
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget NextWidget() {
    return GestureDetector(
      onTap: () {
        var pill = PillsItem(
            image: controller.selectedImagePath.value,
            item_name: controller.pillName.text,
            effect: '',
            ingredient: '',
            item_seq: '',
            combinations: [],
            dosage: '',
            entp_name: '',
            validterm: '',
            method: '',
            medicineCode: '',
            class_name: '',
            warning: '',
            combinationsnum: 0);
        Get.to(() => AddPillToData(), arguments: [0, pill, 2]);
      },
      child: Container(
        width: Get.width,
        height: 60,
        decoration: BoxDecoration(
            color: Color(0xff628EFF), borderRadius: BorderRadius.circular(15)),
        child: const Center(
          child: Text(
            '다음으로',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ),
    );
  }

  Widget picture() {
    return GestureDetector(
      onTap: () {
        controller.getImage(ImageSource.gallery);
      },
      child: Container(
        width: 150,
        height: 130,
        decoration: (controller.selectedImagePath.value == '')
            ? const BoxDecoration(color: Color(0xffF4F4F4))
            : BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: FileImage(File(controller.selectedImagePath.value))),
              ),
        child: Center(
            child: (controller.selectedImagePath.value == '')
                ? const Icon(
                    Icons.photo,
                    color: Colors.grey,
                  )
                : null),
      ),
    );
  }
}
