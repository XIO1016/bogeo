import 'dart:ui';
import 'dart:developer';
import 'package:capstone/src/controller/detailPillController.dart';
import 'package:capstone/src/model/pillsdata.dart';
import 'package:capstone/src/pages/mainhome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../components/buttonWidget.dart';
import '../components/text_component.dart';

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
                                          ? Container(
                                              padding: const EdgeInsets.all(8),
                                              width: Get.width,
                                              decoration: BoxDecoration(
                                                  color: Color(0xffF5F5F5),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Text(
                                                controller
                                                    .prohibitMedicine.value,
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            )
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
                                Text1('data', Color(0xff505050))
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text1('주성분', Color(0xffBababa)),
                                Text1('data', Color(0xff505050))
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text1('저장방법', Color(0xffBababa)),
                                Text1('data', Color(0xff505050))
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text1('유효기간', Color(0xffBababa)),
                                Text1('data', Color(0xff505050))
                              ],
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            PlusWidget()
                          ],
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Text1('주의사항', Color(0xff505050)),
                            const SizedBox(
                              height: 40,
                            ),
                            PlusWidget()
                          ],
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Text1('복용방법', Color(0xff505050)),
                            const SizedBox(
                              height: 40,
                            ),
                            PlusWidget()
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
