// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:capstone/src/components/image_data.dart';
import 'package:capstone/src/controller/add/addpilltodatacontroller.dart';
import 'package:capstone/src/controller/bottom_nav_controller.dart';
import 'package:capstone/src/pages/add/addpill.dart';
import 'package:capstone/src/pages/eatpill.dart';
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
                    Get.to(addpillPage());
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
              addpillPage(),
              EatPillPage(),
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
