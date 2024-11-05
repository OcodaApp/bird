// ignore_for_file: must_be_immutable

import 'package:animate_do/animate_do.dart';
import 'package:birdandroid/utility/General.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constance.dart';
import 'controllers/deriver_orders_controller.dart';

class DeriverMyOrdersView extends StatelessWidget {
  DeriverMyOrdersView({Key? key}) : super(key: key);
  final DeriverOrdersController controller = Get.put(DeriverOrdersController());
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: ()async{
        controller.getOrders();
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
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Orders'.tr,style: TextStyle(color: primaryColor,fontSize: sizeW20,fontWeight: FontWeight.w600),),
                    General.image != 'null' && General.image != ''?
                      FadeInDown(
                        child:Container(
                          width: sizeW35,height: sizeW35,
                          decoration:   BoxDecoration(
                            color: whitecolor,
                            borderRadius: BorderRadius.circular(sizeW65),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color:  const Color.fromARGB(31, 153, 152, 152).withOpacity(0.2),
                                offset:  const Offset(0, 0),
                                blurRadius: 10.0,
                              )
                            ],
                            image: DecorationImage(image: NetworkImage(General.imgurl,))
                          ),
                        ),
                      ):
                      FadeInDown(child:Container(
                        width: sizeW35,height: sizeW35,
                        decoration:   BoxDecoration(
                          color: whitecolor,
                          borderRadius: BorderRadius.circular(sizeW65),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color:  const Color.fromARGB(31, 153, 152, 152).withOpacity(0.2),
                              offset:  const Offset(0, 0),
                              blurRadius: 10.0,
                            )
                          ],
                          image: const DecorationImage(image: AssetImage('assets/icons/person2.png'))
                        ),
                      ),),
                  ],
                ),
              ),
              SizedBox(height: sizeH20,),
              Obx(() => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: controller.orderssData.isNotEmpty? controller.createOrders():[
                  SizedBox(
                    height: Get.height / 1.5,
                    child: Center(child: Text('No new orders'.tr,style: TextStyle(color: primaryColor,fontSize: sizeW16,fontWeight: FontWeight.w500),),),
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
