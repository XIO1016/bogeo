import 'package:capstone/main.dart';
import 'package:capstone/src/components/image_data.dart';
import 'package:capstone/src/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserPage extends GetView<UserController> {
  UserPage({super.key});
  static Color maincolor = const Color(0xff0057A8);

  List datalist = ['기저 질환', '알러지', '복용 의약품', '기타 건강 정보'];
  List iconlist = [
    IconsPath.disease,
    IconsPath.allergy,
    IconsPath.drugs,
    IconsPath.extra
  ];
  Widget _healthdata(int index) {
    return Container(
      height: 64,
      width: Get.width,
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
                    iconlist[index],
                    width: 80,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${datalist[index]}',
                    style: const TextStyle(
                        fontFamily: 'Sans',
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    '수정',
                    style: TextStyle(
                        fontFamily: 'Sans',
                        fontSize: 15,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                  ),
                  IconButton(
                    onPressed: () {
                      switch (index) {
                        case 0:
                        case 1:
                        case 2:
                        case 3:
                          Get.toNamed('/Eatpill');
                      }
                    },
                    icon: Icon(
                      IconData(0xf579,
                          fontFamily: 'MaterialIcons',
                          matchTextDirection: true),
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        elevation: 0,
      ),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: ListView(
          children: [
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  height: 220,
                  width: Get.width,
                  child: Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                          child: Container(
                            width: Get.width,
                            child: (Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${controller.username} 님',
                                  style: const TextStyle(
                                      fontFamily: 'Sans',
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '만 ${controller.userage}세 ${controller.usergen}',
                                  style: TextStyle(
                                      fontFamily: 'Sans',
                                      fontSize: 18,
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 154, 157, 165)
                                          .withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(20)),
                                  width: Get.width - 40,
                                  height: 100,
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () => Get.toNamed('/Eatpill'),
                                        child: SizedBox(
                                          width: (Get.width - 45) / 2,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '${controller.userPill}',
                                                style: TextStyle(
                                                    fontFamily: 'Sans',
                                                    fontSize: 25,
                                                    color: maincolor,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              const Text(
                                                '내 약',
                                                style: TextStyle(
                                                    fontFamily: 'Sans',
                                                    fontSize: 16),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 1,
                                        height: 70,
                                        color:
                                            Color.fromARGB(255, 156, 154, 154),
                                      ),
                                      GestureDetector(
                                        onTap: () => Get.toNamed('/Eatpill'),
                                        child: SizedBox(
                                          width: (Get.width - 45) / 2,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '${controller.userReview}',
                                                style: TextStyle(
                                                    fontFamily: 'Sans',
                                                    fontSize: 25,
                                                    color: maincolor,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              const Text(
                                                '리뷰 관리',
                                                style: TextStyle(
                                                    fontFamily: 'Sans',
                                                    fontSize: 16),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )),
                          )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: Get.width,
                  height: 400,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '나의 건강 데이터',
                          style: TextStyle(
                              fontFamily: 'Sans',
                              fontSize: 22,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        _healthdata(0),
                        _healthdata(1),
                        _healthdata(2),
                        _healthdata(3),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: Get.width,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '설정 관리',
                          style: TextStyle(
                              fontFamily: 'Sans',
                              fontSize: 22,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            const Icon(
                              Icons.notifications,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            const Text(
                              '알림 설정',
                              style: TextStyle(
                                  fontFamily: 'Sans',
                                  fontSize: 18,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
