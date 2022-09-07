import 'package:capstone/src/components/login_component.dart';
import 'package:capstone/src/controller/login_button_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends GetView<LoginButtonController> {
  var maincolor = Colors.blue;
  Login({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: sort_child_properties_last
      onWillPop: controller.willPopAction,
      child: Obx(
        () => Scaffold(
          bottomSheet: SafeArea(
            child: Container(
              width: double.infinity,
              color: Colors.white,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    primary: maincolor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0))),
                onPressed: (() {
                  if (controller.pageIndex.value == 1) {
                    print(controller.idController.text);
                    print(controller.passwordController.text);
                    controller.apiLogin();
                  } else {
                    controller.changeloginpage(controller.pageIndex.value + 1);
                  }
                }),
                child: const Text(
                  '확인',
                  style: TextStyle(
                      fontFamily: "Sans",
                      fontWeight: FontWeight.w700,
                      fontSize: 15),
                ),
              ),
            ),
          ),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            leading: BackButton(color: Colors.black),
            elevation: 0,
          ),
          body: IndexedStack(
            index: controller.pageIndex.value,
            children: [
              Column(
                children: [
                  LoginComponent(0),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: TextFormField(
                      controller: controller.idController,
                      autofocus: true,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        labelText: "아이디",
                        labelStyle: TextStyle(fontFamily: "Sans"),
                      ),
                      validator: (value) =>
                          value!.trim().isEmpty ? 'ID required' : null,
                    ),
                  ),
                  const goOther()
                ],
              ),
              Column(
                children: [
                  LoginComponent(1),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: TextFormField(
                      controller: controller.passwordController,
                      autofocus: true,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        labelText: "비밀번호",
                        labelStyle: TextStyle(fontFamily: "Sans"),
                      ),
                      validator: (value) =>
                          value!.trim().isEmpty ? 'ps required' : null,
                    ),
                  ),
                  const goOther()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
