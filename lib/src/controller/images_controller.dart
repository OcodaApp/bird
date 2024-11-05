import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../constance.dart';
import '../../../../http/url.dart';
import '../../../../utility/General.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import 'lang_controller.dart';

class ImagesController extends GetxController {
  List images = [].obs;
  List imagesUrl = [].obs;

  var image = ''.obs;
  var imageUrl = ''.obs;
  void checkPermission() async {
    Map<Permission, PermissionStatus> statues = await [
      Permission.camera,
      Permission.storage,
      Permission.photos
    ].request();
    PermissionStatus? statusCamera = statues[Permission.camera];
    PermissionStatus? statusStorage = statues[Permission.storage];
    PermissionStatus? statusPhotos = statues[Permission.photos];
    bool isGranted = statusCamera == PermissionStatus.granted &&
        statusStorage == PermissionStatus.granted &&
        statusPhotos == PermissionStatus.granted;
    if (isGranted) {
    }
    bool isPermanentlyDenied =
        statusCamera == PermissionStatus.permanentlyDenied ||
            statusStorage == PermissionStatus.permanentlyDenied ||
            statusPhotos == PermissionStatus.permanentlyDenied;
    if (isPermanentlyDenied) {
    }
  }

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  // image
  void getImage(ImageSource imageSource) async {
    final ImagePicker picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: imageSource, maxHeight: 600, maxWidth: 480);
    if (file != null) {
      apiuploadList(file);
    } else {
      Fluttertoast.showToast(
        msg: 'no image selected'.tr,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: sizeW15,
      );
    }
  }

  

  void apiuploadList(XFile image) async {
    upload(image);
  }

  


  upload(XFile file) async {
    Future.delayed(
      Duration.zero,
      () => Get.dialog(
       const Center(
            child: CircularProgressIndicator(
          backgroundColor: primaryColor,
        )),
        barrierDismissible: false,
      ),
    );
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
        urlBase + uploadImageUser,
      ),
    );
    final LangController langController = Get.put(LangController());
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept-Language": langController.appLocale,
      "app-id": 'romwayAtharOmarKamel',
      "Authorization": General.token,
    };
    request.headers.addAll(headers);
    request.files.add(
      http.MultipartFile(
        'image',
        File(file.path).readAsBytes().asStream(),
        File(file.path).lengthSync(),
        filename: file.path.split("/").last,
      ),
    );

    await request.send().then(
      (response) async {
        if (response.statusCode < 200 ||
            response.statusCode > 400 ) {
          Fluttertoast.showToast(
            msg: 'error_api'.tr,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.redAccent,
            textColor: Colors.white,
            fontSize: sizeW15,
          );
          Get.back();
        } else {
          var responseData = await response.stream.toBytes();
          var responseString = String.fromCharCodes(responseData);
          var data = jsonDecode(responseString);
          if (data['status']) {
            imagesUrl.addAll([data['data']]);
            images.addAll([data['image']]);
            Get.back();
          } else {
            Fluttertoast.showToast(
              msg: data['msg'].toString(),
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.redAccent,
              textColor: Colors.white,
              fontSize: sizeW15,
            );
            
          }
          return responseString;
        }
      },
    );
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
