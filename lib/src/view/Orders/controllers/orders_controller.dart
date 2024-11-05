import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import '../../../../constance.dart';
import '../../../../http/request.dart';
import '../../../../http/url.dart';
import '../../../../model/Previous_orders_model.dart';
import '../../../../model/orders_list_model.dart';
import '../show_order_view.dart';

class OrdersController extends SuperController {
  var orderssData = [].obs;
  var pordersData = [].obs;
  void getOrders() async {
    Request request = Request(url: urlMyOrders, body: null);
    request.postAuth().then((value) async {
      if (value['status']) {
        OrderssListModel ordersListModel = OrderssListModel.fromJson(value);
        orderssData.value = ordersListModel.data!;

        PreviousOrderssListModel pordersListModel = PreviousOrderssListModel.fromJson(value);
        pordersData.value = pordersListModel.data!;
      } 
    }).catchError((onError) {
    });
  }

  @override
  void onInit() {
    getOrders();
    super.onInit();
  }

  List<Widget> createSliders() {
    List<Widget> imageSliders = pordersData.asMap().entries.map((item) {
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
                    item.value.rateAvg,
                    item.value.id
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
                    item.value.rateAvg,
                    item.value.id
                  ]
                );
              }
              
              getOrders();
            },
            child: Container(
              padding:  EdgeInsets.only(bottom: sizeH20),
              decoration:   BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: item.key == pordersData.length - 1?whitecolor: grey5),
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

  List<Widget> createOrders() {
    List<Widget> imageSliders = orderssData.asMap().entries.map((item) {
      return Column(
        children: [
          GestureDetector(
            onTap: ()async{
              if(getStatus(item.value.status) == 'Out for delivery'){
                await Get.to(()=> ShowOrderView(
                  type : getStatus(item.value.status),
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
                    item.value.delegate['latitude'],item.value.delegate['longitude'],
                    item.value.type == 'order'? item.value.address['latitude']:item.value.fromAddress['latitude'],
                    item.value.type == 'order'? item.value.address['longitude']:item.value.toAddress['longitude'],
                    getStatus(item.value.status),
                    item.value.rateAvg,
                    item.value.id
                  ]
                );
              }else{
                await Get.to(()=> ShowOrderView(
                  type : getStatus(item.value.status),
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
                    getStatus(item.value.status),
                    item.value.rateAvg,
                    item.value.id
                  ]
                );
              }
              
              getOrders();
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

  List<Widget> createNotfys() {
    List<Widget> imageSliders = orderssData.asMap().entries.map((item) {
      return Column(
        children: [
          Container(
            width: Get.width / 1,
            padding: EdgeInsets.all(sizeW15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(sizeW15),
              color:  Colors.white,
              border: Border.all(color: primaryColor)
            ),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: Get.width /3.3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${'Order ID'.tr} ${item.value.code}',style: TextStyle(color: primaryColor,fontSize: sizeW14,fontWeight: FontWeight.w600),),
                      Text(item.value.storeName != 'null'&& item.value.storeName != ''? item.value.storeName:'Deliver Package'.tr,
                              style: TextStyle(color: primaryColor,fontSize: sizeW14,fontWeight: FontWeight.w600,height: 1.3),),
                      Text(item.value.date,style: TextStyle(color: primaryColor,fontSize: sizeW12,fontWeight: FontWeight.w400,height: 1.3),),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: sizeW10,left: sizeH5,top: sizeH15),
                  child: Column(
                    children: [
                      SizedBox(
                        width: sizeW15,
                        height: sizeH80,
                        child: Column(
                          children: [
                            CircleAvatar(
                              maxRadius: sizeW5,
                              minRadius: sizeW5,
                              backgroundColor: primaryColor,
                            ),
                            SizedBox(height: sizeH2,),
                            Container(
                              width: 1.5,
                              height: sizeH65,
                              color: primaryColor,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: sizeW15,
                        height: sizeH80,
                        child: Column(
                          children: [
                            CircleAvatar(
                              maxRadius: sizeW5,
                              minRadius: sizeW5,
                              backgroundColor: primaryColor,
                            ),
                            SizedBox(height: sizeH2,),
                            Container(
                              width: 1.5,
                              height: sizeH65,
                              color: primaryColor,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: sizeW15,
                        height: sizeH100,
                        child: Column(
                          children: [
                            CircleAvatar(
                              maxRadius: sizeW5,
                              minRadius: sizeW5,
                              backgroundColor: primaryColor,
                            ),
                            SizedBox(height: sizeH2,),
                            Container(
                              width: 1.5,
                              height: sizeH50,
                              color: primaryColor,
                            ),
                            SizedBox(height: sizeH2,),
                            Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(sizeW45),
                                color:  primaryColor.withOpacity(.2),
                              ),
                              child: CircleAvatar(
                                maxRadius: sizeW5,
                                minRadius: sizeW5,
                                backgroundColor: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                    ],
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      width: Get.width /2.5,
                      child: Row(
                        children: [
                          FadeInDown(child:Image.asset('assets/icons/Frame 1261.png',width: sizeW45,height: sizeW45,fit: BoxFit.fill,),),
                          SizedBox(width: sizeW5,),
                          SizedBox(
                            width: Get.width /3.9,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Order is placed',style: TextStyle(color: greyOpacityColor,fontSize: sizeW16,fontWeight: FontWeight.w600),),
                                SizedBox(height: sizeH2,),
                                Text('9:12 pm',style: TextStyle(color: greyOpacityColor,fontSize: sizeW14,fontWeight: FontWeight.w300),),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: sizeH25,),
                    SizedBox(
                      width: Get.width /2.5,
                      child: Row(
                        children: [
                          FadeInDown(child:Image.asset('assets/icons/Frame 93.png',width: sizeW45,height: sizeW45,fit: BoxFit.fill,),),
                          SizedBox(width: sizeW5,),
                          SizedBox(
                            width: Get.width /3.9,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Order is preparing',style: TextStyle(color: greyOpacityColor,fontSize: sizeW16,fontWeight: FontWeight.w600),),
                                SizedBox(height: sizeH2,),
                                Text('9:12 pm',style: TextStyle(color: greyOpacityColor,fontSize: sizeW14,fontWeight: FontWeight.w300),),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: sizeH25,),
                    SizedBox(
                      width: Get.width /2.5,
                      child: Row(
                        children: [
                          FadeInDown(child:Image.asset('assets/icons/Asset 1-8 1.png',width: sizeW45,height: sizeW45,fit: BoxFit.fill,),),
                          SizedBox(width: sizeW5,),
                          SizedBox(
                            width: Get.width /3.9,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Order is prepared',style: TextStyle(color: greyOpacityColor,fontSize: sizeW16,fontWeight: FontWeight.w600),),
                                SizedBox(height: sizeH2,),
                                Text('9:12 pm',style: TextStyle(color: greyOpacityColor,fontSize: sizeW14,fontWeight: FontWeight.w300),),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: sizeH25,),
                    SizedBox(
                      width: Get.width /2.5,
                      child: Row(
                        children: [
                          FadeInDown(child:Image.asset('assets/icons/Asset 4-88 1.png',width: sizeW45,height: sizeW45,fit: BoxFit.fill,),),
                          SizedBox(width: sizeW5,),
                          SizedBox(
                            width: Get.width /3.9,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Order is out for delivery',style: TextStyle(color: greyOpacityColor,fontSize: sizeW16,fontWeight: FontWeight.w600),),
                                SizedBox(height: sizeH2,),
                                Text('9:12 pm',style: TextStyle(color: greyOpacityColor,fontSize: sizeW14,fontWeight: FontWeight.w300),),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: sizeH20,),
        ],
      );
    }).toList();
    return imageSliders;
  }

  @override
  void onDetached() {
    // getOrders();
  }

  @override
  void onInactive() {
    // getOrders();
  }

  @override
  void onPaused() {
    // getOrders();
  }

  @override
  void onResumed() {
    // getOrders();
  }

  @override
  void onClose() {
    // getOrders();
    super.onClose();
  }

  @override
  void onHidden() {
    // TODO: implement onHidden
  }
}
