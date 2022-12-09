import 'dart:developer';
import 'dart:io';

import 'package:capstone/src/components/Sbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/add/addPillWithCameraController.dart';

class AddPillwithCamera extends GetView<AddPillwithCameraController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GestureDetector(
          onTap: () {
            controller.postPillImage();
          },
          child: Container(
            width: Get.width,
            height: 60,
            decoration: BoxDecoration(
                color: Color(0xff628EFF),
                borderRadius: BorderRadius.circular(15)),
            child: const Center(
              child: Text(
                '약 찾기',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
      backgroundColor: Colors.white,
      body: Obx(
        (() => Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '찾고 싶은 약 사진을 찍어주세요',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Sbox(0, 70),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Text(
                              '약 앞면',
                              style: TextStyle(fontSize: 16),
                            ),
                            Sbox(0, 10),
                            GestureDetector(
                              onTap: () {
                                int val = 0;
                                log(val.toString());

                                controller.getImageFromCamera(1);
                                // Get.to(() => CamerPage(), arguments: val);
                              },
                              child: Container(
                                width: 135,
                                height: 135,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black)),
                                child: (controller.firstimage.value == '')
                                    ? const Center(
                                        child: Icon(Icons.photo_camera),
                                      )
                                    : Image.file(
                                        File(controller.firstimage.value)),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text(
                              '약 뒷면',
                              style: TextStyle(fontSize: 16),
                            ),
                            Sbox(0, 10),
                            GestureDetector(
                                onTap: () {
                                  int val = 1;
                                  log(val.toString());
                                  controller.getImageFromCamera(2);
                                  // Get.to(() => CamerPage(), arguments: val);
                                },
                                child: Container(
                                  width: 135,
                                  height: 135,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black)),
                                  child: (controller.secondimage.value == '')
                                      ? const Center(
                                          child: Icon(Icons.photo_camera),
                                        )
                                      : Image.file(
                                          File(controller.secondimage.value),
                                        ),
                                )),
                          ],
                        ),
                      ],
                    )
                  ]),
            )),
      ),
    );
  }
}
//
// class CamerPage extends GetView<AddPillwithCameraController> {
//   final index = Get.arguments;
//
//   @override
//   Widget build(BuildContext context) {
//     log(index.toString());
//     return Scaffold(
//       body: SafeArea(
//         child: Column(children: [
//           Container(
//             height: 80,
//             color: Colors.white,
//             child: Center(
//               child: Row(
//                 children: [
//                   const SizedBox(
//                     width: 10,
//                   ),
//                   IconButton(
//                       onPressed: () => Get.back(),
//                       icon: Icon(Icons.arrow_back_ios)),
//                   Text(
//                     '촬영',
//                     style: TextStyle(
//                         color: MainHome.blackcolor,
//                         fontFamily: 'Sans',
//                         fontSize: 22,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SizedBox(
//               width: Get.width,
//               height: 600,
//               child: CameraPreview(controller.cameraController)),
//         ]),
//       ),
//       bottomSheet: Container(
//         color: Colors.white,
//         height: Get.height - 690,
//         width: Get.width,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             IconButton(
//               icon: Icon(
//                 Icons.wallpaper,
//                 color: MainHome.blackcolor,
//                 size: 30,
//               ),
//               onPressed: () async {
//                 controller.getImageFromGallery();
//                 // if (controller.imagePath != '') {
//                 //   showImage();
//                 // }
//               },
//             ),
//             Center(
//               child: Container(
//                 color: Colors.white,
//                 child: IconButton(
//                   onPressed: (() async {
//                     XFile file =
//                         await controller.cameraController.takePicture();
//
//                     showImage(file);
//
//                     if (index == 0) {
//                       controller.firstimage(file.path);
//                       log(file.path);
//                     } else {
//                       controller.secondimage(file.path);
//                     }
//                   }),
//                   icon: Icon(
//                     color: MainHome.blackcolor,
//                     Icons.camera,
//                     size: 35,
//                   ),
//                 ),
//               ),
//             ),
//             Container(
//               width: 35,
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   _onPictureSelection() async {
//     controller.getImageFromGallery();
//   }
//
//   Future<bool> showImage(XFile xfile) async {
//     showDialog(
//         context: Get.context!,
//         builder: (context) => AlertDialog(
//               content: Image(image: XFileImage(xfile)),
//               actions: [
//                 TextButton(
//                     onPressed: () {
//                       Get.back();
//                       Get.back();
//                     },
//                     child: Text('확인'))
//               ],
//             ));
//     return true;
//   }
// }
