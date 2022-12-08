import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:capstone/src/http/url.dart';
import 'package:capstone/src/pages/searchpill.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class AddPillwithCameraController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static AddPillwithCameraController get to =>
      Get.find<AddPillwithCameraController>();
  late AnimationController _animationController;
  late CameraController cameraController;
  RxBool cameraInitialized = false.obs;
  var pickedFile;
  late File image;
  RxString imagePath = ''.obs;
  final _picker = ImagePicker();
  RxString parsedtext = ''.obs;
  RxString firstimage = ''.obs;
  RxString secondimage = ''.obs;
  RxString result = ''.obs;

  // match('포타리온정 아르시딘에프정 333 ', PillsNameToOCR);
  // void match(String string, String regex) {
  //   var text = '$string: $regex => ';
  //   for (final match in RegExp(regex).allMatches(string)) {
  //     text = '$text(${match[0]})';
  //   }
  //   print(text);
  // }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // readyToCamera();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    if (cameraController != null) {
      cameraController.dispose();
    }
    // _animationController.dispose();
    super.onClose();
  }

  Future getImageFromGallery() async {
    // for gallery

    pickedFile =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      imagePath(pickedFile.path);
      PostOcrApi(imagePath.value);

      log(imagePath.value);
      update();
    } else {
      print('No image selected.');
    }
  }

  Future getImageFromCamera(int i) async {
    // for gallery

    pickedFile =
        await ImagePicker.platform.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      if (i == 1) {
        var file = File(pickedFile.path);
        firstimage(file.path);
      } else {
        var file = File(pickedFile.path);
        secondimage(file.path);
      }
      // log(imagePath.value);
      update();
    } else {
      print('No image selected.');
    }
  }

  // void readyToCamera() async {
  //   // 사용할 수 있는 카메라 목록을 OS로부터 받아 옵니다.
  //   final cameras = await availableCameras();
  //   if (0 == cameras.length) {
  //     print("not found any cameras");
  //     return;
  //   }
  //
  //   CameraDescription frontCamera = cameras.first;
  //
  //   cameraController = CameraController(
  //       frontCamera, ResolutionPreset.max // 가장 높은 해상도의 기능을 쓸 수 있도록 합니다.
  //       );
  //   cameraController.initialize().then((value) {
  //     // 카메라 준비가 끝나면 카메라 미리보기를 보여주기 위해 앱 화면을 다시 그립니다.
  //     cameraInitialized(true);
  //   });
  // }

  Future PostOcrApi(String i) async {
    // var bytes = i.codeUnits;
    // String img64 = base64Encode(bytes);

    var request = http.MultipartRequest("POST", Uri.parse(ocrurl));

    request.headers
        .addAll({'Content-Type': 'application/json', 'X-OCR-SECRET': ocrkey});
    // request.files.add(await http.MultipartFile.fromPath('image', i));
    // log(request.files[0].filename.toString());
    request.fields['lang'] = 'ko';
    request.fields['requestId'] = 'string';
    request.fields['resultType'] = 'string';
    request.fields['timestamp'] =
        DateTime.now().millisecondsSinceEpoch.toString();
    request.fields['version'] = 'V1';
    request.fields['image'] = [
      utf8.encode(jsonEncode(
          {'format': 'png', 'name': 'medium', 'data': null, 'url': i}))
    ].toString();
    log(request.fields.toString());
    try {
      var response = await request.send();
      log(response.request.toString());

      log(response.statusCode.toString());

      try {
        if (response.statusCode == 200) {
          await response.stream.bytesToString().then((value) {
            print(value);

            result(json.decode(value)['result']);
            Get.to(() => SearchPillPage(), arguments: true);
          });
        } else {
          await response.stream.bytesToString().then((value) {
            print(value);
          });
        }
      } catch (e) {
        log(e.toString());
      }
    } catch (e) {
      log(e.toString());
    }
  }

  postPillImage() async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    List<File> imageFileList = [
      File(firstimage.value),
      File(secondimage.value)
    ];

    var request = http.MultipartRequest("POST", Uri.parse(aiurl));

    for (var imageFile in imageFileList) {
      request.files.add(
          await http.MultipartFile.fromPath('imageFileList', imageFile.path));
      // log(request.files[0].filename.toString());
    }
    try {
      var response = await request.send();
      log(response.headers.toString());

      try {
        if (response.statusCode == 200) {
          await response.stream.bytesToString().then((value) {
            print(value);

            result(json.decode(value)['result']);
            Get.to(() => SearchPillPage(), arguments: true);
          });
        } else {
          await response.stream.bytesToString().then((value) {
            print(value);
          });
        }
      } catch (e) {
        log(e.toString());
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
