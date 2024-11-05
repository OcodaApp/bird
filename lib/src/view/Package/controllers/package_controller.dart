

// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_picker/map_picker.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';
import '../../../../constance.dart';
import '../../../../http/request.dart';
import '../../../../http/url.dart';
import '../../../../model/address_list_model.dart';
import '../../../../utility/General.dart';
import '../../Settings/thank_view.dart';
import '../add_location.dart';
import 'package_addlocation_controller.dart';
import 'package:flutter_paytabs_bridge/BaseBillingShippingInfo.dart';
import 'package:flutter_paytabs_bridge/IOSThemeConfiguration.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkApms.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkConfigurationDetails.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkTokeniseType.dart';
import 'package:flutter_paytabs_bridge/flutter_paytabs_bridge.dart';
import '../../../../utility/Address.dart' as address;

class PackageController extends GetxController {
  final pageIndexNotifier = ValueNotifier(0);
  LatLng startLocation =  LatLng(General.latitude, General.longitude); 
  var textController = TextEditingController();
  List predictions = [];
  late GoogleMapController mapController;
  MapPickerController mapPickerController = MapPickerController();
  CameraPosition cameraPosition =   CameraPosition(
    target: LatLng(General.latitude, General.longitude),
    zoom: 14.4746,
  );

  late TextEditingController packageText= TextEditingController();
  late TextEditingController notes= TextEditingController();
  late TextEditingController coupon= TextEditingController();
  var fromAddresId= 0.obs;
  var fromAddressText= ''.obs;
  var fromlocationName= ''.obs;
  var fromstreet= ''.obs;
  var fromcity= ''.obs;
  var frombuilding= ''.obs;
  var fromflat= ''.obs;
  var fromfloor= ''.obs;
  var fromlat= ''.obs;
  var fromlong= ''.obs;

  var toAddresId= 0.obs;
  var toAddressText= ''.obs;
  var tolocationName= ''.obs;
  var tostreet= ''.obs;
  var tocity= ''.obs;
  var tobuilding= ''.obs;
  var toflat= ''.obs;
  var tofloor= ''.obs;
  var tolat= ''.obs;
  var tolong= ''.obs;

  var isPackageText = false.obs;
  var isFromId = false.obs;
  var isToId = false.obs;

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
      // mainContentSlivers: ,
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
              height: Get.height /1.8,
              child: ListView(
                children: [
                  Obx(() => Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: addrssData.isNotEmpty? createSliders():[
                      Center(child: Text('no address add'.tr),)
                    ],
                  ),),
                  GestureDetector(
                    onTap: (){
                      PackageAddLocationController placeController = Get.put(PackageAddLocationController());
                      placeController.getCurrentLocation().then((res) {
                        General().getlatitude();
                        General().getlongitude();
                        General().getUserData().then((val)async{
                          var res =  await Get.to(()=>PackageAddLocation(lat: General.latitude,long: General.longitude,));

                          getAddressUser();
                          fromAddresId.value= int.parse(res);
                        });
                      });
                    },
                    child: Container(
                        height: sizeH75,
                        width: double.infinity,
                        padding:  EdgeInsets.only(right: sizeW15,left: sizeW15,top: sizeH10,bottom: sizeH10),
                        margin:  EdgeInsets.all(sizeW5),
                        decoration:  BoxDecoration(
                            color: Colors.white,
                            borderRadius:  BorderRadius.all(
                              Radius.circular(sizeW45),
                            ),
                            border: Border.all(color: grey3)
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/gps.png",
                              color: greyOpacityColor,
                              width: sizeW16,
                              height: sizeH25,
                            ),
                            SizedBox(width: sizeW15,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Deliver to a different location'.tr,
                                  style: TextStyle(fontSize: sizeW14,fontWeight: FontWeight.w600,color: greyOpacityColor),
                                ),
                                SizedBox(height: sizeH5,),
                                Text(
                                  'Choose location on map'.tr,
                                  style: TextStyle(fontSize: sizeW14,fontWeight: FontWeight.w400,color: greyOpacityColor),
                                ),
                              ],
                            ),
                          ],
                        )
                    ),
                  ),
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
                  fromAddresId.value = addressChoose['id'];
                  fromAddressText.value = addressChoose['addres_text'];
                  fromlocationName.value = addressChoose['location_name'];
                  fromstreet.value = addressChoose['street'];
                  fromcity.value = addressChoose['city'];
                  frombuilding.value = addressChoose['building'];
                  fromflat.value = addressChoose['flat'];
                  fromfloor.value = addressChoose['floor'];
                  fromlat.value = addressChoose['latitude'];
                  fromlong.value = addressChoose['longitude'];
                  isFromId.value = true;
                  if(isToId.value && isFromId.value){
                    calculateDistance(double.parse(fromlat.value),double.parse(fromlong.value),
                        double.parse(tolat.value),double.parse(tolong.value));
                  }
                  Get.back();
                  FocusManager.instance.primaryFocus?.unfocus();
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
      ]
    );
  }

  page4(modalSheetContext) {
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
              height: Get.height /1.8,
              child: ListView(
                children: [
                  Obx(() => Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: addrssData.isNotEmpty? createSliders4():[
                      Center(child: Text('no address add'.tr),)
                    ],
                  ),),
                  GestureDetector(
                    onTap: (){
                      PackageAddLocationController placeController = Get.put(PackageAddLocationController());
                      placeController.getCurrentLocation().then((res) {
                        General().getlatitude();
                        General().getlongitude();
                        General().getUserData().then((val)async{
                          var res =  await Get.to(()=>PackageAddLocation(lat: General.latitude,long: General.longitude,));
                          getAddressUser();
                          toAddresId.value= int.parse(res.toString());
                        });
                      });
                    },
                    child: Container(
                      height: sizeH75,
                      width: double.infinity,
                      padding:  EdgeInsets.only(right: sizeW15,left: sizeW15,top: sizeH10,bottom: sizeH10),
                      margin:  EdgeInsets.all(sizeW5),
                      decoration:  BoxDecoration(
                        color: Colors.white,
                        borderRadius:  BorderRadius.all(
                          Radius.circular(sizeW45),
                        ),
                        border: Border.all(color: grey3)
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/gps.png",
                            color: greyOpacityColor,
                            width: sizeW16,
                            height: sizeH25,
                          ),
                          SizedBox(width: sizeW15,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Deliver to a different location'.tr,
                                style: TextStyle(fontSize: sizeW14,fontWeight: FontWeight.w600,color: greyOpacityColor),
                              ),
                              SizedBox(height: sizeH5,),
                              Text(
                                'Choose location on map'.tr,
                                style: TextStyle(fontSize: sizeW14,fontWeight: FontWeight.w400,color: greyOpacityColor),
                              ),
                            ],
                          ),
                        ],
                      )
                    ),
                  ),
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
                  toAddresId.value = addressChoose['id'];
                  toAddressText.value = addressChoose['addres_text'];
                  tolocationName.value = addressChoose['location_name'];
                  tostreet.value = addressChoose['street'];
                  tocity.value = addressChoose['city'];
                  tobuilding.value = addressChoose['building'];
                  toflat.value = addressChoose['flat'];
                  tofloor.value = addressChoose['floor'];
                  tolat.value = addressChoose['latitude'];
                  tolong.value = addressChoose['longitude'];
                  isToId.value = true;
                  if(isToId.value && isFromId.value){
                    calculateDistance(double.parse(fromlat.value),double.parse(fromlong.value),
                    double.parse(tolat.value),double.parse(tolong.value));
                  }
                  
                  Get.back();
                  FocusManager.instance.primaryFocus?.unfocus();
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

  var addressChoose;


  List<Widget> createSliders() {
    List<Widget> imageSliders = addrssData.map((item) {
      return Container(
        margin:  EdgeInsets.only(bottom: sizeH10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: (){
                fromAddresId.value = item.id;
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
                  color:fromAddresId.value == item.id ?  const Color.fromARGB(255, 159, 160, 170).withOpacity(0.1):whitecolor,
                  borderRadius:  BorderRadius.all(
                    Radius.circular(sizeW45),
                  ),
                  border: Border.all(color: fromAddresId.value == item.id ? primaryColor:greyOpacityColor)
                ),
                
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "assets/marker.png",
                          color: fromAddresId.value == item.id ? primaryColor:greyOpacityColor,
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
                              style: TextStyle(fontSize: sizeW14,fontWeight: FontWeight.w600,color: fromAddresId.value == item.id ? primaryColor:greyOpacityColor),
                            ),
                            SizedBox(height: sizeH5,),
                            SizedBox(
                              width: Get.width / 2,
                              child: Text(
                                item.street,
                                style: TextStyle(fontSize: sizeW14,fontWeight: FontWeight.w400,color: fromAddresId.value == item.id ? primaryColor:greyOpacityColor,overflow:TextOverflow.ellipsis ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Obx(() => SizedBox(
                      width: sizeW20,
                      child: Radio(
                        value: fromAddresId.value,
                        groupValue: item.id,
                        activeColor: primaryColor,
                        onChanged: (value) {
                          fromAddresId.value = item.id;
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

  List<Widget> createSliders4() {
    List<Widget> imageSliders = addrssData.map((item2) {
      return Container(
        margin:  EdgeInsets.only(bottom: sizeH10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: (){
                toAddresId.value = item2.id;
                addressChoose = {
                  'id' : item2.id,
                  'location_name' : item2.title,
                  'addres_text' : item2.addressText,
                  'street' : item2.street,
                  'building' : item2.building,
                  'floor' : item2.floor,
                  'flat' : item2.flat,
                  'latitude' : item2.latitude,
                  'longitude' : item2.longitude,
                  'city' : item2.city,
                };
              },
              child: Container(
                height: sizeH75,
                width: double.infinity,
                padding:  EdgeInsets.only(right: sizeW15,left: sizeW15,top: sizeH10,bottom: sizeH10),
                margin:  EdgeInsets.all(sizeW5),
                decoration:  BoxDecoration(
                  color:toAddresId.value == item2.id ?  const Color.fromARGB(255, 159, 160, 170).withOpacity(0.1):whitecolor,
                  borderRadius:  BorderRadius.all(
                    Radius.circular(sizeW45),
                  ),
                  border: Border.all(color: toAddresId.value == item2.id ? primaryColor:greyOpacityColor)
                ),
                
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "assets/marker.png",
                          color: toAddresId.value == item2.id ? primaryColor:greyOpacityColor,
                          width: sizeW16,
                          height: sizeH18,
                        ),
                        SizedBox(width: sizeW15,),
                         Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item2.title,
                              style: TextStyle(fontSize: sizeW14,fontWeight: FontWeight.w600,color: toAddresId.value == item2.id ? primaryColor:greyOpacityColor),
                            ),
                            SizedBox(height: sizeH5,),
                            SizedBox(
                              width: Get.width / 2,
                              child: Text(
                                item2.street,
                                style: TextStyle(fontSize: sizeW14,fontWeight: FontWeight.w400,color: toAddresId.value == item2.id ? primaryColor:greyOpacityColor,overflow:TextOverflow.ellipsis ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Obx(() => SizedBox(
                      width: sizeW20,
                      child: Radio(
                        value: toAddresId.value,
                        groupValue: item2.id,
                        activeColor: primaryColor,
                        onChanged: (value) {
                          toAddresId.value = item2.id;
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
  @override
  void onInit() {
    getSettingServiceKm();
    getAddressUser();
    super.onInit();
  }

  var km = ''.obs;
  var timeD = ''.obs;

  calculateDistance(lat1, lon1, lat2, lon2)async{
    var distanceInMeters =  Geolocator.distanceBetween(
      lat1,
      lon1,
      lat2,
      lon2,
    );
    // var p = 0.017453292519943295;
    // var c = cos;
    // var a = 0.5 - c((lat2 - lat1) * p)/2 + 
    //       c(lat1 * p) * c(lat2 * p) * 
    //       (1 - c((lon2 - lon1) * p))/2;
    km.value = distanceInMeters.toStringAsFixed(2);
    timeD.value = distanceInMeters.toStringAsFixed(2);
    total.value = (((double.parse(km.value) * double.parse(kmPrice.value)) + double.parse(servicePrice.value))- salePrice.value).toStringAsFixed(2);
    return distanceInMeters;
  }

  var kmPrice = '0'.obs;
  var servicePrice = '0'.obs;
  var total = '0'.obs;
  var couponId= '0'.obs;
  var salePrice= 0.0.obs;
  var sale= 0.obs;



  void getSettingServiceKm() async {
    Request request = Request(url: urlGetKmPrice, body: null);
    request.get().then((value) async {
      if (value['status']) {
        kmPrice.value = value['data']['km_price'].toString();
        servicePrice.value = value['data']['service_price'].toString();
      } else {
      }
    }).catchError((onError) {
    });
  }
  var paymethod = 1.obs;

  var couponText = ''.obs;
  var isCoupon = false.obs;

  checkCoupon(context) async {
    var data = {
      'coupon' : couponText.value,
      'total' : (double.parse(km.value) * double.parse(kmPrice.value)),
      'delivery_total' : (double.parse(km.value) * double.parse(kmPrice.value)),
    };
    Request request = Request(url: urlCheckCoupns, body: data);
    request.postAuth().then((value) async {
      if (value['status']) {
        salePrice.value= double.parse(value['sale_price'].toString());
        sale.value= value['sale'];
        couponId.value= value['promo_id'].toString();
        if(isToId.value && isFromId.value){
          calculateDistance(double.parse(fromlat.value),double.parse(fromlong.value),
          double.parse(tolat.value),double.parse(tolong.value));
        }
        isCoupon.value = true;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(value['msg'])));
      }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(value['msg'])));
        isCoupon.value = false;
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
      'package' : packageText.text,
      'from_address_id' : fromAddresId.value,
      'to_address_id' : toAddresId.value,
      'from_latitude' : fromlat.value,
      'from_longitude' : fromlong.value,
      'to_latitude' : tolat.value,
      'to_longitude' : tolong.value,
      'service_price' : servicePrice.value,
      'note' : notes.text,
      'delivery_total' : (double.parse(km.value) * double.parse(kmPrice.value)),
      'time' : km.value,
      'km' : km.value,
      'total' : total.value,
      'sale_total' : salePrice.value,
      'sale' : sale.value,
      // 'transaction_id' : '',
      // 'pay_data' : '',
    };
    if(couponId.value != '0'){
      data.addAll({'coupon_id' : couponId.value});
    }

    if(paymethod.value == 1){
      data.addAll({'pay_method' : 'visa','pay' : 'yes'});
    }
    if(paymethod.value == 2){
      data.addAll({'pay_method' : 'cash','pay' : 'no'});
    }
    if(paymethod.value == 3){
      data.addAll({'pay_method' : 'wallet','pay' : 'yes'});
    }
    Request request = Request(url: urlPostDeliveryService, body: data);
    request.postAuth().then((value) {
      Get.back();
      if (value['status']) {
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

  var rng = Random();
  PaymentSdkConfigurationDetails generateConfig() {
  var billingDetails = BillingDetails(General.username, General.email,
      General.mobile, address.Address.a_street, "sa", address.Address.a_city, address.Address.a_city, "12345");
  var shippingDetails = ShippingDetails(General.username, General.email,
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
      amount: double.parse(total.value),
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

  @override
  void onClose() {
    packageText.dispose();
    notes.dispose();
    coupon.dispose();
    super.onClose();
  }
}
