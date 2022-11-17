import 'package:capstone/main.dart';
import 'package:capstone/src/components/Sbox.dart';
import 'package:capstone/src/components/image_data.dart';
import 'package:capstone/src/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class UserPage extends GetView<UserController> {
  UserPage({super.key});
  static Color maincolor = const Color(0xff0057A8);
  static Color blackcolor = const Color(0xff505050);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
        ),
        body: ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(overscroll: false),
          child: ListView(
            children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${controller.id} 님',
                        style: const TextStyle(
                            fontFamily: 'Sans',
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${controller.userage}세 ${controller.usergen}',
                        style: TextStyle(
                            fontFamily: 'Sans',
                            fontSize: 18,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Text(
                        '내 약 전체 보기',
                        style: TextStyle(
                            color: blackcolor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: AllPill(),
                      )
                    ],
                  )),
            ],
          ),
        ));
  }

  List<Widget> AllPill() {
    return List.generate(
      controller.pillNum.value,
      ((i) => GestureDetector(
            onTap: () {
              controller.getDetail(controller.myallpills[i]);
            },
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(30, 20, 30, 30),
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 1,
                      color: Color(0xffE4E4E4),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.myallpills[i].createdDate,
                            style: const TextStyle(
                                color: Color(0xffBABABA),
                                fontSize: 15,
                                fontWeight: FontWeight.normal),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          SizedBox(
                            width: 280,
                            child: RichText(
                                text: TextSpan(
                              text: controller.myallpills[i].medicineName,
                              style: TextStyle(
                                  color: blackcolor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            )),
                          )
                        ],
                      ),
                      SvgPicture.asset('assets/icons/arrow.svg')
                    ],
                  ),
                ),
                Sbox(0, 20)
              ],
            ),
          )),
    );
  }
}
