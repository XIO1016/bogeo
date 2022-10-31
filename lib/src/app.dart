// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:capstone/src/components/image_data.dart';
import 'package:capstone/src/controller/addpill_controller.dart';
import 'package:capstone/src/controller/bottom_nav_controller.dart';
import 'package:capstone/src/pages/mainhome.dart';
import 'package:capstone/src/pages/searchpill.dart';
import 'package:capstone/src/pages/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends GetView<BottomNavController> {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: sort_child_properties_last
      child: Obx(
        () => Scaffold(
          resizeToAvoidBottomInset: false,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Stack(
            children: [
              Align(
                alignment: Alignment(
                    Alignment.bottomCenter.x, Alignment.bottomCenter.y - 0.06),
                child: FloatingActionButton(
                  backgroundColor: MainHome.maincolor,
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(25.0),
                          ),
                        ),
                        backgroundColor: Colors.white,
                        builder: (context) {
                          return SizedBox(
                            height: 300,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.fromLTRB(20, 25, 20, 20),
                                  child: Text(
                                    '약을 추가할 방법을 선택해주세요',
                                    style: TextStyle(
                                        fontFamily: 'Sans',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Divider(
                                  thickness: 0.5,
                                  height: 0.5,
                                  color: Color.fromARGB(255, 130, 130, 130),
                                ),
                                InkWell(
                                  onTap: () => Get.toNamed('/AddPill'),
                                  child: Container(
                                    width: Get.width,
                                    height: 55,
                                    child: Center(
                                      child: Text(
                                        '약 이름으로 추가',
                                        style: TextStyle(
                                            fontFamily: 'Sans', fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                                Divider(
                                  thickness: 0.5,
                                  height: 0.5,
                                  color: Colors.grey,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.find<AddPillController>();
                                    Get.toNamed('/AddPill');
                                  },
                                  child: Container(
                                    width: Get.width,
                                    height: 50,
                                    child: Center(
                                      child: Text(
                                        '처방전/약봉지로 추가',
                                        style: TextStyle(
                                            fontFamily: 'Sans', fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                                Divider(
                                  thickness: 0.5,
                                  height: 0.5,
                                  color: Colors.grey,
                                ),
                                InkWell(
                                  onTap: () => Get.toNamed('/AddPill'),
                                  child: Container(
                                    width: Get.width,
                                    height: 50,
                                    child: Center(
                                      child: Text(
                                        '약 모양으로 추가',
                                        style: TextStyle(
                                            fontFamily: 'Sans', fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => Get.back(),
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: Get.width - 40,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(8)),
                                    height: 50,
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      '취소',
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 122, 122, 122),
                                          fontFamily: 'Sans',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        });
                  },
                  child: Icon(Icons.add),
                ),
              ),
            ],
          ),
          body: IndexedStack(
            index: controller.pageIndex.value,
            children: [
              MainHome(),
              SearchPillPage(),
              Container(
                child: Center(
                  child: Text('PLUS'),
                ),
              ),
              Container(
                child: const Center(
                  child: Text('EATPILL'),
                ),
              ),
              UserPage()
            ],
          ),
          bottomNavigationBar: Container(
            height: 64,
            color: Colors.white,
            child: BottomNavigationBar(
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: true,
              currentIndex: controller.pageIndex.value,
              elevation: 5,
              onTap: controller.changeBottomNav,
              selectedItemColor: Colors.black,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    size: 25,
                  ),
                  activeIcon: Icon(
                    Icons.home,
                    size: 28,
                  ),
                  label: '홈',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.search,
                    size: 25,
                  ),
                  activeIcon: Icon(
                    Icons.search,
                    size: 28,
                  ),
                  label: '약 검색',
                ),
                BottomNavigationBarItem(
                  icon: Container(),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.monitor_heart,
                    size: 25,
                  ),
                  activeIcon: Icon(
                    Icons.monitor_heart,
                    size: 28,
                  ),
                  label: '복용관리',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    size: 25,
                  ),
                  activeIcon: Icon(
                    Icons.person,
                    size: 28,
                  ),
                  label: '프로필',
                ),
              ],
            ),
          ),
        ),
      ),
      onWillPop: controller.willPopAction,
    );
  }
}
