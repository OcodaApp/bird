import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:page_route_transition/page_route_transition.dart';
import '../../../../constance.dart';
import '../../../../http/request.dart';
import '../../../../http/url.dart';
import '../login_view.dart';

class ForgetChangePassController extends GetxController {
  late TextEditingController copassword;
  late TextEditingController password;
  var showPass = false.obs;
  var showCoPass = false.obs;
  
  

  @override
  void onInit() {
    copassword = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }
  

  void changePass(email,context,userid) async {
    var data = {
      'device_token': 'deviceToken',
      'phone': email,
      'password': password.text,
      'user_id' : userid,
    };
    Request request = Request(url: urlchangePass, body: data);
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
        PageRouteTransition.pushReplacement(context,  LoginView());
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
    copassword.dispose();
    password.dispose();
    super.onClose();
  }
}
