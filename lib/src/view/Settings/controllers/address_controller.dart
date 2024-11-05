// ignore_for_file: avoid_print, empty_catches, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../../constance.dart';
import '../../../../http/request.dart';
import '../../../../http/url.dart';
import '../../../../model/address_list_model.dart';
import '../../../../utility/Address.dart' as address;
class AddressController extends GetxController {
  var isDataAddress = false.obs;
  var addrssData = [].obs;
  var addrssId = 0.obs;
  var addressChoose;
  @override
  void onInit() {
    addrssId.value = int.parse(address.Address.a_id);
    getAddressUser();
    super.onInit();
  }
  
  void getAddressUser() async {
    Request request = Request(url: urlMyAddress, body: null);
    request.getAuth().then((value) {
      if (value['status']) {
        AddressListModel addressListModel = AddressListModel.fromJson(value);
        addrssData.value = addressListModel.address!;
        isDataAddress.value = true;
      } else {
      }
    }).catchError((onError) {
    });
  }

  deleteAddress(id) async {
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
    var data = {
      'addres_id': id,
    };
    Request request = Request(url: urlDeleteAddress, body: data);
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
      Get.back();
    }).catchError((onError) {
      Get.back();
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

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
