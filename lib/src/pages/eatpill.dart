import 'dart:developer';

import 'package:capstone/src/controller/eatpillController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../components/Sbox.dart';
import 'mainhome.dart';

class EatPillPage extends GetView<eatpillController> {
  EatPillPage({super.key});
  var today = DateTime.now();

  static List<String> time1 = ['오전', '오후', ''];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(children: [
            Column(
              children: [
                Obx(() => TableCalendar(
                      headerStyle: const HeaderStyle(
                          titleTextStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                          formatButtonVisible: true,
                          titleCentered: true,
                          leftChevronVisible: true,
                          rightChevronVisible: true,
                          formatButtonPadding:
                              EdgeInsets.fromLTRB(10, 5, 10, 5),
                          leftChevronPadding:
                              EdgeInsets.symmetric(horizontal: 30),
                          rightChevronPadding:
                              EdgeInsets.symmetric(horizontal: 20),
                          headerPadding: EdgeInsets.only(top: 20, bottom: 30)),
                      calendarFormat: controller.calendarFormat.value,
                      availableCalendarFormats: const {
                        CalendarFormat.month: '한달',
                        CalendarFormat.week: '1주',
                      },
                      formatAnimationCurve: Curves.easeInOutCirc,
                      formatAnimationDuration: Duration(milliseconds: 300),
                      onFormatChanged: (format) =>
                          controller.calendarFormat(format),
                      locale: 'ko-KR',
                      calendarBuilders:
                          CalendarBuilders(dowBuilder: (context, day) {
                        switch (day.weekday) {
                          case 6:
                            return const Center(
                              child: Text(
                                '토',
                                style: TextStyle(color: Colors.blue),
                              ),
                            );
                          case 7:
                            return const Center(
                              child: Text(
                                '일',
                                style: TextStyle(color: Colors.red),
                              ),
                            );
                        }
                      }),
                      daysOfWeekHeight: 30,
                      selectedDayPredicate: (day) {
                        return isSameDay(controller.selecteddate.value, day);
                      },
                      firstDay: DateTime(
                          DateTime.now().year, DateTime.now().month, 1),
                      focusedDay: controller.focuseddate.value,
                      lastDay: DateTime(2023, 12, 31),
                      onDaySelected: (selectedDay, focusedDay) {
                        if (!isSameDay(
                            controller.selecteddate.value, selectedDay)) {
                          controller.selecteddate(selectedDay);
                          controller.focuseddate(focusedDay);

                          log(controller.selecteddate.value.toString());
                        }
                      },
                    )),
                Sbox(0, 20),
                Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ('${controller.selecteddate.value.year}${controller.selecteddate.value.month}${controller.selecteddate.value.day}' ==
                              '${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}')
                          ? Text(
                              '${controller.selecteddate.value.month}월 ${controller.selecteddate.value.day}일 ${DateFormat('E', 'ko').format(controller.selecteddate.value)}요일(오늘)',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal),
                            )
                          : Text(
                              '${controller.selecteddate.value.month}월 ${controller.selecteddate.value.day}일 ${DateFormat('E', 'ko').format(controller.selecteddate.value)}요일',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal),
                            ),
                      Sbox(0, 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () => controller.changeClick(),
                            child: Text(
                              '미복용한 약',
                              style: (controller.iseatclick.value == 0)
                                  ? TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: MainHome.maincolor)
                                  : TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xffBABABA)),
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 28,
                            color: Color(0xffbababa),
                          ),
                          GestureDetector(
                            onTap: () => controller.changeClick(),
                            child: Text(
                              '복용한 약',
                              style: (controller.iseatclick.value == 1)
                                  ? TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: MainHome.maincolor)
                                  : TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xffBABABA)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      [
                        Column(
                          children: PillWidgetList(0),
                        ),
                        Column(
                          children: PillWidgetList(1),
                        ),
                      ][controller.iseatclick.value]
                    ],
                  ),
                )
              ],
            ),
          ]),
        ),
      ),
    );
  }

  List<Widget> PillWidgetList(int x) {
    // var pillsdata = controller.pillsdata[i];
    var pillsdata = controller.pillsdata[0] +
        controller.pillsdata[1] +
        controller.pillsdata[2] +
        controller.pillsdata[3];
    if (x == 0) {
      return (pillsdata.length == 0)
          ? [
              Container(
                width: Get.width,
                height: 150,
                child: Center(
                  child: Text(
                    '먹을 약이 없어요!',
                    style: TextStyle(
                        color: MainHome.blackcolor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              )
            ]
          : List.generate(
              pillsdata.length,
              ((j) => (pillsdata[j].iseat == false)
                  ? Column(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(30, 20, 30, 30),
                          width: Get.width,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 0.2, color: MainHome.blackcolor),
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  (pillsdata[j].eatingTime != 0)
                                      ? Text(
                                          '${time1[pillsdata[j].eatingTime3]} ${pillsdata[j].eatingTime}시에 드세요',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Color(
                                                0xff628EFF,
                                              )),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 170,
                                        child: RichText(
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          text: TextSpan(
                                            text: pillsdata[j].item_name,
                                            style: const TextStyle(
                                                color: Color(0xff505050),
                                                fontSize: 20),
                                          ),
                                        ),
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
                                  Text(
                                    '약 정보 보기 >',
                                    style: TextStyle(
                                        color: Color(0xffE4E4E4),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 126,
                                    height: 68,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  SizedBox(
                                    width: Get.width - 250,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        const SizedBox(
                                          height: 17,
                                        ),
                                        (pillsdata[j].iseat == false)
                                            ? GestureDetector(
                                                onTap: () {
                                                  controller.checkeating(
                                                      pillsdata, j);
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    const Text(
                                                      '안먹음',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color(
                                                              0xffBABABA)),
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
                                                  controller.checkeating(
                                                      pillsdata, j);
                                                  log("i=$pillsdata,j=$j");
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      '먹음',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: MainHome
                                                              .maincolor),
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
                        const SizedBox(
                          height: 30,
                        )
                      ],
                    )
                  : SizedBox()),
            );
    } else {
      return (pillsdata.length == 0)
          ? [
              Container(
                width: Get.width,
                height: 150,
                child: Center(
                  child: Text(
                    '먹을 약이 없어요!',
                    style: TextStyle(
                        color: MainHome.blackcolor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              )
            ]
          : List.generate(
              pillsdata.length,
              ((j) => (pillsdata[j].iseat == true)
                  ? Column(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(30, 20, 30, 30),
                          width: Get.width,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 0.2, color: MainHome.blackcolor),
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  (pillsdata[j].eatingTime != 0)
                                      ? Text(
                                          '${time1[pillsdata[j].eatingTime3]} ${pillsdata[j].eatingTime}시에 드세요',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Color(
                                                0xff628EFF,
                                              )),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 170,
                                        child: RichText(
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          text: TextSpan(
                                            text: pillsdata[j].item_name,
                                            style: const TextStyle(
                                                color: Color(0xff505050),
                                                fontSize: 20),
                                          ),
                                        ),
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
                                  Text(
                                    '약 정보 보기 >',
                                    style: TextStyle(
                                        color: Color(0xffE4E4E4),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 126,
                                    height: 68,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  SizedBox(
                                    width: Get.width - 250,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        const SizedBox(
                                          height: 17,
                                        ),
                                        (pillsdata[j].iseat == false)
                                            ? GestureDetector(
                                                onTap: () {
                                                  controller.checkeating(
                                                      pillsdata, j);
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    const Text(
                                                      '안먹음',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color(
                                                              0xffBABABA)),
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
                                                  controller.checkeating(
                                                      pillsdata, j);
                                                  log("i=$pillsdata,j=$j");
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      '먹음',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: MainHome
                                                              .maincolor),
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
                        const SizedBox(
                          height: 30,
                        )
                      ],
                    )
                  : SizedBox()),
            );
    }
  }
}
