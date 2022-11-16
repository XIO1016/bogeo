import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:capstone/src/pages/mainhome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/add/addPillWithCameraController.dart';
import 'package:cross_file_image/cross_file_image.dart';

class AddPillwithCamera extends GetView<AddPillwithCameraController> {
  const AddPillwithCamera({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Container(
            height: 80,
            color: Colors.white,
            child: Center(
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(Icons.arrow_back_ios)),
                  Text(
                    '촬영',
                    style: TextStyle(
                        color: MainHome.blackcolor,
                        fontFamily: 'Sans',
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
              width: Get.width,
              height: 600,
              child: CameraPreview(controller.cameraController)),
        ]),
      ),
      bottomSheet: Container(
        color: Colors.white,
        height: Get.height - 690,
        width: Get.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(
                Icons.wallpaper,
                color: MainHome.blackcolor,
                size: 30,
              ),
              onPressed: () async {
                controller.getImageFromGallery();
                // if (controller.imagePath != '') {
                //   showImage();
                // }
              },
            ),
            Center(
              child: Container(
                color: Colors.white,
                child: IconButton(
                  onPressed: (() async {
                    XFile file =
                        await controller.cameraController.takePicture();

                    showImage(file);
                  }),
                  icon: Icon(
                    color: MainHome.blackcolor,
                    Icons.camera,
                    size: 35,
                  ),
                ),
              ),
            ),
            Container(
              width: 35,
            )
          ],
        ),
      ),
    );
  }

  _onPictureSelection() async {
    controller.getImageFromGallery();
  }

  Future<bool> showImage(XFile xfile) async {
    showDialog(
        context: Get.context!,
        builder: (context) => AlertDialog(
              content: Image(image: XFileImage(xfile)),
              actions: [
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text('확인'))
              ],
            ));
    return true;
  }
}
