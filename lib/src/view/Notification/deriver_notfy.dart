// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import '../../../constance.dart';
import 'controllers/notification_controller.dart';

class DeriverNotificationsView extends StatelessWidget {
  DeriverNotificationsView({Key? key}) : super(key: key);
  final NotificationsController controller = Get.put(NotificationsController());
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: ()async{
        controller.getNotifications();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: Get.width,
          height: Get.height,
          padding : EdgeInsets.all(sizeW20),
          child: ListView(
            children:  [
              FadeInRight(
                child: Text('Notification'.tr,style: TextStyle(color: primaryColor,fontSize: sizeW20,fontWeight: FontWeight.w600),),
              ),
              SizedBox(height: sizeH20,),
              Text('Current Order'.tr,style: TextStyle(color: primaryColor,fontSize: sizeW16,fontWeight: FontWeight.w600),),
              SizedBox(height: sizeH15,),
              Obx(() => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: controller.orderssData.isNotEmpty? controller.createNotfys():[
                  Center(child: Text('No current orders'.tr,style: TextStyle(color: primaryColor,fontSize: sizeW16,fontWeight: FontWeight.w500),),)
                ],
              ),),
              
              SizedBox(height: sizeH20,),
              Text('Previews Orders'.tr,style: TextStyle(color: primaryColor,fontSize: sizeW16,fontWeight: FontWeight.w600),),
              SizedBox(height: sizeH15,),
              Obx(() => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: controller.orderssData.isNotEmpty? controller.createPreviews():[
                  Center(child: Text('No Previews orders'.tr,style: TextStyle(color: primaryColor,fontSize: sizeW16,fontWeight: FontWeight.w500),),)
                ],
              ),),
             
              
             
            ],
          ),
        ),
      ),
    );
  }
}
