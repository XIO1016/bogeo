import 'dart:developer';

import 'package:capstone/src/app.dart';
import 'package:capstone/src/components/Sbox.dart';
import 'package:capstone/src/controller/addpilltodatacontroller.dart';
import 'package:capstone/src/pages/mainhome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../components/text_component.dart';

class AddPillToData extends GetView<AddPillToDataController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        bottomSheet: Padding(
          padding: const EdgeInsets.all(20.0),
          child: NextWidget(),
        ),
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('약 추가하기'),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.keyboard_arrow_left_rounded, color: Colors.black),
            onPressed: () => Get.back(),
          ),
        ),
        body: ListView(children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 117,
                      height: 65,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('비타민 C 1000',
                            style: TextStyle(
                                color: MainHome.blackcolor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(
                          height: 3,
                        ),
                        Text1('고려은단', Color(0xffBababa))
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                    child: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '복약 주기를 입력하세요',
                        style: TextStyle(
                            color: MainHome.blackcolor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text1('며칠 간격으로 약을 복용하시나요?', Color(0xffBABABA)),
                      Sbox(0, 30),
                      GestureDetector(
                        onTap: () {
                          controller.checkPeriod(0);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '정해진 요일마다 복용해요',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: changeColor(0),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            (controller.eatPeriod == 0)
                                ? SvgPicture.asset(
                                    'assets/icons/eat.svg',
                                  )
                                : SvgPicture.asset(
                                    'assets/icons/noeat.svg',
                                  )
                          ],
                        ),
                      ),
                      Sbox(0, 20),
                      (controller.eatPeriod == 0)
                          ? Padding(
                              padding: EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: List.generate(
                                    7,
                                    (index) => GestureDetector(
                                          onTap: (() => controller
                                              .weekCheckPeriod(index)),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: (controller
                                                        .weekCheck[index].value)
                                                    ? Color(0xff628EFF)
                                                    : Color(0xffE4E4E4),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            height: 40,
                                            width: 40,
                                            child: Center(
                                                child: Text(
                                              controller.week[index],
                                              style: TextStyle(
                                                  color: (controller
                                                          .weekCheck[index]
                                                          .value)
                                                      ? Colors.white
                                                      : Color(0xff8D8D8D),
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                          ),
                                        )),
                              ),
                            )
                          : Container(),
                      Sbox(0, 40),
                      GestureDetector(
                        onTap: () {
                          controller.checkPeriod(1);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '정해진 주기마다 복용해요',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: changeColor(1),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            (controller.eatPeriod == 1)
                                ? SvgPicture.asset(
                                    'assets/icons/eat.svg',
                                  )
                                : SvgPicture.asset(
                                    'assets/icons/noeat.svg',
                                  )
                          ],
                        ),
                      ),
                      Sbox(0, 30),
                      (controller.eatPeriod == 1)
                          ? Row(
                              children: [
                                SizedBox(
                                  height: 50,
                                  width: 200,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    controller: controller.interval,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 1.8,
                                              color: Color(0xff628EFF)),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      hintText: '간격을 입력하세요',
                                      hintStyle: const TextStyle(
                                          color: Color(0xffE4E4E4),
                                          fontSize: 12),
                                      border: OutlineInputBorder(
                                          borderSide:
                                              const BorderSide(width: 1.5),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                    ),
                                  ),
                                ),
                                Sbox(20, 0),
                                Text(
                                  '일 주기',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: MainHome.blackcolor),
                                )
                              ],
                            )
                          : Container(),
                      Sbox(0, 40),
                      GestureDetector(
                        onTap: () {
                          controller.checkPeriod(2);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '매일 복용해요',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: changeColor(2),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            (controller.eatPeriod == 2)
                                ? SvgPicture.asset(
                                    'assets/icons/eat.svg',
                                  )
                                : SvgPicture.asset(
                                    'assets/icons/noeat.svg',
                                  )
                          ],
                        ),
                      ),
                      Sbox(0, 80),
                      // NextWidget(),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '복약 종료일을 입력하세요',
                        style: TextStyle(
                            color: MainHome.blackcolor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text1('언제까지 약을 복용하시나요?', Color(0xffBABABA)),
                      Sbox(0, 30),
                      GestureDetector(
                        onTap: () {
                          controller.checkEnding(0);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '종료일이 없어요.',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: changeColor1(0),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            (controller.eatEnding == 0)
                                ? SvgPicture.asset(
                                    'assets/icons/eat.svg',
                                  )
                                : SvgPicture.asset(
                                    'assets/icons/noeat.svg',
                                  )
                          ],
                        ),
                      ),
                      Sbox(0, 40),
                      GestureDetector(
                        onTap: () {
                          controller.checkEnding(1);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '특정 날짜까지 복용해요',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: changeColor1(1),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            (controller.eatEnding == 1)
                                ? SvgPicture.asset(
                                    'assets/icons/eat.svg',
                                  )
                                : SvgPicture.asset(
                                    'assets/icons/noeat.svg',
                                  )
                          ],
                        ),
                      ),
                      Sbox(0, 20),
                      (controller.eatEnding == 1)
                          ? TableCalendar(
                              headerStyle: const HeaderStyle(
                                  formatButtonVisible: false,
                                  titleCentered: true,
                                  leftChevronVisible: true,
                                  rightChevronVisible: true),
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
                                return isSameDay(
                                    controller.selectedDate.value, day);
                              },
                              firstDay: DateTime(
                                  DateTime.now().year, DateTime.now().month, 1),
                              focusedDay: DateTime.now(),
                              lastDay: DateTime(2023, 12, 31),
                              onDaySelected: (selectedDay, focusedDay) {
                                controller.changeselectedDate(selectedDay);

                                log(controller.selectedDate.toString());
                              },
                            )
                          : Container(),
                      Sbox(0, 80),
                      // NextWidget()
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '복용량을 입력하세요',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: MainHome.blackcolor),
                      ),
                      Sbox(0, 5),
                      Text1('한 번 복용할 때 얼마나 복용하나요?', Color(0xffBABABA)),
                      Sbox(0, 40),
                      Row(
                        children: [
                          SizedBox(
                            height: 50,
                            width: 200,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: controller.pillNum,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1.8, color: Color(0xff628EFF)),
                                    borderRadius: BorderRadius.circular(20)),
                                hintText: '개수를 입력하세요',
                                hintStyle: const TextStyle(
                                    color: Color(0xffE4E4E4), fontSize: 12),
                                border: OutlineInputBorder(
                                    borderSide: const BorderSide(width: 1.5),
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                            ),
                          ),
                          Sbox(20, 0),
                          Text(
                            '알',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: MainHome.blackcolor),
                          )
                        ],
                      ),
                      Sbox(0, 40),
                    ],
                  )
                ][controller.pageIndex.value])
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Color changeColor(int i) {
    if (controller.eatPeriod == i) {
      return MainHome.maincolor;
    } else {
      return Color(0xffbababa);
    }
  }

  Color changeColor1(int i) {
    if (controller.eatEnding == i) {
      return MainHome.maincolor;
    } else {
      return Color(0xffbababa);
    }
  }

  Widget NextWidget() {
    return GestureDetector(
      onTap: () {
        controller.changePage();
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
}
