import 'package:capstone/src/pages/mainhome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class splashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        color: MainHome.maincolor,
        child: const Center(
            child: Text(
          'Bogeo',
          style: TextStyle(
              fontFamily: 'Space',
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        )),
      ),
    ));
  }
}
