// ignore_for_file: must_be_immutable

import 'package:birdandroid/utility/General.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_picker/map_picker.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';
import '../../../constance.dart';
import 'controller/checkout_controller.dart';

class CheckOutView extends StatelessWidget {
   CheckOutView({Key? key}) : super(key: key);
  final CheckOutController controller = Get.put(CheckOutController());
  LatLng startLocation =  LatLng(Get.arguments[0], Get.arguments[1]); 
  var textController = TextEditingController();
  double? lat,long;
  List predictions = [];
  late GoogleMapController mapController;
  MapPickerController mapPickerController = MapPickerController();
  CameraPosition cameraPosition =   CameraPosition(
    target: LatLng(Get.arguments[0], Get.arguments[1]),
    zoom: 14.4746,
  );
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: Get.width,
        height: Get.height,
        padding :  EdgeInsets.all(sizeW20),
        color: Colors.white,
        child: ListView(
          children:  [
            FadeInRight(
              child:  Text('Check out'.tr,style: TextStyle(color: primaryColor,fontSize: sizeW20,fontWeight: FontWeight.w600),),
            ),
            SizedBox(height: sizeH15,),
            Text('Adress'.tr,style: TextStyle(color: primaryColor,fontSize: sizeW20,fontWeight: FontWeight.w600),),
            SizedBox(height: sizeH20,),

            Container(
              padding:  EdgeInsets.only(right: sizeW10,left: sizeW10,bottom: sizeH15,top: sizeH15),
              margin:  EdgeInsets.only(right: sizeW5,left: sizeW5),
              decoration:  BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(sizeW15),
                boxShadow: [
                  BoxShadow(
                    color:  const Color.fromARGB(31, 153, 152, 152).withOpacity(0.2),
                    blurRadius: 10,
                    offset:  const Offset(0, 0), // Shadow position
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    height: Get.height /4.8,
                    width: Get.width,
                    decoration:   BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(sizeW25),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius:  BorderRadius.all(
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
                            target: startLocation, //initial position
                            zoom: 14.0, //initial zoom level
                          ),
                          
                          onCameraMoveStarted: () {
                            mapPickerController.mapMoving!();
                            textController.text = "checking ...";
                          },
                          onCameraMove: (cameraPosition) {
                            this.cameraPosition = cameraPosition;
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: sizeH15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() => Row(
                        children: [
                          FadeInDown(child:Image.asset('assets/marker.png',width: sizeW22,height: sizeW25,fit: BoxFit.fill,color:  primaryColor),),
                          SizedBox(width: sizeW10,),
                          SizedBox(
                            width: Get.width / 1.8,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(controller.addrssName.value,style: TextStyle(color: primaryColor,fontSize: sizeW14,fontWeight: FontWeight.w600),),
                                SizedBox(
                                  child: Text(controller.addrssStreet.value,style: TextStyle(color: primaryColor,fontSize: sizeW14,fontWeight: FontWeight.w500),overflow: TextOverflow.ellipsis,)),
                              ],
                            ),
                          ),
                        ],
                      ),),
                      
                      GestureDetector(
                        onTap: (){
                          controller.getAddressUser();
                          WoltModalSheet.show<void>(
                            pageIndexNotifier: controller.pageIndexNotifier,
                            context: context,
                            pageListBuilder: (modalSheetContext) {
                              return [
                                controller.page3(modalSheetContext),
                              ];
                            },
                            modalTypeBuilder: (context) {
                              return WoltModalType.bottomSheet();
                            },
                            onModalDismissedWithBarrierTap: () {
                              Navigator.of(context).pop();
                              controller.pageIndexNotifier.value = 0;
                            },
                            // minPageHeight: 0.0,
                            // maxPageHeight: Get.height /2,
                          );
                        },
                        child: Text('Change'.tr,style: TextStyle(color: primaryColor,fontSize: sizeW14,fontWeight: FontWeight.w600),)),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: sizeH20,),
            Container(
              width: Get.width / 1,
              padding:  EdgeInsets.only(right: sizeW20,left: sizeW20,top: sizeH10,bottom: sizeH10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(sizeW45),
                color:   primaryColor.withOpacity(.1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      FadeInDown(child:Image.asset('assets/icons/flash.png',width: sizeW25,height: sizeW25,fit: BoxFit.fill,color:  primaryColor),),
                      SizedBox(width: sizeW10,),
                      Text(
                        'Estimated time'.tr,
                        style:  TextStyle(
                          fontSize: sizeW14,
                          color: primaryColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '${controller.timeAll.value.toStringAsFixed(2)} ${'mins'.tr}',
                    style:  TextStyle(
                      fontSize: sizeW14,
                      color: primaryColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: sizeH15,),

            Text('Payment method'.tr,style: TextStyle(color: primaryColor,fontSize: sizeW20,fontWeight: FontWeight.w600),),
            SizedBox(height: sizeH15,),
            GestureDetector(
              onTap: (){
                controller.paymethod.value = 1;
              },
              child: Container(
                width: Get.width / 1,
                padding:  EdgeInsets.only(right: sizeW20,left: sizeW20,top: sizeH5,bottom: sizeH5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(sizeW45),
                  color:  Colors.white,
                  border: Border.all(color:  grey3,width: 1)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        FadeInDown(child:Image.asset('assets/icons/card.png',width: sizeW25,height: sizeW25,fit: BoxFit.fill,color:  greyOpacityColor),),
                         SizedBox(width: sizeW10,),
                         Text(
                          'Different Credit/Debit Card'.tr,
                          style:  TextStyle(
                            fontSize: sizeW14,
                            color: greyOpacityColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Obx(() => SizedBox(
                      width: sizeW20,
                      child: Radio(
                        value: controller.paymethod.value,
                        groupValue: 1,
                        activeColor:  primaryColor,
                        onChanged: (value) {
                        },
                      ),
                    ),)
                  ],
                ),
              ),
            ),
            SizedBox(height: sizeH15,),
            GestureDetector(
              onTap: (){
                controller.paymethod.value = 2;
              },
              child: Container(
                width: Get.width / 1,
                padding:  EdgeInsets.only(right: sizeW20,left: sizeW20,top: sizeH5,bottom: sizeH5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(sizeW45),
                  color:  Colors.white,
                  border: Border.all(color:  grey3,width: 1)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        FadeInDown(child:Image.asset('assets/icons/moneys.png',width: sizeW25,height: sizeW25,fit: BoxFit.fill,color:  greyOpacityColor),),
                         SizedBox(width: sizeW10,),
                         Text(
                          'cash payment'.tr,
                          style:  TextStyle(
                            fontSize: sizeW14,
                            color: greyOpacityColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Obx(() => SizedBox(
                      width: sizeW20,
                      child: Radio(
                        value: controller.paymethod.value,
                        groupValue: 2,
                        activeColor:  primaryColor,
                        onChanged: (value) {
                        },
                      ),
                    ),),
                  ],
                ),
              ),
            ),
            SizedBox(height: General.walletCount > controller.allTotal.value?sizeH15:0,),
            General.walletCount > controller.allTotal.value? GestureDetector(
              onTap: (){
                controller.paymethod.value = 3;
              },
              child: Container(
                width: Get.width / 1,
                padding:  EdgeInsets.only(right: sizeW20,left: sizeW20,top: sizeH5,bottom: sizeH5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(sizeW45),
                  color:  Colors.white,
                  border: Border.all(color:  grey3,width: 1)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        FadeInDown(child:Image.asset('assets/icons/moneys.png',width: sizeW25,height: sizeW25,fit: BoxFit.fill,color:  greyOpacityColor),),
                         SizedBox(width: sizeW10,),
                         Text(
                          'wallet'.tr,
                          style:  TextStyle(
                            fontSize: sizeW14,
                            color: greyOpacityColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Obx(() => SizedBox(
                      width: sizeW20,
                      child: Radio(
                        value: controller.paymethod.value,
                        groupValue: 3,
                        activeColor:  primaryColor,
                        onChanged: (value) {
                        },
                      ),
                    ),),
                  ],
                ),
              ),
            ):Container(),
            SizedBox(height: sizeH15,),
            
            Row(
              children: [
                Text('Payment Summary'.tr,style: TextStyle(fontSize: sizeW18,fontWeight: FontWeight.w600,color: primaryColor),),
              ],
            ),
            SizedBox(height: sizeH15,),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Sub Total'.tr,style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w400,color: greyOpacityColor)),
                    Text('${controller.basketStoreTotal.value.toString()} ${'SAR'.tr}',style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w500,color: blackolor)),
                    
                  ],
                ),
                SizedBox(height: sizeH5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Delivery fee'.tr,style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w400,color: greyOpacityColor)),
                    Text('${controller.deliveryTotal.value.toString()} ${'SAR'.tr}',style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w500,color: blackolor)),
                  ],
                ),
                SizedBox(height: sizeH5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Service fees'.tr,style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w400,color: greyOpacityColor)),
                    Text('${controller.servicePrice.value.toString()} ${'SAR'.tr}',style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w500,color: blackolor)),
                  ],
                ),
                SizedBox(height: sizeH5,),
                controller.salePrice.value > 0 ?Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Discount'.tr,style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w400,color: greyOpacityColor)),
                    Text('-${controller.salePrice.value.toString()} ${'SAR'.tr}',style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w500,color: Colors.red)),
                  ],
                ):Container(),
                SizedBox(height: controller.salePrice.value > 0 ?sizeH15:0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total amount'.tr,style: TextStyle(fontSize: sizeW18,fontWeight: FontWeight.w600,color: primaryColor)),
                    Text('${controller.allTotal.value.toString()} ${'SAR'.tr}',style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w500,color: blackolor)),
                  ],
                ),
                SizedBox(height: sizeH30,),
                
                GestureDetector(
                  onTap: (){
                    if(controller.paymethod.value == 1){
                      controller.payPressed();
                    }else{
                      controller.postOrder();
                    }
                    
                  },
                  child: Container(
                    width: Get.width / 1,
                    height: sizeH50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(sizeW45),
                      color:  primaryColor,
                    ),
                    child:  Center(
                      child: Text(
                        'Check out'.tr,
                        style:  TextStyle(
                          fontSize: sizeW22,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
