

// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_picker/map_picker.dart';
import 'package:page_route_transition/page_route_transition.dart';
import '../../../../constance.dart';
import '../../../../http/request.dart';
import '../../../../http/url.dart';
import '../../../../model/branches_list_modal.dart';
import '../thank_view.dart';


class ContactsController extends GetxController {
  late TextEditingController fristName;
  late TextEditingController lastname;
  late TextEditingController emailtext;
  late TextEditingController phonetext;
  late TextEditingController msg;


  MapPickerController mapPickerController = MapPickerController();
  
  // setting
  var email = ''.obs;
  var phone = ''.obs;
  var branchesData = [].obs;
  void getSettingList() async {
    Request request = Request(url: urlGetSetting, body: null);
    request.get().then((value) async {
      if (value['status']) {
        email.value = value['data']['email'];
        phone.value = value['data']['phone'];
      } 
    }).catchError((onError) {
    });
  }

  var brancheChoose = 0.obs;
  var lat = 0.0.obs;
  var long = 0.0.obs;
  var isBranch = false.obs;
  void getBranchesList() async {
    Request request = Request(url: urlGetBranches, body: null);
    request.get().then((value) async {
      if (value['status']) {
        BranchesListModel branchesListModel = BranchesListModel.fromJson(value);
        branchesData.value = branchesListModel.branche!;
        if(branchesData.isNotEmpty){
          brancheChoose.value = branchesData[0].id;
          lat.value = double.parse(branchesData[0].latitude);
          long.value = double.parse(branchesData[0].longitude);
          isBranch.value = true;
        }
      }else{
        brancheChoose.value = 0;
        isBranch.value = false;
      }
    }).catchError((onError) {
      brancheChoose.value = 0;
      isBranch.value = false;
    });
  }

  getMap (){
    return isBranch.value? Container(
      height: Get.height /3.5,
      width: double.infinity,
      decoration:    BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(sizeW25),
        ),
      ),
      child: ClipRRect(
        borderRadius:   BorderRadius.all(
          Radius.circular(sizeW25),
        ),
        child: MapPicker(
          iconWidget: Image.asset(
            "assets/marker.png",
          ),
          mapPickerController: mapPickerController,
          child: GoogleMap(
            myLocationEnabled: false,
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
            mapType: MapType.normal,
            rotateGesturesEnabled : false,
            initialCameraPosition: CameraPosition( //innital position in map
              target: LatLng(lat.value, long.value), //initial position
              zoom: 10.0, //initial zoom level
            ),
            
            onCameraMoveStarted: () {
              mapPickerController.mapMoving!();
            },
            onCameraMove: (cameraPosition) {
              cameraPosition = CameraPosition(
                target: LatLng(lat.value, long.value),
                zoom: 10.0,
              );
            },
          ),
        ),
      ),
    ):Container();
  }
  @override
  void onInit() {
    getSettingList();
    getBranchesList();
    fristName= TextEditingController();
    lastname= TextEditingController();
    emailtext= TextEditingController();
    phonetext= TextEditingController();
    msg= TextEditingController();
    super.onInit();
  }

  postContacts(context) async {
    var data = {
      'first_name': fristName.text,
      'last_name': lastname.text,
      'phone': phonetext.text,
      'email': emailtext.text,
      'msg': msg.text,
      'device_token': 'sss',
    };
    Request request = Request(url: urlPostContacts, body: data);
    request.postAuth().then((value) {
      if (value['status']) {
        PageRouteTransition.effect = TransitionEffect.scale;
        PageRouteTransition.pushReplacement(context,  const ThankView());
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
  late Timer timer;
  List<Widget> createSliders() {
    List<Widget> imageSliders = branchesData.map((item) {
      return GestureDetector(
        onTap: (){
          isBranch.value = false;
          lat.value = double.parse(item.latitude);
          long.value = double.parse(item.longitude);
          getMap();
          timer =  Timer(const Duration(seconds: 1), () {
            isBranch.value = true;
          });
        },
        child: Column(
          children: [
            Container(
              width: Get.width / 1,
              padding:   EdgeInsets.only(right: sizeW25,left: sizeW25,top: sizeH15,bottom: sizeH15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(sizeW45),
                color:  Colors.white,
                border: Border.all(color:  const Color(0xFFE6E6E6))
              ),
              child: Row(
                children: [
                  Image.asset('assets/icons/location-tick.png',height: sizeW25,width: sizeW25,fit: BoxFit.fill,),
                  SizedBox(width: sizeW25,),
                   Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style:  TextStyle(
                          fontSize: sizeW16,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: sizeW5,),
                      Text(
                        item.phone.toString(),
                        style:  TextStyle(
                          fontSize: sizeW16,
                          color: greyOpacityColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: sizeH15,),
          ],
        )
      );
    }).toList();
    return imageSliders;
  }

  @override
  void onClose() {
    fristName.dispose();
    lastname.dispose();
    emailtext.dispose();
    phonetext.dispose();
    msg.dispose();
    timer.cancel();
    super.onClose();
  }
}
