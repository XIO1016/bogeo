import 'package:camera/camera.dart';
import 'package:capstone/src/pages/mainhome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/add/addpill_controller.dart';

class AddPillwithCamera extends GetView<AddPillwithCameraController> {
  const AddPillwithCamera({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: MainHome.maincolor,
          centerTitle: true,
          title: const Text(
            '처방전/약봉투 촬영',
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Sans',
                fontSize: 18,
                fontWeight: FontWeight.w500),
          )),
      body: Column(children: [
        SizedBox(
            width: Get.width,
            height: 600,
            child: CameraPreview(controller.cameraController)),
      ]),
      bottomSheet: Container(
        color: MainHome.maincolor,
        height: Get.height - 690,
        width: Get.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(
                Icons.wallpaper,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () async {
                controller.getImageFromGallery();
                if (controller.imagePath != '') {
                  showImage();
                }
              },
            ),
            Center(
              child: Container(
                color: MainHome.maincolor,
                child: IconButton(
                  onPressed: (() {}),
                  icon: Icon(
                    color: Colors.white,
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

  Future<bool> showImage() async {
    showDialog(
        context: Get.context!,
        builder: (context) => AlertDialog(
              content: Image(
                image: FileImage(controller.image),
              ),
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
