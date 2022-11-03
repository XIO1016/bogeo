import 'dart:developer';
import 'dart:ui';

import 'package:capstone/src/pages/mainhome.dart';
import 'package:capstone/src/pages/pilldetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../controller/seachpill_controller.dart';

class SearchPillPage extends GetView<SearchController> {
  List _color = [Color(0xffd2ff99), Color(0xffffd583)];
  List _color2 = [Color(0xfffff599)];
  List _pilltext = ['일반 의약품', '전문 의약품'];
  List _pilltext2 = ['해열.진통.소염제'];

  Widget _appbar() {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Color(0xffEDEDED)),
        child: ListTile(
          trailing: GestureDetector(
            child: Icon(
              Icons.search,
              color: MainHome.maincolor,
              size: 30,
            ),
            onTap: () {
              controller.getPillsFromData();
            },
          ),
          title: TextFormField(
            cursorHeight: 23,
            cursorColor: MainHome.maincolor,
            controller: controller.searchTextEditingController,
            decoration: const InputDecoration(
              hintText: '무슨 약을 찾으세요?',
              hintStyle: TextStyle(color: Color(0xffbababa)),
              enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Colors.transparent, width: 1.5),
              ),
              focusedBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Colors.transparent, width: 2),
              ),
            ),
          ),
        ));
  }

  Widget _pills(int i) {
    return GestureDetector(
      onTap: (() {
        Get.to(() => DetailPillPage(), arguments: controller.pillsitems[i]);
        //log('${controller.pillsitems[i].item_name}');
      }),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          border: BorderDirectional(
            top: BorderSide(
              color: Color(0xffDEDEDE),
              width: 1,
            ),
          ),
        ),
        child: Row(children: [
          SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  color: Colors.grey,
                  width: 134,
                  height: 70,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 25,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 173,
                child: RichText(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  text: TextSpan(
                    text: controller.pillsitems[i].item_name,
                    style: const TextStyle(
                      color: Color(0xff505050),
                      fontSize: 17,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 19,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  general(i),
                  SizedBox(
                    height: 7,
                  ),
                  general2(i)
                ],
              )
            ],
          ),
        ]),
      ),
    );
  }

  Widget general(i) {
    return Container(
      padding: EdgeInsets.fromLTRB(7, 5, 7, 5),
      decoration: BoxDecoration(
          color: (controller.pillsitems[i].etc_otc_code == '일반의약품')
              ? _color[0]
              : _color[1],
          borderRadius: BorderRadius.circular(10)),
      child: Text(
        controller.pillsitems[i].etc_otc_code,
        style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: Color(0xff6c6c6c)),
      ),
    );
  }

  Widget general2(i) {
    return Container(
      padding: EdgeInsets.fromLTRB(7, 5, 7, 5),
      decoration: BoxDecoration(
          color: _color2[0], borderRadius: BorderRadius.circular(10)),
      child: Text(
        _pilltext2[0],
        style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: Color(0xff6c6c6c)),
      ),
    );
  }

  Widget _body() {
    // return SingleChildScrollView(
    //     physics: ClampingScrollPhysics(),
    //     scrollDirection: Axis.vertical,
    // child:
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return _pills(index);
        },
        itemCount: controller.resultNum.value,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx((() => Scaffold(
          body: SafeArea(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18, 18, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _appbar(),
                SizedBox(
                  height: 7,
                ),
                Text(
                  '결과 ${controller.resultNum}개',
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(
                  height: 15,
                ),
                Expanded(child: _body())
              ],
            ),
          )),
        )));
  }
}
