// ignore_for_file: must_be_immutable

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constance.dart';
import 'controllers/complain_controller.dart';

class ComplainsView extends StatelessWidget {
  ComplainsView({Key? key}) : super(key: key);
  final ComplainController controller = Get.put(ComplainController());
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: ()async{
        controller.getComplainsList();
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
                child:  Text('Your complains'.tr,style: TextStyle(color: primaryColor,fontSize: sizeW20,fontWeight: FontWeight.w600),),
              ),
              SizedBox(height: sizeH20,),
              Obx(() => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: controller.complainsData.isNotEmpty? controller.createSliders():[
                  Container()
                ],
              ),),
              
              
            ],
          ),
        ),
      ),
    );
  }
}
