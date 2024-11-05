// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_paytabs_bridge/BaseBillingShippingInfo.dart';
import 'package:flutter_paytabs_bridge/IOSThemeConfiguration.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkApms.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkConfigurationDetails.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkTokeniseType.dart';
import 'package:flutter_paytabs_bridge/flutter_paytabs_bridge.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';
import '../../../../utility/Address.dart' as address;
import '../../../../constance.dart';
import '../../../../http/request.dart';
import '../../../../http/url.dart';
import '../../../../model/address_list_model.dart';
import '../../../../utility/General.dart';
import '../../../controller/cart_count_controller.dart';
import '../../Settings/thank_view.dart';

class CheckOutController extends GetxController {
  var paymethod = 1.obs;
  var basketStoreCount = 0.obs;
  var basketStoreTotal = 0.0.obs;
  var deliveryTotal= 0.0.obs;
  var servicePrice= 0.obs;
  var salePrice= 0.0.obs;
  var sale= 0.obs;
  var couponId= '0'.obs;
  var allTotal= 0.0.obs;
  var timeAll= 0.0.obs;
  var itemsCount= 0.obs;
  var notes= ''.obs;
  var storeId= 0.obs;
  final pageIndexNotifier = ValueNotifier(0);
  var isDataAddress = false.obs;
  var addrssData = [].obs;
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

  void postOrder() async {
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
      'store_id' : storeId.value,
      'address_id' : addrssId.value,
      // 'transaction_id' : '',
      'note' : notes.value,
      // 'pay_data' : '',
      'delivery_total' : deliveryTotal.value,
      'service_price' : servicePrice.value,
      'sale_total' : salePrice.value,
      'sale' : sale.value,
      'total' : allTotal.value,
      'items_total' : basketStoreTotal.value,
      'time' : timeAll.value,
    };

    if(couponId.value != '0'){
      data.addAll({'coupon_id' : couponId.value});
    }
    if(paymethod.value == 1){
      data.addAll({'pay_method' : 'visa','pay' : pay.value,'transaction_id':transactionId.value});
    }
    if(paymethod.value == 2){
      data.addAll({'pay_method' : 'cash','pay' : 'no'});
    }
    if(paymethod.value == 3){
      data.addAll({'pay_method' : 'wallet','pay' : 'yes'});
    }
    Request request = Request(url: urlPostOrder, body: data);
    request.postAuth().then((value) {
      Get.back();
      if (value['status']) {
        final CartCountController cartCountcontroller = Get.put(CartCountController());
        cartCountcontroller.cartCoynt.value = 0;
        Get.offAll(()=>const ThankView());
        
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

  var addrssId = 0.obs;
  

  

  @override
  void onInit() {
    basketStoreCount.value =Get.arguments[2];
    basketStoreTotal.value = Get.arguments[3];
    deliveryTotal.value= Get.arguments[4];
    servicePrice.value=Get.arguments[5];
    salePrice.value=double.parse(Get.arguments[6].toString());
    allTotal.value= Get.arguments[7];
    timeAll.value= Get.arguments[8];
    itemsCount.value= Get.arguments[9];
    notes.value= Get.arguments[10];
    storeId.value = Get.arguments[11];
    sale.value = Get.arguments[12];
    couponId.value = Get.arguments[13];
    addrssId.value = int.parse(address.Address.a_id);
    addrssName.value = address.Address.a_name;
    addrssStreet.value = address.Address.a_street;
    super.onInit();
  }

  page3(modalSheetContext) {
    return SliverWoltModalSheetPage(
      isTopBarLayerAlwaysVisible: true,
      hasTopBarLayer : true,
      topBarTitle: Text('location'.tr.tr,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: primaryColor),),
      trailingNavBarWidget: IconButton(
        padding:  EdgeInsets.all(sizeW10),
        icon: Icon(Icons.close,color: const Color.fromARGB(255, 153, 152, 152),size: sizeW15,),
        onPressed: () {
          Navigator.of(modalSheetContext).pop();
          pageIndexNotifier.value = 0;
        },
      ),
      mainContentSliversBuilder: (_)=>[
         SliverPadding(
          padding: EdgeInsets.all(sizeW10),
          sliver: const SliverToBoxAdapter(
          ),
        ),
        SliverPadding(
          padding:  EdgeInsets.all(sizeW10),
          sliver: SliverToBoxAdapter(
            child: SizedBox(
              height: Get.height /2,
              child: ListView(
                children: [
                  Obx(() => Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: addrssData.isNotEmpty? createSliders():[
                      Center(child: Text('no address add'.tr),)
                    ],
                  ),),
                ],
              ),
            ),
          ),
        ),
        SliverPadding(
          padding:  EdgeInsets.all(sizeW10),
          sliver: SliverToBoxAdapter(
            child: Container(
              padding:  EdgeInsets.all(sizeW10),
              color: Colors.white,
              child: MaterialButton(
                elevation: 0,
                color:  primaryColor,
                minWidth: Get.width / 1.1,
                height: sizeH50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(sizeW45),
                ),
                onPressed: (){
                  address.Address().setAddresId(addrssId.value.toString());
                  address.Address().getAddresId();
                  address.Address().setAddressData(addressChoose);
                  address.Address().getAddressData().then((vv){
                    addrssName.value = address.Address.a_name;
                    addrssStreet.value = address.Address.a_street;
                    Get.back();
                    FocusManager.instance.primaryFocus?.unfocus();
                  });
                },
                child:  Text(
                  'Confirm'.tr,
                  style:  TextStyle(
                    fontSize: sizeW22,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
  var addressChoose;
  var addrssName = ''.obs;
  var addrssStreet = ''.obs;
  List<Widget> createSliders() {
    List<Widget> imageSliders = addrssData.map((item) {
      return Container(
        margin:  EdgeInsets.only(right: sizeW15,left: sizeW15,bottom: sizeH10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: (){
                addrssId.value = item.id;
                addressChoose = {
                  'id' : item.id,
                  'location_name' : item.title,
                  'addres_text' : item.addressText,
                  'street' : item.street,
                  'building' : item.building,
                  'floor' : item.floor,
                  'flat' : item.flat,
                  'latitude' : item.latitude,
                  'longitude' : item.longitude,
                  'city' : item.city,
                };
              },
              child: Container(
                height: sizeH75,
                width: double.infinity,
                padding:  EdgeInsets.only(right: sizeW15,left: sizeW15,top: sizeH10,bottom: sizeH10),
                margin:  EdgeInsets.all(sizeW5),
                decoration:  BoxDecoration(
                  color:addrssId.value == item.id ?  const Color.fromARGB(255, 159, 160, 170).withOpacity(0.1):whitecolor,
                  borderRadius:  BorderRadius.all(
                    Radius.circular(sizeW45),
                  ),
                  border: Border.all(color: addrssId.value == item.id ? primaryColor:greyOpacityColor)
                ),
                
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "assets/marker.png",
                          color: addrssId.value == item.id ? primaryColor:greyOpacityColor,
                          width: 16,
                          height: 18,
                        ),
                        SizedBox(width: sizeW15,),
                         Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: TextStyle(fontSize: sizeW14,fontWeight: FontWeight.w600,color: addrssId.value == item.id ? primaryColor:greyOpacityColor),
                            ),
                            SizedBox(height: sizeH5,),
                            SizedBox(
                              width: Get.width / 2,
                              child: Text(
                                item.street,
                                style: TextStyle(fontSize: sizeW14,fontWeight: FontWeight.w400,color: addrssId.value == item.id ? primaryColor:greyOpacityColor,overflow:TextOverflow.ellipsis ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Obx(() => SizedBox(
                      width: sizeW20,
                      child: Radio(
                        value: addrssId.value,
                        groupValue: item.id,
                        activeColor: primaryColor,
                        onChanged: (value) {
                          addrssId.value = item.id;
                        },
                      ),
                    ),)
                  ],
                )
              ),
            ),
          ],
        ),
      );
    }).toList();
    return imageSliders;
  }

  var rng = Random();
  PaymentSdkConfigurationDetails generateConfig() {
  var billingDetails = BillingDetails(General.username, '${getRandomString(10)}@gmail.com',
      General.mobile, address.Address.a_street, "sa", address.Address.a_city, address.Address.a_city, "12345");
  var shippingDetails = ShippingDetails(General.username, '${getRandomString(10)}@gmail.com',
      General.mobile, address.Address.a_street, "sa", address.Address.a_city, address.Address.a_city, "12345");
  List<PaymentSdkAPms> apms = [];
  apms.add(PaymentSdkAPms.AMAN);
  final configuration = PaymentSdkConfigurationDetails(
      profileId: "109021",
      serverKey: "SMJNHNDLNL-JHT9JN9DD2-WT6LRLJHBZ",
      clientKey: "CTKM9D-NQNG6H-7P6QPD-RDH977",
      cartId: rng.nextInt(100).toString(),
      cartDescription: "Flowers",
      merchantName: "The bird sa",
      screentTitle: "payment".tr,
      amount: allTotal.value,
      showBillingInfo: false,
      forceShippingInfo: false,
      currencyCode: "SAR",
      merchantCountryCode: "SA",
      billingDetails: billingDetails,
      shippingDetails: shippingDetails,
      alternativePaymentMethods: apms,
      linkBillingNameWithCardHolderName: true,
    );
    final theme = IOSThemeConfigurations();
    theme.logoImage = "assets/logo.png";
    configuration.iOSThemeConfigurations = theme;
    configuration.tokeniseType = PaymentSdkTokeniseType.MERCHANT_MANDATORY;
    return configuration;
  }

  final _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  var pay= 'no'.obs;
  var transactionId = ''.obs;
  var payData = {};
  Future<void> payPressed() async {
    FlutterPaytabsBridge.startCardPayment(generateConfig(), (event) {
      if (event["status"] == "success") {
        var transactionDetails = event["data"];
        if (transactionDetails["isSuccess"]) {
          pay.value = 'yes';
          transactionId.value = event['data']['transactionReference'];
          // payData = event['data'];
          
          postOrder();
          if (transactionDetails["isPending"]) {
            Fluttertoast.showToast(
              msg: 'agien'.tr,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.redAccent,
              textColor: Colors.white,
              fontSize: sizeW14,
            );
          }
        } else {
          Fluttertoast.showToast(
            msg: 'agien'.tr,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.redAccent,
            textColor: Colors.white,
            fontSize: sizeW14,
          );

        }
      } else if (event["status"] == "error") {
        Fluttertoast.showToast(
          msg: 'agien'.tr,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: sizeW14,
        );
      } else if (event["status"] == "event") {
        Fluttertoast.showToast(
          msg: 'agien'.tr,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: sizeW14,
        );
      }
    });
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
