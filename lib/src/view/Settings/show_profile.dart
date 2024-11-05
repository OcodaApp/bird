// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import '../../../constance.dart';
import '../../../utility/General.dart';
import 'edit_profile.dart';

class ShowProfileView extends StatelessWidget {
  const ShowProfileView({Key? key}) : super(key: key);
  
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
              child:  Text('Edit Profile'.tr,style: TextStyle(color: primaryColor,fontSize: sizeW20,fontWeight: FontWeight.w600),),
            ),
            SizedBox(height: sizeH20,),
            GestureDetector(
              onTap: (){
                 Get.to(()=> EditProfileView());
              },
              child: Container(
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
                  General.image == 'null'? SizedBox(
                    width: sizeW75,
                    child: Image.asset('assets/icons/person2.png',width: sizeW75,height: sizeW75,fit: BoxFit.fill,),
                  ):CircleAvatar(
                    maxRadius: sizeW35,
                    minRadius: sizeW35,
                    backgroundImage: NetworkImage(General.imgurl),
                  ),
                  SizedBox(width: sizeW25,),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(General.username,style: TextStyle(color: primaryColor,fontSize: sizeW20,fontWeight: FontWeight.w600),),
                        SizedBox(height: sizeH2,),
                        Text(General.mobile,style: TextStyle(color: greyOpacityColor,fontSize: sizeW16,fontWeight: FontWeight.w400),),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ),
            SizedBox(height: sizeH40,),
            
            GestureDetector(
              onTap: (){
                 Get.to(()=> EditProfileView());
              },
              child: Container(
                padding: EdgeInsets.only(bottom: sizeH20),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: grey3.withOpacity(0.1)),
                  ),
                ),
                child: Row(
                  children: [
                    FadeInDown(child:Image.asset('assets/profile/user.png',width: sizeW16,height: sizeW16,fit: BoxFit.fill,),),
                    SizedBox(width: sizeW15,),
                    Text(General.username,style: TextStyle(color: const Color(0xFF808080),fontSize: sizeW16,fontWeight: FontWeight.w400),),
                  ],
                ),
              ),
            ),
            SizedBox(height: General.email != '' && General.email != 'null' ?sizeH20:0,),
            General.email != '' && General.email != 'null' ? GestureDetector(
              onTap: (){
                 Get.to(()=> EditProfileView());
              },
              child: Container(
                padding: EdgeInsets.only(bottom: sizeH20),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: grey3.withOpacity(0.1)),
                  ),
                ),
                child: Row(
                  children: [
                    FadeInDown(child:Image.asset('assets/profile/sms.png',width: sizeW16,height: sizeW16,fit: BoxFit.fill,),),
                    SizedBox(width: sizeW15,),
                    Text(General.email,style: TextStyle(color: const Color(0xFF808080),fontSize: sizeW16,fontWeight: FontWeight.w400),),
                  ],
                ),
              ),
            ):Container(),
            SizedBox(height: General.mobile != '' && General.mobile != 'null' ?sizeH20:0,),
            General.mobile != '' && General.mobile != 'null' ? GestureDetector(
              onTap: (){
                 Get.to(()=> EditProfileView());
              },
              child: Container(
                padding: EdgeInsets.only(bottom: sizeH20),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: grey3.withOpacity(0.1)),
                  ),
                ),
                child: Row(
                  children: [
                    FadeInDown(child:Image.asset('assets/profile/mobile.png',width: sizeW16,height: sizeW16,fit: BoxFit.fill,),),
                    SizedBox(width: sizeW15,),
                    Text(General.mobile.toString(),style: TextStyle(color: const Color(0xFF808080),fontSize: sizeW16,fontWeight: FontWeight.w400),),
                  ],
                ),
              ),
            ):Container(),
            SizedBox(height: General.sexName != '' && General.sexName != 'null' ?sizeH20:0,),
            General.sexName != '' && General.sexName != 'null' ? GestureDetector(
              onTap: (){
                 Get.to(()=> EditProfileView());
              },
              child: Container(
                padding: EdgeInsets.only(bottom: sizeH20),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: grey3.withOpacity(0.1)),
                  ),
                ),
                child: Row(
                  children: [
                    FadeInDown(child:Image.asset('assets/profile/man.png',width: sizeW16,height: sizeW16,fit: BoxFit.fill,),),
                    SizedBox(width: sizeW15,),
                    Text(General.sexName,style: TextStyle(color: const Color(0xFF808080),fontSize: sizeW16,fontWeight: FontWeight.w400),),
                  ],
                ),
              ),
            ):Container(),
            SizedBox(height: General.birth != '' && General.birth != 'null' ? sizeH20:0,),
            General.birth != '' && General.birth != 'null'? GestureDetector(
              onTap: (){
                 Get.to(()=> EditProfileView());
              },
              child: Row(
                children: [
                  FadeInDown(child:Image.asset('assets/profile/calendar-2.png',width: sizeW16,height: sizeW16,fit: BoxFit.fill,),),
                  SizedBox(width: sizeW15,),
                  Text(General.birth,style: TextStyle(color: const Color(0xFF808080),fontSize: sizeW16,fontWeight: FontWeight.w400),),
                ],
              ),
            ):Container(),
          ],
        ),
      ),
    );
  }
}
