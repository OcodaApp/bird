// ignore_for_file: must_be_immutable

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constance.dart';
import 'controllers/coupons_controller.dart';


class CouponsView extends StatelessWidget {
  CouponsView({Key? key}) : super(key: key);
  final CouponsController controller = Get.put(CouponsController());
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: ()async{
        controller.getCoupons();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: Get.width,
          height: Get.height,
          color: Colors.white,
          padding:  EdgeInsets.all(sizeW15),
          child: ListView(
            children: [
              FadeInRight(
                child:  Text('My coupons'.tr,style: TextStyle(color: primaryColor,fontSize: sizeW20,fontWeight: FontWeight.w600),),
              ),
              SizedBox(height: sizeH20,),
              Obx(() => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: controller.couponsData.isNotEmpty? controller.createCoupon(context):[
                  Center(child: Text('No coupons'.tr,style: TextStyle(color: primaryColor,fontSize: sizeW16,fontWeight: FontWeight.w500),),)
                ],
              ),),
            ],
          ),
        ),
      ),
    );
  }
}
