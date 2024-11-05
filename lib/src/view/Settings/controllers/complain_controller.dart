

// ignore_for_file: prefer_typing_uninitialized_variables


import 'package:birdandroid/utility/General.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:page_route_transition/page_route_transition.dart';
import '../../../../constance.dart';
import '../../../../http/request.dart';
import '../../../../http/url.dart';
import '../../../../model/complains_list_model.dart';
import '../thank_view.dart';


class ComplainController extends GetxController {
  late TextEditingController fristName;
  late TextEditingController lastname;
  late TextEditingController emailtext;
  late TextEditingController phonetext;
  late TextEditingController msg;

  var complainsData = [].obs;
  var isData = false.obs;
  void getComplainsList() async {
    Request request = Request(url: urlmycomplain, body: null);
    request.postAuth().then((value) async {
      if (value['status']) {
        ComplainsListModel complainsListModel = ComplainsListModel.fromJson(value);
        complainsData.value = complainsListModel.complain!;
        if(complainsData.isNotEmpty){
          isData.value = true;
        }
      }else{
        isData.value = false;
      }
    }).catchError((onError) {
      isData.value = false;
    });
  }

  deleteComplain(id) async {
    var data = {'item_id':id};
    Request request = Request(url: urlDeleteComplain, body: data);
    request.postAuth().then((value) async {
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
        getComplainsList();
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

  List<Widget> createSliders() {
    List<Widget> imageSliders = complainsData.map((item) {
      return Column(
        children: [
          Container(
            padding:  EdgeInsets.all(sizeW20),
            decoration:  BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(sizeW15),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color:  const Color.fromARGB(31, 153, 152, 152).withOpacity(0.2),
                  offset:  const Offset(2.0, 2.0),
                  blurRadius: 20.0,
                )
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        General.image == 'null'? 
                        Image.asset('assets/icons/person2.png',width: sizeW45,height: sizeW45,fit: BoxFit.fill,):CircleAvatar(
                          maxRadius: sizeW25,
                          minRadius: sizeW25,
                          backgroundImage: NetworkImage(General.imgurl),
                        ),
                        SizedBox(width: sizeW10,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: Get.width / 1.7,
                              child: Text(item.msg,style: TextStyle(color: primaryColor,fontSize: sizeW16,fontWeight: FontWeight.w600),overflow: TextOverflow.ellipsis,)),
                            SizedBox(height: sizeH2,),
                            Text(item.date,style: TextStyle(color: primaryColor,fontSize: sizeW12,fontWeight: FontWeight.w400),),
                          ],
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: (){
                        deleteComplain(item.id);
                      },
                      child: Image.asset('assets/icons/trash.png',width: sizeW16,height: sizeW16,fit: BoxFit.fill,),
                    ),
                  ],
                ),
                SizedBox(height: sizeH10,),
                Text(
                  item.msg
                  ,style: TextStyle(color: const Color(0xFF999999),fontSize: sizeW14,fontWeight: FontWeight.w400))
              ],
            ),
          ),
          SizedBox(height: sizeH15,),
        ],
      );
    }).toList();
    return imageSliders;
  }

  
  @override
  void onInit() {
    getComplainsList();
    fristName= TextEditingController();
    lastname= TextEditingController();
    emailtext= TextEditingController();
    phonetext= TextEditingController();
    msg= TextEditingController();
    super.onInit();
  }

  postcomplain(context) async {
    var data = {
      'first_name': fristName.text,
      'last_name': lastname.text,
      'phone': phonetext.text,
      'email': emailtext.text,
      'msg': msg.text,
      'device_token': '',
    };
    Request request = Request(url: urlPostcomplain, body: data);
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
  

  @override
  void onClose() {
    fristName.dispose();
    lastname.dispose();
    emailtext.dispose();
    phonetext.dispose();
    msg.dispose();
    super.onClose();
  }
}
