import 'package:animate_do/animate_do.dart';
import 'package:birdandroid/utility/General.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../../../../constance.dart';
import '../../../../http/request.dart';
import '../../../../http/url.dart';
import '../../../../model/orders_list_model.dart';
import '../../../controller/driver_isorder_controller.dart';
import '../../user/drivers/is_order_view_first.dart';

class DeriverOrdersController extends SuperController {
  var orderssData = [].obs;
  void getOrders() async {
    var data = {
      'latitude' : General.latitude,
      'longitude' : General.longitude,
    };
    Request request = Request(url: urlDeriverOrders, body: data);
    request.postAuth().then((value) async {
      if (value['status']) {
        OrderssListModel ordersListModel = OrderssListModel.fromJson(value);
        orderssData.value = ordersListModel.data!;
      } 
    }).catchError((onError) {
    });
  }

  @override
  void onInit() {
    if(General.token != ''){
      getOrders();
    }
    super.onInit();
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
      calculateDistance(General.latitude,General.longitude,item.value.fromLatitude,item.value.fromLongitude);
      calculateDistance2(item.value.fromLatitude,item.value.fromLongitude,item.value.toLatitude,item.value.toLongitude);
      return Column(
        children: [
          Container(
            padding:  EdgeInsets.all(sizeH15),
            margin: EdgeInsets.only(right: sizeW5,left: sizeW5),
            decoration:   BoxDecoration(
              color: whitecolor,
              borderRadius: BorderRadius.circular(sizeW15),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color:  const Color.fromARGB(31, 153, 152, 152).withOpacity(0.2),
                  offset:  const Offset(0, 0),
                  blurRadius: 10.0,
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                item.value.storeLogo != 'null' && item.value.storeLogo != ''?
                FadeInDown(
                  child:Container(
                    width: sizeW35,height: sizeW35,
                    decoration:   BoxDecoration(
                      color: whitecolor,
                      borderRadius: BorderRadius.circular(sizeW65),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color:  const Color.fromARGB(31, 153, 152, 152).withOpacity(0.2),
                          offset:  const Offset(0, 0),
                          blurRadius: 10.0,
                        )
                      ],
                      image: DecorationImage(image: NetworkImage(item.value.storeLogo,))
                    ),
                  ),
                ):
                FadeInDown(child:Container(
                  width: sizeW35,height: sizeW35,
                  decoration:   BoxDecoration(
                    color: whitecolor,
                    borderRadius: BorderRadius.circular(sizeW65),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color:  const Color.fromARGB(31, 153, 152, 152).withOpacity(0.2),
                        offset:  const Offset(0, 0),
                        blurRadius: 10.0,
                      )
                    ],
                    image: const DecorationImage(image: AssetImage('assets/logo2.png'))
                  ),
                ),),
                SizedBox(width: sizeW10,),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        children: [
                          Image.asset("assets/marker.png",width: sizeW10,height: sizeW20,color: primaryColor,),
                          SizedBox(width: sizeW5,),
                          Text(
                            item.value.storeName != 'null'&& item.value.storeName != ''? 
                            '${'from'.tr} : ${item.value.storeName}'
                            :'${'from'.tr} : ${'addres'.tr}',
                            style: TextStyle(color: primaryColor,fontSize: sizeW16,fontWeight: FontWeight.w600),),
                          SizedBox(width: sizeW5,),
                          Text(
                            '(${oneKm.value.toStringAsFixed(2)}${'km'.tr})',
                            style: TextStyle(color: primaryColor,fontSize: sizeW14,fontWeight: FontWeight.w300),),
                          SizedBox(width: sizeW5,),
                          Text('${oneMins.value.toStringAsFixed(2)} ${'mins'.tr}',style: TextStyle(color: primaryColor,fontSize: sizeW14,fontWeight: FontWeight.w300),),
                        ],
                      ),
                      SizedBox(height: sizeH2,),
                      Wrap(
                        children: [
                          Image.asset("assets/marker.png",width: sizeW10,height: sizeW20,color: primaryColor,),
                          SizedBox(width: sizeW5,),
                          Text(
                            item.value.storeName != 'null'&& item.value.storeName != ''? 
                            '${'to'.tr} : ${'addres'.tr}'
                            :'${'to'.tr} : ${'addres'.tr}',
                            style: TextStyle(color: primaryColor,fontSize: sizeW16,fontWeight: FontWeight.w600),),
                          SizedBox(width: sizeW5,),
                          Text('(${towKm.value.toStringAsFixed(2)}${'km'.tr})',style: TextStyle(color: primaryColor,fontSize: sizeW14,fontWeight: FontWeight.w300),),
                          SizedBox(width: sizeW5,),
                          Text('${towMins.value.toStringAsFixed(2)} ${'mins'.tr}',style: TextStyle(color: primaryColor,fontSize: sizeW14,fontWeight: FontWeight.w300),),
                        ],
                      ),
                      SizedBox(height: sizeH2,),
                      item.value.items.length > 0?
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${'order'.tr} : ',style: TextStyle(color: primaryColor,fontSize: sizeW16,fontWeight: FontWeight.w600),),
                              SizedBox(
                                width: Get.width / 2,
                                child: Text('${item.value.itemsText}',style: TextStyle(color: greyOpacityColor,fontSize: sizeW12,fontWeight: FontWeight.w300),)),
                            ],
                          ),
                          
                        ],
                      ):Container(),
                      SizedBox(height: sizeH2,),
                      Text('${'total'.tr} : ${item.value.total} ${'SAR'.tr}',style: TextStyle(color: primaryColor,fontSize: sizeW16,fontWeight: FontWeight.w600),),
                      
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: sizeH10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MaterialButton(
                elevation: 0,
                color: primaryColor,
                minWidth: Get.width / 2.3,
                height: sizeH40,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(sizeW45),
                ),
                onPressed: (){
                  acceptOrder(item.value.id);
                },
                child: Text(
                  'Accept'.tr,
                  style:  TextStyle(
                    fontSize: sizeW22,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              MaterialButton(
                elevation: 0,
                color: whitecolor,
                minWidth: Get.width / 2.3,
                height: sizeH40,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(sizeW45),
                  side: const BorderSide(color: primaryColor)
                ),
                
                onPressed: (){
                  declineOrder(item.value.id);
                },
                child: Text(
                  'Decline'.tr,
                  style:  TextStyle(
                    fontSize: sizeW22,
                    color: primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: sizeH10,),
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

  declineOrder(orderId) async {
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
    var data = {'order_id':orderId};
    Request request = Request(url: urlDeclineOrder, body: data);
    request.postAuth().then((value) async {
      if (value['status']) {
        getOrders();
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
      Get.back();
    }).catchError((onError) {
      Get.back();
    });
  }

  acceptOrder(orderId) async {
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
    var data = {'order_id':orderId};
    Request request = Request(url: urlAcceptOrder, body: data);
    request.postAuth().then((value) async {
      if (value['status']) {
        final DriverIsOrderCountController isOrdercontroller = Get.put(DriverIsOrderCountController());
        General().setOrder(true);
        General().getOrder().then((value){
          isOrdercontroller.isOrder.value = true;
          Get.to(()=> IsOrderViewFirst(order: value['data'],),arguments: [value['data']]);
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
      Get.back();
    }).catchError((onError) {
      Get.back();
    });
  }

  

  @override
  void onDetached() {
    getOrders();
  }

  @override
  void onInactive() {
    getOrders();
  }

  @override
  void onPaused() {
    getOrders();
  }

  @override
  void onResumed() {
    getOrders();
  }

  @override
  void onClose() {
    getOrders();
    super.onClose();
  }

  @override
  void onHidden() {
    // TODO: implement onHidden
  }
}
