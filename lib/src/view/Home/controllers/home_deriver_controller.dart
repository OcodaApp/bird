

// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import '../../../../constance.dart';
import '../../../../http/request.dart';
import '../../../../http/url.dart';
import '../../../../model/orders_list_model.dart';
import '../../../../utility/General.dart';
import '../../Orders/show_order_view.dart';


class HomeDeriverController extends GetxController {
var orderssData = [].obs;
  void getMyOrders() async {
    var data = {
      'latitude' : General.latitude,
      'longitude' : General.longitude,
    };
    Request request = Request(url: urlDeriverMyOrders, body: data);
    request.postAuth().then((value) async {
      if (value['status']) {
        OrderssListModel ordersListModel = OrderssListModel.fromJson(value);
        orderssData.value = ordersListModel.data!;

      } 
    }).catchError((onError) {
    });
  }
  getStatus(status){
    if(status == 'wait'){
      return 'wait';
    }

    if(status == 'accepted'){
      return 'Order Placed';
    }

    if(status == 'processing'){
      return 'Order Preparing';
    }

    if(status == 'ongoing'){
      return 'Out for delivery';
    }
  }

  List<Widget> createSliders() {
    List<Widget> imageSliders = orderssData.asMap().entries.map((item) {
      return Column(
        children: [
          GestureDetector(
            
            onTap: ()async{
              if(getStatus(item.value.status) == 'Out for delivery'){
                await Get.to(()=> ShowOrderView(
                  type : 'Deliverd',
                  orderData: item.value,
                  store: item.value.store,
                  user: item.value.user,
                  address: json.encode(item.value.address),
                  fromAddress: item.value.fromAddress,
                  toAddress: item.value.toAddress,
                  items: item.value.items,
                  delegate : json.encode(item.value.delegate),
                  ),
                  
                  arguments: [item.value.type,item.value.active,
                    item.value.type == 'order'? item.value.address['latitude']:item.value.fromAddress['latitude'],
                    item.value.type == 'order'? item.value.address['longitude']:item.value.toAddress['longitude'],
                    'Deliverd',
                    item.value.rateAvg
                  ]
                );
              }else{
                await Get.to(()=> ShowOrderView(
                  type : 'Deliverd',
                  orderData: item.value,
                  store: item.value.store,
                  user: item.value.user,
                  address: json.encode(item.value.address),
                  fromAddress: item.value.fromAddress,
                  toAddress: item.value.toAddress,
                  items: item.value.items,
                  delegate : json.encode(item.value.delegate),
                  ),
                  
                  arguments: [item.value.type,item.value.active,
                    '','',
                    '','',
                    'Deliverd',
                    item.value.rateAvg
                  ]
                );
              }
              
              getMyOrders();
            },
            child: Container(
              padding:  EdgeInsets.only(bottom: sizeH20),
              decoration:   BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: item.key == orderssData.length - 1?whitecolor: grey5),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      item.value.storeLogo != 'null' && item.value.storeLogo != ''?
                      FadeInDown(child:Image.network(item.value.storeLogo,width: sizeW30,height: sizeW30,fit: BoxFit.fill,),):
                      FadeInDown(child:Image.asset('assets/logo.png',width: sizeW30,height: sizeW30,fit: BoxFit.fill,),),
                      SizedBox(width: sizeW15,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.value.storeName != 'null'&& item.value.storeName != ''? item.value.storeName:'Deliver Package'.tr,
                            style: TextStyle(color: primaryColor,fontSize: sizeW16,fontWeight: FontWeight.w500),),
                          Text(item.value.statusName,style: TextStyle(color: primaryTowColor,fontSize: sizeW14,fontWeight: FontWeight.w300,height: 1.3),),
                          Text(item.value.date,style: TextStyle(color: greyOpacityColor,fontSize: sizeW14,fontWeight: FontWeight.w300,height: 1.3),),
                          Text('${'Order ID'.tr}: ${item.value.code}',
                          style: TextStyle(color: greyOpacityColor,fontSize: sizeW14,fontWeight: FontWeight.w300,height: 1.3)),
                          SmoothStarRating(
                            allowHalfRating: false,
                            onRatingChanged: (v) {
                            },
                            starCount: 5,
                            rating: double.parse(item.value.rateAvg.toString()),
                            size: sizeW25,
                            filledIconData: Icons.star,
                            halfFilledIconData: Icons.star,
                            color: Colors.orange,
                            borderColor: Colors.orange,
                            spacing:sizeW5
                          ),
                          item.value.active != 1 ? Container(
                            margin:  EdgeInsets.only(top: sizeH5),
                            padding:  EdgeInsets.only(right: sizeW15,left: sizeW15,bottom: sizeH5,top: sizeH5),
                            decoration: BoxDecoration(
                              color:   primaryTowColor.withOpacity(.1),
                              borderRadius: BorderRadius.circular(45),
                            ),
                            child: Row(
                              children: [
                                FadeInDown(child:Image.asset('assets/icons/rotate.png',width: sizeW12,height: sizeW12,fit: BoxFit.fill,),),
                                  SizedBox(width: sizeW5,),
                                  Text('canceled'.tr,style: TextStyle(fontSize: sizeW14,fontWeight: FontWeight.w500,color: primaryTowColor),),
                              ],
                            ),
                          ):Container(),
                        ],
                      ),
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios_outlined,size: sizeW15,color: greyOpacityColor,),
                ],
              ),
            ),
          ),
          SizedBox(height: sizeH20,),
        ],
      );
    }).toList();
    return imageSliders;
  }

  var oneKm = 0.0.obs;
  var towKm = 0.0.obs;

  var oneMins = 0.0.obs;
  var towMins = 0.0.obs;


  Future<double> calculateDistance(lat1, lon1, lat2, lon2)async{
    var distanceInMeters = Geolocator.distanceBetween(
      lat1,
      lon1,
      lat2,
      lon2,
    );
    oneKm.value = distanceInMeters;
    oneMins.value = oneKm.value * 2;
    return distanceInMeters;
  }

  Future<double> calculateDistance2(lat1, lon1, lat2, lon2)async{
    var distanceInMeters = Geolocator.distanceBetween(
      lat1,
      lon1,
      lat2,
      lon2,
    );
    towKm.value = distanceInMeters;
    towMins.value = towKm.value * 2;
    return distanceInMeters;
  }

  @override
  void onInit() {
    getMyOrders();
    super.onInit();
  }
  
  

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
