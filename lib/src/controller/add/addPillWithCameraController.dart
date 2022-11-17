import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:capstone/src/pages/searchpill.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:camera/camera.dart';
import 'package:capstone/src/http/url.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

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
  // late double percentage;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    readyToCamera();
    // _animationController = AnimationController(
    //   vsync: this,
    //   duration: Duration(seconds: 10),
    // );
    // _animationController.addListener(
    //   () => refresh(),
    // );
    // _animationController.repeat();
    // percentage = _animationController.value * 100;
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
      imagePath = pickedFile.path;
      PostOcrApi(imagePath.value);

      log(imagePath.value);
      update();
    } else {
      print('No image selected.');
    }
  }

  void readyToCamera() async {
    // 사용할 수 있는 카메라 목록을 OS로부터 받아 옵니다.
    final cameras = await availableCameras();
    if (0 == cameras.length) {
      print("not found any cameras");
      return;
    }

    CameraDescription frontCamera = cameras.first;

    cameraController = CameraController(
        frontCamera, ResolutionPreset.max // 가장 높은 해상도의 기능을 쓸 수 있도록 합니다.
        );
    cameraController.initialize().then((value) {
      // 카메라 준비가 끝나면 카메라 미리보기를 보여주기 위해 앱 화면을 다시 그립니다.
      cameraInitialized(true);
    });
  }

  Future PostOcrApi(String i) async {
    var bytes = i.codeUnits;
    String img64 = base64Encode(bytes);
    var payload = {
      "base64Image": "data:image/jpg;base64,${img64.toString()}",
      "language": "kor"
    };
    var header = {"apikey": ocrkey};

    var post =
        await http.post(Uri.parse(ocrurl), body: payload, headers: header);
    var result = jsonDecode(post.body);
    log(result.toString());
    parsedtext(result['ParsedResults'][0]['ParsedText']);
    log('OCR 진행');
    print(parsedtext);
    log(parsedtext.toString());
  }

  postPillImage() async {
    // showDialog(
    //   context: Get.context!,
    //   barrierDismissible: false,
    //   builder: (BuildContext context) {
    //     return Dialog(
    //         backgroundColor: Colors.transparent,
    //         child: SizedBox(
    //           height: 80,
    //           width: 80,
    //           child: LiquidCircularProgressIndicator(
    //             value: _animationController.value,
    //             backgroundColor: Colors.white,
    //             valueColor: AlwaysStoppedAnimation(Colors.blue),
    //             center: Text(
    //               "${percentage.toStringAsFixed(0)}%",
    //               style: TextStyle(
    //                 color: Colors.lightBlueAccent,
    //                 fontSize: 20.0,
    //                 fontWeight: FontWeight.bold,
    //               ),
    //             ),
    //           ),
    //         ));
    //   },
    // );

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
      log(request.files.toString());
    }
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
}
