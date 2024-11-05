import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../constance.dart';
import '../../../../http/request.dart';
import '../../../../http/url.dart';
import '../../../../utility/General.dart';
import '../../../controller/lang_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class EditProfileController extends GetxController {
  late TextEditingController fristName= TextEditingController();
  late TextEditingController password= TextEditingController();
  late TextEditingController phone= TextEditingController();
  late TextEditingController email= TextEditingController();
  late TextEditingController carType= TextEditingController();
  late TextEditingController carColor= TextEditingController();
  late TextEditingController carNum= TextEditingController();
  
  
  var showPass = false.obs;
  var gender = General.sex.obs;

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

  @override
  void onInit() {
    if(General.image != 'null'){
      isImage.value = true;
      imageUrl.value = General.imgurl;
      image.value = General.image;
    }else{
      isImage.value = false;
      imageUrl.value = '';
      image.value = '';
    }
    fristName.text = General.username;
    phone.text = General.mobile;
    email.text = General.email;
    carType.text = General.carType;
    carColor.text = General.carColor;
    carNum.text = General.carNum;
    super.onInit();
  }

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

  void getImage2(ImageSource imageSource) async {
    final ImagePicker picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: imageSource, maxHeight: 600, maxWidth: 480);
    if (file != null) {
      apiuploadList2(file);
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

  void apiuploadList2(XFile image) async {
    upload2(image);
  }
  var carUrl = "".obs;
  var car = "".obs;
  var isCar= false.obs;

  upload2(XFile file) async {
    isCar.value = false;
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
            carUrl.value = data['data'];
            car.value = data['image'];
            isCar.value = true;
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

  void apiuploadList(XFile image) async {
    upload(image);
  }

  var imageUrl = "".obs;
  var image = "".obs;
  var isImage = false.obs;

  upload(XFile file) async {
    isImage.value = false;
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
            imageUrl.value = data['data'];
            image.value = data['image'];
            isImage.value = true;
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

  

  

  void editUserData() async {
    var data = {
      'device_token': 'deviceToken',
      'email': email.text,
      'phone': phone.text,
      // 'car_type': carType.text,
      // 'car_color': carColor.text,
      // 'car_num': carNum.text,
      // 'car_image' : car.value,
      'image' : isImage.value ? image.value : null,
      'name': fristName.text,
      'password': password.text,
    };
    Request request = Request(url: urlUserUpdate, body: data);
    request.postAuth().then((value) {
      if (value['status']) {
        Fluttertoast.showToast(
          msg: value['msg'],
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.greenAccent,
          textColor: Colors.white,
          fontSize: sizeW14,
        );
        if (value['data'] != null) {
          General().setUserData(value['data']);
          General().getUserData().then((vv){
            Get.back();
            Get.back(result: ['yes']);
          });
        }
        
      } else {
        Fluttertoast.showToast(
          msg: value['msg'],
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: sizeW14,
        );
      }
    }).catchError((onError) {
      Fluttertoast.showToast(
        msg: 'agien'.tr,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: sizeW14,
      );
    });
  }

  @override
  void onClose() {
    fristName.dispose();
    password.dispose();
    phone.dispose();
    email.dispose();
    carType.dispose();
    carColor.dispose();
    carNum.dispose();
    super.onClose();
  }
}
