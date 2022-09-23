// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:capstone/src/components/image_data.dart';
import 'package:capstone/src/controller/bottom_nav_controller.dart';
import 'package:capstone/src/pages/mainhome.dart';
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
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Stack(
            children: [
              Align(
                alignment: Alignment(
                    Alignment.bottomCenter.x, Alignment.bottomCenter.y - 0.06),
                child: FloatingActionButton(
                  backgroundColor: MainHome.maincolor,
                  onPressed: () {},
                  child: Icon(Icons.add),
                ),
              ),
            ],
          ),
          body: IndexedStack(
            index: controller.pageIndex.value,
            children: [
              MainHome(),
              Container(
                child: Center(
                  child: Text('SEARCH'),
                ),
              ),
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
              Container(
                child: Center(
                  child: Text('USER'),
                ),
              ),
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
