import 'package:capstone/main.dart';
import 'package:capstone/src/app.dart';
import 'package:capstone/src/components/image_data.dart';
import 'package:capstone/src/controller/mainhome_controller.dart';
import 'package:capstone/src/pages/eatpill.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainHome extends GetView<MainHomeController> {
  const MainHome({super.key});
  static List<String> time = ['아침', '점심', '저녁'];
  static Color maincolor = const Color(0xff0057A8);

  Widget _noweatpill() {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        child: Row(
          children: List.generate(
            100,
            (index) => GestureDetector(
              onTap: () => Get.toNamed('/Eatpill'),
              child: Container(
                width: 116,
                height: 150,
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 1.0))
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    color: Colors.white),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '비타민',
                        style: TextStyle(
                            fontFamily: 'Sans',
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '2알',
                        style: TextStyle(
                            fontFamily: 'Sans',
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                      GestureDetector(
                        onTap: () => controller.changeate(),
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (controller.eating == true)
                                ? Colors.grey
                                : maincolor,
                          ),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ]),
              ),
            ),
          ),
        ));
  }

  Widget _todayeatpill() {
    return Container(
      height: 75,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 1.0))
          ],
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ImageData(
                  controller.image.value,
                  width: 80,
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  '타이레놀 1정',
                  style: TextStyle(
                      fontFamily: 'Sans',
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            IconButton(
                onPressed: () => Get.toNamed('/Eatpill'),
                icon: Icon(IconData(0xf579,
                    fontFamily: 'MaterialIcons', matchTextDirection: true))),
          ],
        ),
      ),
    );
  }

  Widget _pillscore() {
    switch (controller.period.value) {
      case 0:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '100점',
              style: TextStyle(
                  color: Color(0xff57BD55),
                  fontFamily: 'Sans',
                  fontWeight: FontWeight.w700,
                  fontSize: 40),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '복용을 잘 지키고 있어요!',
              style: TextStyle(
                  fontFamily: 'Sans',
                  fontSize: 18,
                  color: Color(0xff1D4B1C),
                  fontWeight: FontWeight.w500),
            )
          ],
        );
      case 1:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '50점',
              style: TextStyle(
                  color: Color(0xff57BD55),
                  fontFamily: 'Sans',
                  fontWeight: FontWeight.w700,
                  fontSize: 40),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '복용을 잘 지키고 있어요!',
              style: TextStyle(
                  fontFamily: 'Sans',
                  fontSize: 18,
                  color: Color(0xff1D4B1C),
                  fontWeight: FontWeight.w500),
            )
          ],
        );
      case 2:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '30점',
              style: TextStyle(
                  color: Color(0xff57BD55),
                  fontFamily: 'Sans',
                  fontWeight: FontWeight.w700,
                  fontSize: 40),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '복용을 잘 지키고 있어요!',
              style: TextStyle(
                  fontFamily: 'Sans',
                  fontSize: 18,
                  color: Color(0xff1D4B1C),
                  fontWeight: FontWeight.w500),
            )
          ],
        );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(42),
            child: AppBar(
              centerTitle: false,
              automaticallyImplyLeading: false,
              elevation: 0,
              title: Text(
                'Bogeo',
                style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'Space',
                    fontWeight: FontWeight.w600,
                    color: maincolor),
              ),
            )),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            child: ListView(children: [
              Row(
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '${time[0]}',
                    style: const TextStyle(
                        decoration: TextDecoration.underline,
                        fontFamily: 'Sans',
                        fontSize: 24,
                        fontWeight: FontWeight.w700),
                  ),
                  const Text(
                    '에 복용해야할 약이에요!',
                    style: TextStyle(
                        fontFamily: 'Sans',
                        fontSize: 24,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              _noweatpill(),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '오늘 복용할 약',
                    style: TextStyle(
                        fontFamily: 'Sans',
                        fontSize: 25,
                        fontWeight: FontWeight.w700),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Get.toNamed('/Eatpill'),
                        child: Text(
                          '${controller.strToday} (${controller.strday}) >',
                          style: TextStyle(
                              fontFamily: 'Sans',
                              fontSize: 16,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Column(
                children: [
                  _todayeatpill(),
                  _todayeatpill(),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Row(
                    children: [
                      Text(
                        '내 복용 점수는?',
                        style: TextStyle(
                            fontFamily: 'Sans',
                            fontSize: 25,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        width: Get.width - 240,
                      ),
                      DropdownButton(
                        elevation: 0,
                        underline: SizedBox(),
                        value: controller.period.value,
                        onChanged: (int? value) {
                          controller.changeDropMenu(value);
                        },
                        style: TextStyle(
                            fontFamily: 'Sans',
                            fontSize: 15,
                            color: Colors.black),
                        items: [
                          DropdownMenuItem(
                            child: Text('일'),
                            value: 0,
                          ),
                          DropdownMenuItem(
                            child: Text('주'),
                            value: 1,
                          ),
                          DropdownMenuItem(
                            child: Text('월'),
                            value: 2,
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                height: 150,
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Color(0xffF5F5F5)),
                child: _pillscore(),
              ),
              const SizedBox(
                height: 16,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
