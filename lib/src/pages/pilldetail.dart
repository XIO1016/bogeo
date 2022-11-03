import 'dart:ui';
import 'dart:developer';
import 'package:capstone/src/controller/detailPillController.dart';
import 'package:capstone/src/model/pillsdata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class DetailPillPage extends GetView<DetailPillController> {
  PillsItem pillsitem = Get.arguments;
  Color blackcolor = Color(0xff505050);

  Widget pillImageWidget() {
    return Container(
      width: Get.width,
      height: 211,
      color: Color(0xFFCCC7C7),
      child: Center(child: Text('이미지 없음')),
    );
  }

  @override
  Widget build(BuildContext context) {
    log(pillsitem.item_name);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text('detail'),
      ),
      body: SizedBox(
        width: Get.width,
        child: ListView(children: [
          pillImageWidget(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: Get.width,
                  child: RichText(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    text: TextSpan(
                      text: pillsitem.item_name,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: blackcolor),
                    ),
                  ),
                ),
                Text(
                  pillsitem.entp_name,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.normal),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: (() => controller.changeProhibitClick()),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    // ignore: sort_child_properties_last
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.warning_amber_rounded),
                            Text(
                              '병용 금기 약물 존재',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: blackcolor),
                            ),
                          ],
                        ),
                        (controller.prohibitClick == true)
                            ? Icon(Icons.keyboard_arrow_up_rounded)
                            : Icon(Icons.keyboard_arrow_down_rounded)
                      ],
                    ),
                    width: Get.width,
                    decoration: BoxDecoration(
                        color: Color(0xffFFD583),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                )
              ],
            ),
          ),
          Image.network(
              'https://nedrug.mfds.go.kr/pbp/cmn/itemImageDownload/151335249722200065')
        ]),
      ),
    );
  }
}
