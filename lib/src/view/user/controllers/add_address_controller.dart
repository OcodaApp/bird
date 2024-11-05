import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../../constance.dart';
import '../../../../http/request.dart';
import '../../../../http/url.dart';
import '../../../../utility/Address.dart';
import '../../Home/controllers/home_controller.dart';
import '../../home_view.dart';

class AddAddressController extends GetxController {

  // @override
  // void onInit() {
  //   super.onInit();
  // }
  

  void addAddressHome(locationName,street,city,building,flat,floor,lat,long,defaultLocation) async {
    var data = {
      'location_name': locationName,
      'addres_text': street,
      'street': street,
      'city': city,
      'building': building,
      'flat': flat,
      'floor': floor,
      'static': defaultLocation == 1?'yes':'no',
      'latitude': lat,
      'longitude': long,
    };
    Request request = Request(url: urlAddAddress, body: data);
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
        Address().setAddressData(value['data']);
        Address().getAddressData().then((vv){
          final HomeController controller = Get.put(HomeController());
          controller.addrssName.value = Address.a_name;
          controller.addrssStreet.value = Address.a_street;
          controller.addrssId.value = int.parse(Address.a_id);
          Get.to(()=>const HomeView());
        });
        
        // PageRouteTransition.effect = TransitionEffect.scale;
        // PageRouteTransition.push(context,  LoginView());
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

  void addAddressPackage(locationName,street,city,building,flat,floor,lat,long,defaultLocation) async {
    var data = {
      'location_name': locationName,
      'addres_text': street,
      'street': street,
      'city': city,
      'building': building,
      'flat': flat,
      'floor': floor,
      'static': defaultLocation == 1?'yes':'no',
      'latitude': lat,
      'longitude': long,
    };
    Request request = Request(url: urlAddAddress, body: data);
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
        Get.back(result: value['id']);
        Get.back(result: value['id']);
        
        // PageRouteTransition.effect = TransitionEffect.scale;
        // PageRouteTransition.push(context,  LoginView());
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

   editAddressHome(id,locationName,street,city,building,flat,floor,lat,long,defaultLocation) async {
    var data = {
      'addres_id': id,
      'location_name': locationName,
      'addres_text': street,
      'street': street,
      'city': city,
      'building': building,
      'flat': flat,
      'floor': floor,
      'static': defaultLocation == 1?'yes':'no',
      'latitude': lat,
      'longitude': long,
    };
    Request request = Request(url: urlEditAddress, body: data);
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
        Get.to(()=>const HomeView());
        
        // PageRouteTransition.effect = TransitionEffect.scale;
        // PageRouteTransition.push(context,  LoginView());
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

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
