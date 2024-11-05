import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constance.dart';

showMsg(text, type) {
  return Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: type == 'error' ? Colors.redAccent : Colors.greenAccent,
    textColor: Colors.white,
    fontSize: sizeW16,
  );
}
