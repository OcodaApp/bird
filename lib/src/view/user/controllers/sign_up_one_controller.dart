import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:page_route_transition/page_route_transition.dart';

import '../../../../constance.dart';
import '../../../../http/request.dart';
import '../../../../http/url.dart';
import '../verify_email.dart';

class SignUpOneController extends GetxController {
  late TextEditingController email;
  var code = ''.obs;
  var chars = '1234567890';
  Random rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));

  @override
  void onInit() {
    
    email = TextEditingController();
    super.onInit();
  }

  void checkEmail(context,type) async {
    var data = {
      'phone': '966${email.text}',
    };
    Request request = Request(url: urlCheckEmail, body: data);
    request.post().then((value) {
      if (value['status']) {
        PageRouteTransition.effect = TransitionEffect.scale;
        PageRouteTransition.push(context,  VerifyView(email: email.text,code: value['data'].toString(),type:type));
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
    super.onClose();
  }
}
