import 'package:capstone/src/components/Sbox.dart';
import 'package:capstone/src/pages/add/addpillwithcamer.dart';
import 'package:capstone/src/pages/mainhome.dart';
import 'package:capstone/src/pages/searchpill.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class addpillPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          title: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Sbox(0, 20),
                Text(
                  '약 추가',
                  style: TextStyle(
                      color: MainHome.blackcolor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            GestureDetector(
                onTap: (() => Get.to(AddPillwithCamera())),
                child: _list('처방전으로', 'tabler_clipboard-plus')),
            Sbox(0, 20),
            GestureDetector(
                onTap: () {}, child: _list('약 사진으로', 'tabler_pill')),
            Sbox(0, 20),
            GestureDetector(
                onTap: () => Get.to(SearchPillPage()),
                child: _list('검색해서', 'tabler_search')),
            Sbox(0, 20),
            _list('직접', 'pepicons_pen')
          ],
        ),
      ),
    );
  }

  Widget _list(String a, String b) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 1,
          color: Color(0xffE4E4E4),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(30, 40, 30, 40),
      child: Row(
        children: [
          SvgPicture.asset('assets/icons/${b}.svg'),
          Sbox(16, 0),
          Text(
            '$a 추가하기',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: MainHome.blackcolor),
          )
        ],
      ),
    );
  }
}
