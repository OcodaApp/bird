// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'dart:ui' as ui;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_picker/map_picker.dart';
import '../../../../constance.dart';
import '../../../../http/request.dart';
import '../../../../http/url.dart';

class OrderShowController extends GetxController {
  MapPickerController mapPickerController = MapPickerController();
  Future<Uint8List> getBytesFromAsset(
      {required String path, required int width}) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  var orderId = 0.obs;
  var isMap = false.obs;
  var type = ''.obs;
  var typeStauts = ''.obs;
  var active = 0.obs;

  var originLatitude = 0.0.obs, originLongitude =  0.0.obs;
  var destLatitude =  0.0.obs, destLongitude =  0.0.obs;
  List<LatLng> polylineCoordinates = [];

  var rating = 0.0.obs;
  var isRating = false.obs;

  @override
  void onInit() {
    print("Get.arguments[8]");
    print(Get.arguments[8]);
    type.value = Get.arguments[0];
    typeStauts.value = Get.arguments[6];
    active.value = Get.arguments[1];
    orderId.value = Get.arguments[8];
    rating.value = double.parse(Get.arguments[7].toString());
    if(rating.value > 0){
      isRating.value = true;
    }else{
      isRating.value = false;
    }
    if(active.value == 1 && typeStauts.value == 'Out for delivery'){

      originLatitude.value = double.parse(Get.arguments[2]);
      originLongitude.value =  double.parse(Get.arguments[3]);
      addMarker(LatLng(double.parse(Get.arguments[2]), double.parse(Get.arguments[3])),"origin",1,);//delevry
      destLatitude.value =  double.parse(Get.arguments[4]);
      destLongitude.value =  double.parse(Get.arguments[5]);
      addMarker(LatLng(double.parse(Get.arguments[4]), double.parse(Get.arguments[5])),"destination",2,);//user
      getPolyline().then((value){
        isMap.value = true;
      });
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(message.data);
      getDeliveryLocation();
      
    });
    
    super.onInit();
  }

  late GoogleMapController mapController2;
  
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  
  PolylinePoints polylinePoints = PolylinePoints();
  late BitmapDescriptor sourceIcon;
  late BitmapDescriptor destinationIcon;
  String googleAPiKey = "AIzaSyATuEq0qRHi33CVV_q9_RwuQ6JRm7C0fWY";

  void onMapCreated(GoogleMapController controller) async {
    mapController2 = controller;
  }

  addMarker(LatLng position, String id, typeMarker) async{
    final Uint8List customMarker;
    if(typeMarker == 1){
      customMarker = await getBytesFromAsset(
      path: ("assets/dmarker.png"), width: 50);
    }else{
      customMarker = await getBytesFromAsset(
    path: ("assets/dmarker2.png"), width: 50);
    }
    
    MarkerId markerId = MarkerId(id);
    var marker = Marker(
      markerId: markerId,
      icon: BitmapDescriptor.fromBytes(customMarker),
      position: position,
    ).obs;
    markers[markerId] = marker.value;
  }

  getPolyline() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyATuEq0qRHi33CVV_q9_RwuQ6JRm7C0fWY', // Your Google Map Key
      PointLatLng(originLatitude.value, originLongitude.value),
      PointLatLng(destLatitude.value, destLongitude.value),
    );
      if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
    }
  }
  

  // @override
  // void onClose() {
  //   super.onClose();
  // }
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  void sendTokenToServer(String fcmToken) {}
  


  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();


  cancelOrder(id) async {
    var data = {'order_id':id};
    Request request = Request(url: urlCancelOrder, body: data);
    request.postAuth().then((value) async {
      if (value['status']) {
        Get.back();
      }else{
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

  rateOrder(id) async {
    var data = {'order_id':id,'rate' : rating.value};
    Request request = Request(url: urlRateOrder, body: data);
    request.postAuth().then((value) async {
      if (value['status']) {
        isRating.value = true;
      }else{
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

  getDeliveryLocation() async {
    var data = {'order_id':orderId.value};
    print('data');
    print(data);
    Request request = Request(url: urlGetDeliveryLocation, body: data);
    request.post().then((value) async {
      if (value['status']) {
        print("orderId.value");
        print(orderId.value);
        print(value);
        originLatitude.value = double.parse(value['lat'].toString());
        originLongitude.value =  double.parse(value['long'].toString());
        addMarker(LatLng(double.parse(value['lat'].toString()), double.parse(value['long'].toString())),"origin",1,);//delevry
        mapController2.animateCamera( 
          CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(double.parse(value['lat'].toString()),double.parse(value['long'].toString())), zoom: 12) 
          )
        );
      }else{
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
}
