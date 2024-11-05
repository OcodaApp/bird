import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:page_route_transition/page_route_transition.dart';
import '../../../../constance.dart';
import '../../../../http/request.dart';
import '../../../../http/url.dart';
import '../forget/forget_verify_email.dart';

class ForgetEmailController extends GetxController {
  late TextEditingController email;
  var code = ''.obs;
  var userId = ''.obs;
  

  @override
  void onInit() {
    email = TextEditingController();
    super.onInit();
  }

  void checkEmail(context) async {
    var data = {
      'phone': '966${email.text}',
    };
    Request request = Request(url: urlForgetEmail, body: data);
    request.post().then((value) {
      if (value['status']) {
        code.value = value['code'].toString();
        userId.value = value['data'].toString();
        PageRouteTransition.effect = TransitionEffect.scale;
        PageRouteTransition.push(context,  ForgetVerifyView(email: '966${email.text}',code: code.value,userId:userId.value));
      } else {
        Fluttertoast.showToast(
          msg: 'Phone number is wrong'.tr,
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
    super.onClose();
  }
}
