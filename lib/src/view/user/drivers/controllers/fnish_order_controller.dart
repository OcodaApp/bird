// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:ui' as ui;
import 'package:birdandroid/utility/General.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:map_picker/map_picker.dart';
import '../../../../../constance.dart';
import '../../../../../http/request.dart';
import '../../../../../http/url.dart';
import '../deriver_home.dart';

class FnishOrderController extends GetxController {
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

  changeOrderDeliveryStatus() async {
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
      'order_id':orderId.value,
      'status' : 'fnish',
      'latitude' : deliveryLat.value,
      'longitude' : deliveryLong.value,
    };
    Request request = Request(url: urlChangeDeliveryStatus, body: data);
    request.postAuth().then((value) async {
      Get.back();
      if (value['status']) {
        General().setlatitude(deliveryLat.value);
        General().setlongitude(deliveryLong.value);
        General().getlatitude();
        General().getlongitude();
        General().getUserData().then((val){
          Get.to(()=>const DeriverHomeView());
        });
        
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

  var isMap = false.obs;
  var userLat = 0.0.obs;
  var userLong = 0.0.obs;
  var deliveryLat = 0.0.obs;
  var deliveryLong = 0.0.obs;

  var originLatitude = 0.0.obs, originLongitude =  0.0.obs;
  var destLatitude =  0.0.obs, destLongitude =  0.0.obs;
  List<LatLng> polylineCoordinates = [];

  var orderId = 0.obs;
  @override
  void onInit() {
      orderId.value = Get.arguments[0]['id'];
      userLat.value = General.latitude;
      userLong.value = General.longitude;
      deliveryLat.value = double.parse(Get.arguments[0]['to_latitude'].toString());
      deliveryLong.value = double.parse(Get.arguments[0]['to_longitude'].toString());
      originLatitude.value = General.latitude;
      originLongitude.value =  General.longitude;
      destLatitude.value =  double.parse(Get.arguments[0]['to_latitude'].toString());
      destLongitude.value =  double.parse(Get.arguments[0]['to_longitude'].toString());
      
      addMarker(LatLng(General.latitude, General.longitude),"origin",1,);
      addMarker(LatLng(double.parse(Get.arguments[0]['to_latitude'].toString()), double.parse(Get.arguments[0]['to_longitude'].toString())),"destination2",2,);
      getPolyline().then((value){
        isMap.value = true;
        // getCurrentLocation();
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
      path: ("assets/marker.png"), width: 50);
    }else if(typeMarker == 3){
      customMarker = await getBytesFromAsset(
      path: ("assets/marker2.png"), width: 45);
    }
    else{
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

  LocationData? currentLocation;
  void getCurrentLocation() async {
    Location location = Location();
    location.getLocation().then(
      (location) {
        currentLocation = location;
      },
    );
    // GoogleMapController googleMapController = await controller.future;
    location.onLocationChanged.listen(
      (newLoc) {
        currentLocation = newLoc;
        if(newLoc.latitude != General.latitude && newLoc.longitude != General.longitude){
          General().setlatitude(newLoc.latitude!);
          General().setlongitude(newLoc.longitude!);
          General().getlatitude();
          General().getlongitude();
          General().getUserData().then((val){
            mapController2.animateCamera( 
              CameraUpdate.newCameraPosition(
                CameraPosition(target: LatLng(newLoc.latitude!,newLoc.longitude!), zoom: 14) 
              )
            );
          });

        }
      },
    );
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
}
