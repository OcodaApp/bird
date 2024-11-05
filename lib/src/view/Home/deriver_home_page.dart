// ignore_for_file: must_be_immutable

import 'package:birdandroid/utility/General.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import '../../../constance.dart';
import 'controllers/home_deriver_controller.dart';

class DeriverHomePageView extends StatelessWidget {
  DeriverHomePageView({Key? key}) : super(key: key);
  final HomeDeriverController controller = Get.put(HomeDeriverController());
  
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: ()async{
        controller.getMyOrders();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: Get.width,
          height: Get.height,
          padding :  EdgeInsets.all(sizeW20),
          child: ListView(
            children:  [
              FadeInRight(
                child: SizedBox(
                  width: Get.width / 1,
                  child: Wrap(
                    children: [
                      Text('Good evening'.tr,style: TextStyle(color: blackolor,fontSize: sizeW18,fontWeight: FontWeight.w600),),
                      Text(' '.tr,style: TextStyle(color: blackolor,fontSize: sizeW18,fontWeight: FontWeight.w600),),
                      Text('${General.username}!'.tr,style: TextStyle(color: blackolor,fontSize: sizeW18,fontWeight: FontWeight.w600),),
                    ],
                  ),
                ),
              ),
              SizedBox(height: sizeH20,),
              FadeInRight(
                child:  Text('Previous orders'.tr,style: TextStyle(color: primaryColor,fontSize: sizeW16,fontWeight: FontWeight.w600),),
              ),
              SizedBox(height: sizeH20,),
              Obx(() => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: controller.orderssData.isNotEmpty? controller.createSliders():[
                  SizedBox(
                    height: Get.height / 1.5,
                    child: Center(child: Text('No Previous orders'.tr,style: TextStyle(color: primaryColor,fontSize: sizeW16,fontWeight: FontWeight.w500),),),
                  ),
                ],
              ),),
              
            ],
          ),
        ),
      ),
    );
  }
}
