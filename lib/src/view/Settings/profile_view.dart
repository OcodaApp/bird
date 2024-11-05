// ignore_for_file: must_be_immutable

import 'package:birdandroid/utility/General.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import '../../../constance.dart';
import '../../../widgets/custom_material_button.dart';
import 'address/address_view.dart';
import 'controllers/setting_controller.dart';
import 'coupons_view.dart';
import 'rates_view.dart';
import 'setting_view.dart';
import 'show_profile.dart';

class ProfileView extends StatelessWidget {
  ProfileView({Key? key}) : super(key: key);
  final SettingsController controller = Get.put(SettingsController());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: Get.width,
        height: Get.height,
        padding :  EdgeInsets.all(sizeW20),
        child: ListView(
          children:  [
            FadeInRight(
              child: Text('Account'.tr,style: TextStyle(color: primaryColor,fontSize: sizeW20,fontWeight: FontWeight.w600),),
            ),
            SizedBox(height: sizeH20,),
            Container(
              padding:  EdgeInsets.only(right: sizeW20,left: sizeW20,bottom: sizeH10,top: sizeH10),
              decoration:  BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color:  const Color.fromARGB(31, 153, 152, 152).withOpacity(0.2),
                    offset:  const Offset(2.0, 2.0),
                    blurRadius: 20.0,
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(() => !controller.isImage.value? SizedBox(
                    width: sizeW75,
                    child: Image.asset('assets/icons/person2.png',width: sizeW75,height: sizeW75,fit: BoxFit.fill,),
                  ):CircleAvatar(
                    maxRadius: sizeW35,
                    minRadius: sizeW35,
                    backgroundImage: NetworkImage(controller.imageUrl.value),
                  ),),
                  SizedBox(width: sizeW25,),
                  Expanded(
                    child: Obx(() => Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(controller.name.value,style: TextStyle(color: primaryColor,fontSize: sizeW20,fontWeight: FontWeight.w600),),
                        SizedBox(height: sizeH2,),
                        Text(controller.email.value,style: TextStyle(color: greyOpacityColor,fontSize: sizeW16,fontWeight: FontWeight.w400),),
                      ],
                    ),),
                  ),
                ],
              ),
            ),
            SizedBox(height: sizeH30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: Get.width / 10,
                          child: Text(General.walletCount.toString(),style: TextStyle(color: primaryColor,fontSize: sizeW16,fontWeight: FontWeight.w600),overflow: TextOverflow.ellipsis,)),
                        Text('SAR'.tr,style: TextStyle(color: primaryColor,fontSize: sizeW16,fontWeight: FontWeight.w600),),
                      ],
                    ),
                    SizedBox(height: sizeH2,),
                    Text('wallet'.tr,style: TextStyle(color: greyOpacityColor,fontSize: sizeW16,fontWeight: FontWeight.w300),),
                  ],
                ),
                Container(
                  width: 1,
                  height: sizeH40,
                  color: grey3,
                ),
                Column(
                  children: [
                    SizedBox(
                      width: Get.width / 10,
                      child: Text(General.ordersCount != 'null' ?General.ordersCount.toString():'0',
                        style: TextStyle(color: primaryColor,fontSize: sizeW16,fontWeight: FontWeight.w600,overflow: TextOverflow.ellipsis,),
                        ),
                      ),
                    SizedBox(height: sizeH2,),
                    Text('My Orders'.tr,style: TextStyle(color: greyOpacityColor,fontSize: sizeW16,fontWeight: FontWeight.w300),),
                  ],
                ),
              ],
            ),
            SizedBox(height: sizeH40,),
            GestureDetector(
              onTap: ()async{
                var res = await Get.to(()=>const ShowProfileView());
                if(res != null){
                  if(res[0] == 'yes'){
                    General().getUserData().then((vv){
                      controller.email.value = General.email;
                      controller.name.value = General.username;
                      if(General.image != 'null'){
                        controller.isImage.value = true;
                        controller.imageUrl.value = General.imgurl;
                        controller.image.value = General.image;
                      }else{
                        controller.isImage.value = false;
                        controller.imageUrl.value = '';
                        controller.image.value = '';
                      }
                    });
                  }
                }
                
                
              },
              child: Container(
                padding:  EdgeInsets.only(bottom: sizeH10),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: grey3.withOpacity(0.1)),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        FadeInDown(child:Image.asset('assets/icons2/profile2.png',width: sizeH40,height: sizeH40,fit: BoxFit.fill,),),
                        SizedBox(width: sizeW15,),
                        SizedBox(
                          width: Get.width / 2,
                          child: Text('Profile'.tr,style: TextStyle(color: primaryColor,fontSize: sizeW16,fontWeight: FontWeight.w600),)),
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios_outlined,size: sizeW16,color: primaryColor,),
                  ],
                ),
              ),
            ),
            SizedBox(height: sizeH10,),
            GestureDetector(
              onTap: (){
                Get.to(()=> AddressView());
              },
              child: Container(
                padding: EdgeInsets.only(bottom: sizeH10),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: grey3.withOpacity(0.1)),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        FadeInDown(child:Image.asset('assets/icons2/address.png',width: sizeH40,height: sizeH40,fit: BoxFit.fill,),),
                        SizedBox(width: sizeW15,),
                        SizedBox(
                          width: Get.width / 2,
                          child: Text('Address'.tr,style: TextStyle(color: primaryColor,fontSize: sizeW16,fontWeight: FontWeight.w600),)),
                      ],
                    ),
                     Icon(Icons.arrow_forward_ios_outlined,size: sizeW16,color: primaryColor,),
                  ],
                ),
              ),
            ),
            SizedBox(height: sizeH10,),
            GestureDetector(
              onTap: (){
                Get.to(()=> RatesView());
              },
              child: Container(
                padding: EdgeInsets.only(bottom: sizeH10),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: grey3.withOpacity(0.1)),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        FadeInDown(child:Image.asset('assets/icons2/ratings.png',width: sizeH40,height: sizeH40,fit: BoxFit.fill,),),
                        SizedBox(width: sizeW15,),
                        SizedBox(
                          width: Get.width / 2,
                          child: Text('Orders rates'.tr,style: TextStyle(color: primaryColor,fontSize: sizeW16,fontWeight: FontWeight.w600),)),
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios_outlined,size: sizeW16,color: primaryColor,),
                  ],
                ),
              ),
            ),
            SizedBox(height: sizeH10,),
            GestureDetector(
              onTap: (){
                Get.to(()=> CouponsView());
              },
              child: Container(
                padding: EdgeInsets.only(bottom: sizeH10),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: grey3.withOpacity(0.1)),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        FadeInDown(child:Image.asset('assets/icons2/promo.png',width: sizeH40,height: sizeH40,fit: BoxFit.fill,),),
                        SizedBox(width: sizeW15,),
                        SizedBox(
                          width: Get.width /3,
                          child: Text('Coupons'.tr,style: TextStyle(color: primaryColor,fontSize: sizeW16,fontWeight: FontWeight.w600),)),
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios_outlined,size: sizeW16,color: primaryColor,),
                    // Container(
                    //   padding:  EdgeInsets.only(right: sizeW15,left: sizeW15,bottom: sizeH5,top: sizeH5),
                    //   decoration: BoxDecoration(
                    //     color: primaryColor.withOpacity(0.2),
                    //     borderRadius: BorderRadius.circular(sizeW25),
                    //   ),
                    //   child: Center(
                    //     child: Row(
                    //       children: [
                    //         Icon(Icons.add,size: sizeW12,color: primaryColor,),
                    //         SizedBox(width: sizeW5,),
                    //         SizedBox(
                    //           width: sizeW65,
                    //           child: Text('Add Coupon'.tr,style: TextStyle(fontSize: sizeW12,fontWeight: FontWeight.w500,color: primaryColor))),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            SizedBox(height: sizeH10,),
            GestureDetector(
              onTap: (){
                Get.to(()=>SettingView());
              },
              child: Container(
                padding: EdgeInsets.only(bottom: sizeH10),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: grey3.withOpacity(0.1)),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        FadeInDown(child:Image.asset('assets/icons2/setting.png',width: sizeH40,height: sizeH40,fit: BoxFit.fill,),),
                        SizedBox(width: sizeW15,),
                         SizedBox(
                          width: Get.width / 2,
                          child: Text('Settings'.tr,style: TextStyle(color: primaryColor,fontSize: sizeW16,fontWeight: FontWeight.w600),)),
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios_outlined,size: sizeW16,color: primaryColor,),
                  ],
                ),
              ),
            ),
            SizedBox(height: sizeH10,),
            // GestureDetector(
            //   onTap: (){
            //     // Get.to(()=>const ComplainsView());
            //   },
            //   child: Container(
            //     padding: EdgeInsets.only(bottom: sizeH10),
            //     decoration: BoxDecoration(
            //       border: Border(
            //         bottom: BorderSide(color: grey3.withOpacity(0.1)),
            //       ),
            //     ),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Row(
            //           children: [
            //             FadeInDown(child:Image.asset('assets/icons2/share2.png',width: sizeH40,height: sizeH40,fit: BoxFit.fill,),),
            //             SizedBox(width: sizeW15,),
            //             SizedBox(
            //               width: Get.width / 2,
            //               child: Text('Share the app'.tr,style: TextStyle(color: primaryColor,fontSize: sizeW16,fontWeight: FontWeight.w600),)),
            //           ],
            //         ),
            //          Icon(Icons.arrow_forward_ios_outlined,size: sizeW16,color: primaryColor,),
            //       ],
            //     ),
            //   ),
            // ),
            GestureDetector(
              onTap: (){
                Get.defaultDialog(
                  backgroundColor: whitecolor,
                  title: 'delete acc?'.tr,
                  radius: sizeW5,
                  titleStyle:  TextStyle(
                      fontSize: sizeW14, color: primaryColor, height: 3),
                  confirm: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceAround,
                    children: [
                      CustomMaterialButton(
                        colorButton: primaryColor,
                        colorText: whitecolor,
                        height: sizeH40,
                        minWidth: Get.width / 4,
                        borderRadius: sizeW5,
                        text: 'ok'.tr,
                        fontSize: sizeW12,
                        fontWeight: FontWeight.bold,
                        onPressed: () {
                          General().logOut().then((value) {
                            Get.offAllNamed('/Splash');
                          });
                        },
                      ),
                      SizedBox(width: sizeW5,),
                      CustomMaterialButton(
                        colorButton: greenColor,
                        colorText: whitecolor,
                        height: sizeH40,
                        minWidth: Get.width / 4,
                        borderRadius: sizeW5,
                        text: 'cancel'.tr,
                        fontSize: sizeW12,
                        fontWeight: FontWeight.bold,
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ],
                  ),
                  content: Container(),
                );
              },
              child: Container(
                padding: EdgeInsets.only(bottom: sizeH10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        FadeInDown(child:Image.asset('assets/icons2/share2.png',width: sizeH40,height: sizeH40,fit: BoxFit.fill,),),
                        SizedBox(width: sizeW15,),
                        SizedBox(
                          width: Get.width / 2,
                          child: Text('delete acc'.tr,style: TextStyle(color: primaryColor,fontSize: sizeW16,fontWeight: FontWeight.w600),)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: sizeH10,),
            GestureDetector(
              onTap: (){
                Get.defaultDialog(
                  backgroundColor: whitecolor,
                  title: 'logout?'.tr,
                  radius: sizeW5,
                  titleStyle:  TextStyle(
                      fontSize: sizeW14, color: primaryColor, height: 3),
                  confirm: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceAround,
                    children: [
                      CustomMaterialButton(
                        colorButton: primaryColor,
                        colorText: whitecolor,
                        height: sizeH40,
                        minWidth: Get.width / 4,
                        borderRadius: sizeW5,
                        text: 'ok'.tr,
                        fontSize: sizeW12,
                        fontWeight: FontWeight.bold,
                        onPressed: () {
                          General().logOut().then((value) {
                            Get.offAllNamed('/Splash');
                          });
                        },
                      ),
                      SizedBox(width: sizeW5,),
                      CustomMaterialButton(
                        colorButton: greenColor,
                        colorText: whitecolor,
                        height: sizeH40,
                        minWidth: Get.width / 4,
                        borderRadius: sizeW5,
                        text: 'cancel'.tr,
                        fontSize: sizeW12,
                        fontWeight: FontWeight.bold,
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ],
                  ),
                  content: Container(),
                );
              },
              child: Container(
                padding: EdgeInsets.only(bottom: sizeH10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        FadeInDown(child:Image.asset('assets/icons2/share2.png',width: sizeH40,height: sizeH40,fit: BoxFit.fill,),),
                        SizedBox(width: sizeW15,),
                        SizedBox(
                          width: Get.width / 2,
                          child: Text('Logout'.tr.tr,style: TextStyle(color: primaryColor,fontSize: sizeW16,fontWeight: FontWeight.w600),)),
                      ],
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
