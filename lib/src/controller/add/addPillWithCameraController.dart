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

import '../../model/pillsName.dart';
import '../../pages/add/addWithOcr.dart';
import '../login/login_button_controller.dart';

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
  RxString ocrResult = ''.obs;

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

  String match(String string, String regex) {
    String text = '';
    for (final match in RegExp(regex).allMatches(string)) {
      text = '${match[0]}';
    }
    return text;
  }

  Future PostOcrApi(String i) async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    var id = LoginButtonController.to.id;
    RxString token1 = LoginButtonController.to.token1;
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${urlBase}search/ocr'),
    );
    log('시작');
    request.headers.addAll({
      "Accept": "application/json",
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + token1.value,
    });
    var f = await http.MultipartFile.fromPath('file', i);
    request.files.add(f);

    log(request.fields.toString());
    try {
      var response = await request.send();
      log(response.request.toString());

      log(response.statusCode.toString());

      try {
        if (response.statusCode == 200) {
          await response.stream.bytesToString().then((value) async {
            log(value);
            var im = jsonDecode(value);
            Map image = {
              "format": "jpg",
              "name": "medium",
              "data": null,
              "url": im['imageUrl']
            };
            List l = [];
            l.add(image);
            var timestamp = DateTime.now().millisecondsSinceEpoch;
            var requestOcr = await http.post(Uri.parse(ocrurl),
                headers: <String, String>{
                  'Content-Type': 'application/json; charset=UTF-8',
                  'X-OCR-SECRET': ocrkey
                },
                body: jsonEncode(<String, dynamic>{
                  "images": l,
                  "lang": "ko",
                  "requestId": "string",
                  "resultType": "string",
                  "timestamp": timestamp,
                  "version": "V1"
                }));

            var responseOcr = jsonDecode(requestOcr.body);
            List imagesOcr = responseOcr['images'][0]['fields'];
            List resultList = [];
            for (int i = 0; i < imagesOcr.length; i++) {
              Map field = imagesOcr[i];
              String tryOcr = field['inferText'];
              if (tryOcr.length > 4) {
                String t = match(tryOcr, PillsNameToOCR);
                if (t != '') {
                  resultList.add(t);
                }
              }
            }
            Get.back();
            Get.to(() => AddPillwithOcr(), arguments: [resultList]);
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
          Get.back();
          await response.stream.bytesToString().then((value) {
            print(value);

            result(json.decode(value)['result']);
            Get.to(() => SearchPillPage(), arguments: [true, 1]);
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
