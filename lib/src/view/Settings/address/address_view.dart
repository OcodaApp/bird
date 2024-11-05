// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import '../../../../constance.dart';
import '../../../../utility/Address.dart';
import '../../../../utility/General.dart';
import '../../user/controllers/place_controller.dart';
import '../../user/edit_addres.dart';
import '../../user/location_view.dart';
import '../controllers/address_controller.dart';

class AddressView extends StatelessWidget {
   AddressView({Key? key}) : super(key: key);
  final AddressController controller = Get.put(AddressController());
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: ()async{
        controller.getAddressUser();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: Get.width,
          height: Get.height,
          padding :  EdgeInsets.all(sizeW10),
          child: ListView(
            children:  [
              SizedBox(height: sizeH10,),
              FadeInRight(
                child: Text('Address book'.tr,style: TextStyle(color: primaryColor,fontSize: sizeW20,fontWeight: FontWeight.w600),),
              ),
              SizedBox(height: sizeH25,),
              Container(
                width: Get.width / 1,
                padding:  EdgeInsets.only(right: sizeW20,left: sizeW20,top: sizeH15,bottom: sizeH15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(sizeW45),
                  color:   primaryColor.withOpacity(.1),
                  border: Border.all(color:  primaryColor)
                ),
                child: Row(
                  children: [
                    Image.asset('assets/profile/plus.png',height: sizeW14,width: sizeW14,fit: BoxFit.fill,),
                    SizedBox(width: sizeH10,),
                    GestureDetector(
                      onTap: (){
                        PlaceController placeController = Get.put(PlaceController());
                        placeController.getCurrentLocation().then((res) {
                          General().getlatitude();
                          General().getlongitude();
                          General().getUserData().then((val){
                            Get.to(()=>MapSearchView(lat: General.latitude,long: General.longitude,));
                          });
                        });
                      },
                      child: Text(
                        'Add new adress'.tr,
                        style:  TextStyle(
                          fontSize: sizeW16,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: sizeH25,),
              
              Obx(() => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: controller.addrssData.isNotEmpty? createSliders():[
                  Center(child: Text('no address add'.tr),)
                ],
              ),),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> createSliders() {
    List<Widget> imageSliders = controller.addrssData.map((item) {
      return Column(
        children: [
          Container(
            padding:  EdgeInsets.all(sizeW20),
            decoration:  BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(sizeW15),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: const Color.fromARGB(31, 153, 152, 152).withOpacity(0.2),
                  offset: const Offset(2.0, 2.0),
                  blurRadius: 20.0,
                )
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('assets/marker.png',width: sizeW16,height: sizeW16,fit: BoxFit.fill,color:  primaryColor,),
                    SizedBox(width: sizeW10,),
                    Text(item.title,style: TextStyle(color: primaryColor,fontSize: sizeW16,fontWeight: FontWeight.w600),),
                    
                  ],
                ),
                SizedBox(height: sizeH5,),
                Text(item.street,style: TextStyle(color: greyOpacityColor,fontSize: sizeW14,fontWeight: FontWeight.w400),),
                SizedBox(height: sizeH10,),
                GestureDetector(
                  onTap: (){
                    controller.addrssId.value = item.id;
                    controller.addressChoose = {
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
                    Address().setAddresId(controller.addrssId.value.toString());
                    Address().getAddresId();
                    Address().setAddressData(controller.addressChoose);
                    Address().getAddressData();
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: sizeW14,
                        height: sizeH10,
                        child: Transform.scale(
                          scale: 0.7,
                          child: Radio(
                            value: controller.addrssId.value,
                            groupValue: item.id,
                            activeColor:  primaryColor,
                            onChanged: (value) {
                              controller.addrssId.value = item.id;
                              controller.addressChoose = {
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
                              Address().setAddresId(controller.addrssId.value.toString());
                              Address().getAddresId();
                              Address().setAddressData(controller.addressChoose);
                              Address().getAddressData();
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: sizeW5,),
                      SizedBox(
                        width: Get.width / 2.5,
                        child: Text('Make this address default'.tr,style: TextStyle(color: primaryColor,fontSize: sizeW14,fontWeight: FontWeight.w400),)),
                      SizedBox(width: sizeW20,),
                      controller.addrssId.value != item.id ?Image.asset('assets/icons/trash.png',width: sizeW16,height: sizeW16,fit: BoxFit.fill,color: primaryColor,):Container(),
                      SizedBox(width: controller.addrssId.value != item.id ?sizeW5:0,),
                      controller.addrssId.value != item.id ?GestureDetector(
                        onTap: (){
                          controller.deleteAddress(item.id).then((value){
                            controller.getAddressUser();
                          });
                        },
                        child: Text('Delete'.tr,style: TextStyle(color: primaryColor,fontSize: sizeW14,fontWeight: FontWeight.w600),)):Container(),
                      SizedBox(width: sizeW10,),
                      Image.asset('assets/profile/edit-2.png',width: sizeW16,height: sizeW16,fit: BoxFit.fill,color: primaryColor,),
                      SizedBox(width: sizeW5,),
                      GestureDetector(
                        onTap: (){
                          Get.to(()=>const EditAddress(),arguments: [double.parse(item.latitude),double.parse(item.longitude),item]);
                        },
                        child: Text(
                          'Edit'.tr,
                          style: TextStyle(fontSize: sizeW14,fontWeight: FontWeight.w600,color: primaryColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: sizeH10,),
        ],
      );
    }).toList();
    return imageSliders;
  }
}
