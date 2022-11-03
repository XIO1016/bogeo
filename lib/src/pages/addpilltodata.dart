import 'package:capstone/src/app.dart';
import 'package:capstone/src/controller/addpilltodatacontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class AddPillToData extends GetView<AddPillToDataController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Get.back(),
            ),,),
    )
  }

}