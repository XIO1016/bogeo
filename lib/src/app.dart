// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:capstone/src/components/image_data.dart';
import 'package:capstone/src/controller/bottom_nav_controller.dart';
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
          appBar: AppBar(),
          body: IndexedStack(
            index: controller.pageIndex.value,
            children: [
              Container(
                child: Center(
                  child: Text('HOME'),
                ),
              ),
              Container(
                child: Center(
                  child: Text('EATPILL'),
                ),
              ),
              Container(
                child: Center(
                  child: Text('PLUS'),
                ),
              ),
              Container(
                child: const Center(
                  child: Text('PILL'),
                ),
              ),
              Container(
                child: Center(
                  child: Text('USER'),
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: false,
            currentIndex: controller.pageIndex.value,
            elevation: 0,
            onTap: controller.changeBottomNav,
            items: [
              BottomNavigationBarItem(
                icon: ImageData(IconsPath.homeOff),
                activeIcon: ImageData(IconsPath.homeOn),
                label: '홈',
              ),
              BottomNavigationBarItem(
                icon: ImageData(IconsPath.eatpillOff),
                activeIcon: ImageData(IconsPath.eatpillOn),
                label: '복용관리',
              ),
              BottomNavigationBarItem(
                icon: ImageData(width: 100, IconsPath.plus),
                label: '약추가',
              ),
              BottomNavigationBarItem(
                icon: ImageData(IconsPath.pillOff),
                activeIcon: ImageData(IconsPath.pillOn),
                label: '영양제 추천',
              ),
              BottomNavigationBarItem(
                icon: ImageData(IconsPath.userOff),
                activeIcon: ImageData(IconsPath.userOn),
                label: '프로필',
              ),
            ],
          ),
        ),
      ),
      onWillPop: controller.willPopAction,
    );
  }
}
