import 'dart:developer';

import 'package:capstone/src/controller/mainhome_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class MainHome extends GetView<MainHomeController> {
  MainHome({super.key});

  static List<String> time = ['아침', '점심', '저녁'];
  static List<String> time1 = ['오전', '오후', ''];

  static Color maincolor = const Color(0xff0057A8);
  static Color blackcolor = const Color(0xff505050);
  final controller1 = ScrollController();

  Widget pills(int i) {
    return Column(
      children: [
        Column(children: PillWidgetList(i)),
        (controller.pillsdata[3].length == 0)
            ? const SizedBox()
            : Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  '하루 안에 복용하세요 :)',
                  style: TextStyle(
                      color: blackcolor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
        const SizedBox(
          height: 20,
        ),
        (controller.pillsdata[3].length == 0)
            ? const SizedBox()
            : Column(
                children: PillWidgetList(3),
              )
      ],
    );
  }

  List<Widget> PillWidgetList(int i) {
    var pillsdata = controller.pillsdata[i];
    if ((pillsdata.length == 0)) {
      return [
        Container(
          width: Get.width,
          height: 150,
          child: Center(
            child: Text(
              '먹을 약이 없어요!',
              style: TextStyle(
                  color: blackcolor, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(
          height: 50,
        )
      ];
    } else {
      return List.generate(
        pillsdata.length,
        ((j) => Column(
              children: [
                GestureDetector(
                  onLongPress: () {
                    controller.deleteMedicine(pillsdata[j], i, j);
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    width: Get.width,
                    decoration: BoxDecoration(
                        border: Border.all(width: 0.2, color: blackcolor),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (i < 3)
                              Row(
                                children: [
                                  Text(
                                    '${time1[pillsdata[j].eatingTime3]} ${pillsdata[j].eatingTime}시 ',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(
                                          0xff628EFF,
                                        )),
                                  ),
                                  Text(
                                    '${pillsdata[j].eatingTime2}분에 드세요 ',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(
                                          0xff628EFF,
                                        )),
                                  ),
                                ],
                              )
                            else
                              const SizedBox(
                                width: 150,
                                height: 23,
                              ),
                            Text(
                              '${pillsdata[j].eatingNum}정',
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff505050)),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            (pillsdata[j].image == '')
                                ? Container(
                                    width: 126,
                                    height: 75,
                                    color: Color.fromARGB(255, 179, 179, 179),
                                    child: Center(child: Text('사진 없음')),
                                  )
                                : SizedBox(
                                    width: 126,
                                    height: 75,
                                    child: Image.network(pillsdata[j].image)),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: Get.width - 250,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  RichText(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    text: TextSpan(
                                      text: pillsdata[j].item_name,
                                      style: const TextStyle(
                                          color: Color(0xff505050),
                                          fontSize: 20),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 17,
                                  ),
                                  (pillsdata[j].iseat == false)
                                      ? GestureDetector(
                                          onTap: () {
                                            controller.checkeating(i, j);
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              const Text(
                                                '안먹음',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xffBABABA)),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              SvgPicture.asset(
                                                  'assets/icons/noeat.svg')
                                            ],
                                          ),
                                        )
                                      : GestureDetector(
                                          onTap: () {
                                            controller.checkeating(i, j);
                                            log("i=$i,j=$j");
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                '먹음',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: maincolor),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              SvgPicture.asset(
                                                  'assets/icons/eat.svg')
                                            ],
                                          ),
                                        )
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                )
              ],
            )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SafeArea(
        child: Scaffold(
          appBar: ScrollAppBar(
            controller: controller1,
            elevation: 0,
            automaticallyImplyLeading: false,
            titleSpacing: 20,
            title: Text(
              'Bogeo',
              style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'Space',
                  fontWeight: FontWeight.w600,
                  color: maincolor),
            ),
          ),
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(overscroll: false),
                child: ListView(
                  controller: controller1,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: [
                    Row(
                      children: [
                        Text(
                          controller.strToday.value,
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff505050)),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          controller.strday.value + '요일',
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              color: Color(0xff505050)),
                        )
                      ],
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
                            fontSize: 20, fontWeight: FontWeight.bold),
                        unselectedLabelColor: Color(0xffBABABA),
                        indicatorColor: Colors.transparent,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: [
                        pills(0),
                        pills(1),
                        pills(2),
                      ][controller.index.value],
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
