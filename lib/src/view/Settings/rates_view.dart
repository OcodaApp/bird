// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import '../../../constance.dart';
import 'controllers/ratings_controller.dart';

class RatesView extends StatelessWidget {
  RatesView({Key? key}) : super(key: key);
  final RatingsController controller = Get.put(RatingsController());
  
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
              child: Text('Rates'.tr,style: TextStyle(color: primaryColor,fontSize: sizeW20,fontWeight: FontWeight.w600),),
            ),
            SizedBox(height: sizeH20,),
            Obx(() => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: controller.orderssData.isNotEmpty? controller.createOrders():[
                Center(child: Text('No Rates'.tr,style: TextStyle(color: primaryColor,fontSize: sizeW16,fontWeight: FontWeight.w500),),)
              ],
            ),),
            SizedBox(height: sizeH15,),
          ],
        ),
      ),
    );
  }
}
