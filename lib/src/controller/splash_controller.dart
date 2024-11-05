// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';
import 'package:birdandroid/src/view/home_view.dart';
import 'package:birdandroid/src/view/user/login_or_signapp.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../constance.dart';
import '../../http/request.dart';
import '../../http/url.dart';
import '../../utility/Address.dart';
import '../../utility/General.dart';
import '../view/user/controllers/place_controller.dart';
import '../view/user/drivers/deriver_home.dart';
import '../view/user/drivers/is_order_view_first.dart';
import '../view/user/drivers/is_order_view_fnish.dart';
import '../view/user/drivers/is_order_view_go.dart';
import '../view/user/drivers/is_order_view_wait.dart';
import '../view/user/location_view.dart';
import 'lang_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class SplashController extends GetxController {
  late Timer timer;
  var isLogin = false.obs;
  var isIntro = false.obs;
  final LangController langController = Get.put(LangController());
  String? deviceToken = '';
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  getToken() async {
    await firebaseMessaging.getToken().then((value) {
      deviceToken = value!;
    }).catchError((error){
      print(error);
    });
  }

  checkGoPage() async {
    getToken();
    General.token.trim() != "" ? isLogin.value = true : isLogin.value = false;
    General.isIntro ? isIntro.value = true : isIntro.value = false;
    update();
  }

  checkNet() async{
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        checkGoPage().then((value) {
          if (isLogin.value) {
            timer =  Timer(const Duration(seconds: 2), () {
              print('login');
              login();
            });
          } else {
            if (isIntro.value) {
              timer =  Timer(const Duration(seconds: 2), () {
                noLogin();
              });
            } else {
              timer =  Timer(const Duration(seconds: 3), () {
                Get.offNamed('/intro');
              });
            }
          }
        });
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(
        msg: 'not connected'.tr,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: sizeW15,
      );
    }
  }
  
  @override
  void onInit() {
    FocusManager.instance.primaryFocus?.unfocus();
    checkNet();
    super.onInit();
  }

  void noLogin() {
    Get.off(()=> General.token.isEmpty?const LoginOrSignUpView(skipVisible: true,):HomeView());
  }

  void login() async {
    var data = {
      'device_token': deviceToken,
      'language': langController.appLocale,
    };
    Request request = Request(url: urlUserData, body: data);
    request.postAuth().then((value) {
      if (value['status']) {
        print("General.tokenGeneral.tokenGeneral.tokenGeneral.tokenGeneral.token");
        print(General.token);
        if (value['data'] != null) {
          print("value['data']['count_notfy']");
          print(value['data']['count_notfy']);
          General().setUserData(value['data']);
          General().setwalletCount(double.parse(value['data']['count_walet'].toString()));
          General().getUserData();
          print("value['data']['count_notfy']");
          print(General.notficationsCount);
          if(value['data']['addres_default'] != null){
            Address().setAddressData(value['data']['addres_default']);
            Address().getAddressData();
            Get.offNamed('/homeView');
          }else{
            PlaceController placeController = Get.put(PlaceController());
            if(value['data']['type'] == 'client'){
              placeController.getCurrentLocation().then((res) {
                print('res');
                print(res);
                General().getlatitude();
                General().getlongitude();
                General().getUserData().then((val){
                  print("General.latitude");
                  print(General.latitude);
                  Get.to(()=>MapSearchView(lat: General.latitude,long: General.longitude,));
                });
              });
            }else{
              if(value['data']['is_order'] == 'yes'){
                General().setOrder(true);
                General().setOrder(false);
                  placeController.getCurrentLocationDriver().then((res) {
                  General().getlatitude();
                  General().getlongitude();
                  General().getUserData().then((val){
                    print("value['data']['order']['order_delivery_statu']");
                    print(value['data']['order']['order_delivery_statu']);
                    if(value['data']['order']['order_delivery_statu'] == 'no'){
                      //first
                      Get.to(()=> IsOrderViewFirst(order: value['data']['order'],),arguments: [value['data']['order']]);
                    }

                    if(value['data']['order']['order_delivery_statu'] == 'first'){
                      //wait
                      Get.to(()=> IsOrderViewWait(order: value['data']['order'],),arguments: [value['data']['order']]);
                    }

                    if(value['data']['order']['order_delivery_statu'] == 'wait'){
                      //go
                      Get.to(()=> IsOrderViewGo(order: value['data']['order'],),arguments: [value['data']['order']]);
                    }

                    if(value['data']['order']['order_delivery_statu'] == 'go'){
                      //fnish
                      Get.to(()=> IsOrderViewFnish(order: value['data']['order'],),arguments: [value['data']['order']]);
                    }
                  });
                });
              }

              if(value['data']['is_order'] == 'no'){
                General().setOrder(false);
                  placeController.getCurrentLocationDriver().then((res) {
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
          noLogin();
        }
      } else {
        noLogin();
      }
    }).catchError((onError) {
      noLogin();
    });
  }

  @override
  void onClose() {
    timer.cancel();
    super.onClose();
  }
}
