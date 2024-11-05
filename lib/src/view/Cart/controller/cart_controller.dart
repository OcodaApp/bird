import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../http/request.dart';
import '../../../../http/url.dart';
import '../../../../model/basket_list_modal.dart';
import '../../../../utility/Address.dart';

class CartController extends GetxController {
  late TextEditingController notes;
  late TextEditingController coupon;
  var count = 1.obs;
  var cart = false.obs;

  var basketStoreCount = 0.obs;
  var basketStoreTotal = 0.0.obs;
  var storeName = ''.obs;
  var isitems= false.obs;
  var basketsData = [].obs;


  var deliveryTotal= 0.0.obs;
  var servicePrice= 0.obs;
  var salePrice= 0.0.obs;
  var sale= 0.obs;
  var allTotal= 0.0.obs;
  var timeAll= 0.0.obs;
  var storeId= 0.obs;
  var couponId= '0'.obs;

  var isWait = false.obs;


  void getBaskets() async {
    var data = {
      'latitude' : Address.a_lat,
      'longitude' : Address.a_long,
    };
    Request request = Request(url: urlGetBaskets, body: data);
    request.postAuth().then((value) async {
      if (value['status']) {
        isWait.value = false;
        BasketsListModel basketsListModel = BasketsListModel.fromJson(value);
        basketsData.value = basketsListModel.basket!;
        if(basketsData.isNotEmpty){
          isitems.value = true;
          // basketStoreCount.value = int.parse(value['count']);
          basketStoreTotal.value = double.parse(value['total'].toString());
          allTotal.value = double.parse(value['all_total'].toString());
          storeName.value = value['storeName'];
          deliveryTotal.value = double.parse(value['delivery_total'].toString());
          servicePrice.value = int.parse(value['service_price'].toString());
          salePrice.value = double.parse(value['sale_price'].toString());
          timeAll.value = double.parse(value['time_all'].toString());
          storeId.value = int.parse(value['store_id']);
        }else{
          isitems.value = false;
        }
      } 
    }).catchError((onError) {
    });
  }

  var couponText = ''.obs;
  var isCoupon = false.obs;

  checkCoupon(context) async {
    var data = {
      'coupon' : couponText.value,
      'total' : allTotal.value,
      'delivery_total' : deliveryTotal.value,
    };
    Request request = Request(url: urlCheckCoupns, body: data);
    request.postAuth().then((value) async {
      if (value['status']) {
        salePrice.value= double.parse(value['sale_price'].toString());
        sale.value= value['sale'];
        couponId.value= value['promo_id'].toString();
        allTotal.value = double.parse(value['total'].toString());
        isCoupon.value = true;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(value['msg'])));
      }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(value['msg'])));
        isCoupon.value = false;
      }
    }).catchError((onError) {
    });
  }

  void editItem(data,count) async {
    isWait.value = true;
    Request request;
    if(count > 0){
      request = Request(url: urlEditItem, body: data);
    }else{
      request = Request(url: urlDeletItem, body: data);
    }
    
    request.postAuth().then((value) async {
      if (value['status']) {
        getBaskets();
      } 
    }).catchError((onError) {
    });
  }

  void deleteItem(data) async {
    isWait.value = true;
    Request request = Request(url: urlDeletItem, body: data);
    request.postAuth().then((value) async {
      if (value['status']) {
        getBaskets();
      } 
    }).catchError((onError) {
    });
  }

  @override
  void onInit() {
    getBaskets();
    notes = TextEditingController();
    coupon = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    notes.dispose();
    coupon.dispose();
    super.onClose();
  }
}
