// ignore_for_file: must_be_immutable

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constance.dart';
import 'controllers/orders_controller.dart';


class MyOrdersView extends StatelessWidget {
  MyOrdersView({Key? key}) : super(key: key);
  final OrdersController controller = Get.put(OrdersController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: Get.width,
        height: Get.height,
        color: Colors.white,
        padding:  EdgeInsets.all(sizeW15),
        child: ListView(
          children: [
            FadeInRight(
              child:  Text('My Orders'.tr,style: TextStyle(color: primaryColor,fontSize: sizeW20,fontWeight: FontWeight.w600),),
            ),
            SizedBox(height: sizeH20,),
            Obx(() => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: controller.orderssData.isNotEmpty? controller.createOrders():[
                Center(child: Text('No current orders'.tr,style: TextStyle(color: primaryColor,fontSize: sizeW16,fontWeight: FontWeight.w500),),)
              ],
            ),),
            
            FadeInRight(
              child:  Text('Previous orders'.tr,style: TextStyle(color: primaryColor,fontSize: sizeW16,fontWeight: FontWeight.w600),),
            ),
            SizedBox(height: sizeH20,),

            
            Obx(() => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: controller.pordersData.isNotEmpty? controller.createSliders():[
                Center(child: Text('No Previous orders'.tr,style: TextStyle(color: primaryColor,fontSize: sizeW16,fontWeight: FontWeight.w500),),)
              ],
            ),),
            
          ],
        ),
      ),
    );
  }
}
