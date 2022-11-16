import 'dart:developer';
import 'package:capstone/src/components/Sbox.dart';
import 'package:capstone/src/controller/detailPillController.dart';
import 'package:capstone/src/model/pillsdata.dart';
import 'package:capstone/src/pages/mainhome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../components/text_component.dart';
import 'add/addpilltodata.dart';

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
    return Obx(() => Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon:
                  Icon(Icons.keyboard_arrow_left_rounded, color: Colors.black),
              onPressed: () => Get.back(),
            ),
            title: Text('약 세부사항'),
          ),
          body: SizedBox(
            width: Get.width,
            child: ListView(children: [
              (pillsitem.image == '')
                  ? pillImageWidget()
                  : Image.network(pillsitem.image),
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
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      pillsitem.entp_name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: TabBar(
                        tabs: controller.tabs,
                        controller: controller.tabController,
                        labelColor: Color(0xff0057A8),
                        labelStyle: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        unselectedLabelColor: Color(0xffBABABA),
                        indicatorColor: MainHome.maincolor,
                        indicatorSize: TabBarIndicatorSize.tab,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            (controller.prohibitExist == true)
                                ? Column(
                                    children: [
                                      GestureDetector(
                                        onTap: (() =>
                                            controller.changeProhibitClick()),
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          // ignore: sort_child_properties_last
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  const Icon(Icons
                                                      .warning_amber_rounded),
                                                  Text(
                                                    '병용 금기 약물 존재',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: blackcolor),
                                                  ),
                                                ],
                                              ),
                                              (controller.prohibitClick == true)
                                                  ? Icon(Icons
                                                      .keyboard_arrow_up_rounded)
                                                  : Icon(Icons
                                                      .keyboard_arrow_down_rounded)
                                            ],
                                          ),
                                          width: Get.width,
                                          decoration: BoxDecoration(
                                              color: Color(0xffFFD583),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      (controller.prohibitClick == true)
                                          ? Column(
                                              children: List<Widget>.generate(
                                                  pillsitem.combinationsnum,
                                                  (index) {
                                              return Column(
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    width: Get.width,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0xffF5F5F5),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: RichText(
                                                      text: TextSpan(
                                                        text:
                                                            '${pillsitem.combinations[index]['medicineName']} : ${pillsitem.combinations[index]['prohibitContent'].trim()} ',
                                                        style: TextStyle(
                                                            color: blackcolor,
                                                            fontSize: 16),
                                                      ),
                                                    ),
                                                  ),
                                                  Sbox(0, 8)
                                                ],
                                              );
                                            }))
                                          : Container(),
                                    ],
                                  )
                                : Container(),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text1('효능 효과', Color(0xffBababa)),
                                Sbox(0, 5),
                                Text(
                                  pillsitem.effect,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color(
                                        0xff505050,
                                      ),
                                      height: 1.5),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text1('주성분', Color(0xffBababa)),
                                Sbox(0, 5),
                                Text(pillsitem.ingredient,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color(
                                          0xff505050,
                                        ),
                                        height: 1.5))
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text1('저장방법', Color(0xffBababa)),
                                Sbox(0, 5),
                                Text1(pillsitem.method, Color(0xff505050))
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text1('유효기간', Color(0xffBababa)),
                                Sbox(0, 5),
                                Text1(pillsitem.validterm, Color(0xff505050))
                              ],
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            PlusWidget(pillsitem)
                          ],
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Text(pillsitem.warning,
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Color(
                                      0xff505050,
                                    ),
                                    height: 1.5)),
                            const SizedBox(
                              height: 40,
                            ),
                            PlusWidget(pillsitem)
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              pillsitem.dosage,
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Color(
                                    0xff505050,
                                  ),
                                  height: 1.5),
                            ),
                            const SizedBox(
                              height: 80,
                            ),
                            PlusWidget(pillsitem)
                          ],
                        )
                      ][controller.index.value],
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ));
  }
}

Widget PlusWidget(PillsItem pill) {
  return GestureDetector(
    onTap: () {
      Get.to(() => AddPillToData(), arguments: [0, pill]);
    },
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
