import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:page_route_transition/page_route_transition.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';
import '../../../../constance.dart';
import '../../../../http/request.dart';
import '../../../../http/url.dart';
import '../../../../model/terms_list_model2.dart';
import '../../../../utility/General.dart';
import '../../../controller/lang_controller.dart';
import '../login_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class CreateAccDriverController extends GetxController {
  late TextEditingController fristName;
  late TextEditingController password;
  late TextEditingController phone;
  late TextEditingController carType;
  late TextEditingController carColor;
  late TextEditingController carNum;
  
  var terms = 0.obs;
  var showPass = false.obs;
  
  // setting
  var termsUpdated = ''.obs;
  var isData = false.obs;
  var settingsData = [].obs;
  void getSettingList() async {
    Request request = Request(url: urlGetSetting, body: null);
    request.get().then((value) async {
      if (value['status']) {
        termsUpdated.value = value['data']['terms_updated_delegate'];
        TermsListModel2 termsListModel = TermsListModel2.fromJson(value['data']);
        settingsData.value = termsListModel.terms!;
        isData.value = true;
      } else {
        isData.value = false;
      }
    }).catchError((onError) {
      isData.value = false;
    });
  }

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
      //openCameraGallery();
      //_openDialog(context);
    }
    bool isPermanentlyDenied =
        statusCamera == PermissionStatus.permanentlyDenied ||
            statusStorage == PermissionStatus.permanentlyDenied ||
            statusPhotos == PermissionStatus.permanentlyDenied;
    if (isPermanentlyDenied) {
      // _showSettingsDialog(context);
    }
  }

  @override
  void onInit() {
    getSettingList();
    fristName = TextEditingController();
    password = TextEditingController();
    phone = TextEditingController();
    carType = TextEditingController();
    carColor = TextEditingController();
    carNum = TextEditingController();
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

  SliverWoltModalSheetPage page1(BuildContext modalSheetContext) {
    return WoltModalSheetPage(
      navBarHeight : sizeH30,
      hasSabGradient: false,
      stickyActionBar: Container(
        padding: EdgeInsets.all(sizeW10),
        color: Colors.white,
        child: MaterialButton(
          elevation: 0,
          color: primaryColor,
          minWidth: Get.width / 1.1,
          height: sizeH50,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(sizeW45),
          ),
          onPressed: (){
            FocusManager.instance.primaryFocus?.unfocus();
            terms.value = 1;
            Get.back();
          },
          child: Text(
            'Got it',
            style:  TextStyle(
              fontSize: sizeW22,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      // topBarTitle: const Text('Pagination'),
      isTopBarLayerAlwaysVisible: false,
      
      child: SizedBox(
        height: Get.height / 1.3,
        child:  Padding(
          padding: EdgeInsets.only(right: sizeW15,left: sizeW15),
          child: ListView(
            children:[
              Text(
                'Terms & conditions'.tr,
                style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w800),
              ),
              SizedBox(height: sizeH15,),
              Text(
                termsUpdated.value,
                style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w500,color: const Color(0xFF808080)),
              ),
              
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: createSliders(),),
              SizedBox(height: sizeH100,),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> createSliders() {
    List<Widget> imageSliders = settingsData.map((item) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: sizeH15,),
          Text(
            '${item.name}',
            style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w600),
          ),
          Text(
            '${item.desc}',
            style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w400,color: const Color(0xFF999999)),
          ),
        ],
      );
    }).toList();
    return imageSliders;
  }

  void signUp(email,context,type) async {
    var data = {
      'device_token': 'deviceToken',
      'email': email,
      'phone': phone.text,
      'car_type': carType.text,
      'car_color': carColor.text,
      'car_num': carNum.text,
      'car_image' : car.value,
      'img' : image.value,
      'name': fristName.text,
      'password': password.text,
      'type': type,
    };
    Request request = Request(url: urlsignUp, body: data);
    request.post().then((value) {
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
        PageRouteTransition.effect = TransitionEffect.scale;
        PageRouteTransition.push(context,  LoginView());
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
    carType.dispose();
    carColor.dispose();
    carNum.dispose();
    super.onClose();
  }
}
