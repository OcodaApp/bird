import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../../constance.dart';
import '../../../../http/request.dart';
import '../../../../http/url.dart';
import '../../../../utility/Address.dart';
import '../../../../utility/General.dart';
import '../drivers/deriver_home.dart';
import '../drivers/is_order_view_first.dart';
import '../location_view.dart';
import 'place_controller.dart';

class LoginController extends GetxController {
  late TextEditingController email;
  late TextEditingController password;
  var showPass = false.obs;

  String? deviceToken = '';
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  getToken() async {
    await firebaseMessaging.getToken().then((value) {
      deviceToken = value!;
    });
  }

  @override
  void onInit() {
    getToken();
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  void login() async {
    var data = {
      'phone': '966${email.text}',
      'password': password.text,
      'device_token': deviceToken,
    };
    Request request = Request(url: urlLogin, body: data);
    request.post().then((value) {
      if (value['status']) {
        if (value['data'] != null) {
          General().setTokenData(value['data']['token']);
          General().setUserData(value['data']);
          General().setwalletCount(double.parse(value['data']['count_walet'].toString()));
          General().getUserData();
          
          if(value['data']['addres_default'] != null){
            Address().setAddressData(value['data']['addres_default']);
            Address().getAddressData();
            email.clear();
            password.clear();
            print("object");
            Get.offAllNamed('/homeView');
          }
          else{
            PlaceController placeController = Get.put(PlaceController());
            if(value['data']['type'] == 'client'){
              placeController.getCurrentLocation().then((res) {
                email.clear();
                password.clear();
                General().getlatitude();
                General().getlongitude();
                General().getUserData().then((val){
                  Get.to(()=>MapSearchView(lat: General.latitude,long: General.longitude,));
                });
              });
            }else{
              if(value['data']['is_order'] == 'yes'){
                General().setOrder(true);
                  placeController.getCurrentLocationDriver().then((res) {
                    email.clear();
                    password.clear();
                  General().getlatitude();
                  General().getlongitude();
                  General().getUserData().then((val){
                    if(value['data']['order']['order_delivery_statu'] == 'no'){
                      //first
                      Get.to(()=> IsOrderViewFirst(order: value['data']['order'],),arguments: [value['data']['order']]);
                    }
                    
                  });
                });
              }

              if(value['data']['is_order'] == 'no'){
                General().setOrder(false);
                  placeController.getCurrentLocationDriver().then((res) {
                    email.clear();
                    password.clear();
                  General().getlatitude();
                  General().getlongitude();
                  General().getUserData().then((val){
                    Get.to(()=>const DeriverHomeView());
                  });
                });
              }
            }
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
    email.dispose();
    password.dispose();
    super.onClose();
  }
}
