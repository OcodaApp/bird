// ignore_for_file: must_be_immutable

import 'package:birdandroid/utility/Address.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';

import '../../../constance.dart';
import 'check_out_view.dart';
import 'controller/cart_controller.dart';

class CartView extends StatelessWidget {
  CartView({Key? key}) : super(key: key);
  final CartController controller = Get.put(CartController());
  
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: ()async{
        controller.getBaskets();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: Get.width,
          height: Get.height,
          padding :  EdgeInsets.all(sizeW20),
          child: Obx(() => controller.isitems.value? ListView(
            children:  [
              FadeInRight(
                child:  Text('My Cart'.tr,style: TextStyle(color: primaryColor,fontSize: sizeW20,fontWeight: FontWeight.w600),),
              ),
              SizedBox(height: sizeH10,),
              Text(controller.storeName.value,style: TextStyle(color: primaryColor,fontSize: sizeW20,fontWeight: FontWeight.w600),),
              Text('${controller.basketsData.length} ${'Items'.tr}',style: TextStyle(color: primaryColor,fontSize: sizeW16,fontWeight: FontWeight.w300,height: 1.7),),
              SizedBox(height: sizeH15,),
              Column(children: createBaskets(),),
              Row(
                children: [
                  Text('Special requests'.tr,style: TextStyle(fontSize: sizeW18,fontWeight: FontWeight.w600,color: primaryColor),textAlign: TextAlign.center,),
                ],
              ),
              SizedBox(height: sizeH10,),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType : TextInputType.name,
                maxLines: 3,
                controller: controller.notes,
                decoration:   InputDecoration(
                  hintText: 'Special requests'.tr,
                  contentPadding: EdgeInsets.only(
                    top: sizeH15,
                    bottom: sizeH15,
                    right: sizeW15,
                    left: sizeW15,
                  ),
                  border:  OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(sizeW25)),
                    borderSide: const BorderSide(
                      color: grey3,
                      width: 0.8,
                    ),
                  ),
                  hintStyle:  TextStyle(
                    fontSize: sizeW16,
                    color: grey5,
                    fontWeight: FontWeight.w300,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius:  BorderRadius.all(Radius.circular(sizeW25)),
                    borderSide: const BorderSide(
                      color: grey3,
                      width: 0.8,
                    ),
                  ),
                  focusedBorder:  OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(sizeW25)),
                    borderSide: const BorderSide(
                      color: grey3,
                      width: 1,
                    ),
                  ),
                ),
                style:   TextStyle(
                  fontSize: sizeW16,
                  color: blackolor,
                  fontWeight: FontWeight.w300,
                ),
                validator: (value) {
                  // if (value == null || value.isEmpty) {
                  //   return 'Please enter Delivering adress';
                  // }
                  return null;
                },
              ),
              SizedBox(height: sizeH15,),
              Row(
                children: [
                  Text('Get a discount'.tr,style: TextStyle(fontSize: sizeW18,fontWeight: FontWeight.w600,color: primaryColor),),
                ],
              ),
              SizedBox(height: sizeH10,),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType : TextInputType.name,
                onChanged: (value){
                  controller.couponText.value = value;
                },
                controller: controller.coupon,
                decoration:  InputDecoration(
                  hintText: 'Enter code'.tr,
                  contentPadding:  EdgeInsets.only(
                    top: 0,
                    bottom: 0,
                    right: sizeW15,
                    left: sizeW15,
                  ),
                  border:   OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(sizeW45)),
                    borderSide: const BorderSide(
                      color: grey3,
                      width: 0.8,
                    ),
                  ),
                  suffixIcon:  Obx(() => GestureDetector(
                    onTap: (){
                      FocusManager.instance.primaryFocus?.unfocus();
                      FocusScope.of(context).unfocus();
                      if(controller.couponText.value != ''){
                        controller.checkCoupon(context);
                      }
                    },
                    child: !controller.isCoupon.value?Container(
                      margin:  EdgeInsets.all(sizeW10),
                      padding:  EdgeInsets.only(right: sizeW15,left: sizeW15,bottom: 5,top: 5),
                      decoration: BoxDecoration(
                        color:   primaryColor.withOpacity(.1),
                        borderRadius: BorderRadius.circular(sizeW45),
                      ),
                      child:  Text('send'.tr,style: TextStyle(fontSize: sizeW14,fontWeight: FontWeight.w400,color: primaryColor),),
                    ):SizedBox(
                      width: Get.width / 2.5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: Get.width / 3.5,
                            margin:  EdgeInsets.all(sizeW5),
                            padding:  EdgeInsets.only(right: sizeW15,left: sizeW15,bottom: sizeH5,top: sizeH5),
                            decoration: BoxDecoration(
                              color:   primaryTowColor.withOpacity(.2),
                              borderRadius: BorderRadius.circular(sizeW45),
                            ),
                            child:  Row(
                              children: [
                                Container(
                                  width: sizeW20,
                                  height: sizeW20,
                                  decoration: BoxDecoration(
                                    color:   primaryTowColor,
                                    borderRadius: BorderRadius.circular(sizeW45),
                                  ),
                                  child: Center(
                                    child: Icon(Icons.add_task_outlined,size: sizeW12,color: whitecolor,),
                                  ),
                                ),
                                SizedBox(width: sizeW5,),
                                Text('Applied'.tr,style: TextStyle(fontSize: sizeW14,fontWeight: FontWeight.w400,color: primaryColor),),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              controller.coupon.clear();
                              controller.couponText.value = '';
                              controller.salePrice.value = 0.0;
                              controller.sale.value = 0;
                              controller.couponId.value = '0';
                              controller.isCoupon.value = false;
                              controller.getBaskets();
                            },
                            child: Container(
                              width: sizeW20,
                              height: sizeW20,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(sizeW45),
                              ),
                              child: Center(
                                child: Icon(Icons.close_outlined,size: sizeW12,color: whitecolor,),
                              ),
                            ),
                          ),
                          SizedBox(width: sizeW10,)
                        ],
                      ),
                    ),
                  ),),
                  prefixIcon: Image.asset('assets/icons/ticket-discount.png',color:  grey4,),
                  hintStyle:   TextStyle(
                    fontSize: sizeW16,
                    color: grey5,
                    fontWeight: FontWeight.w300,
                  ),
                  enabledBorder:  OutlineInputBorder(
                    borderRadius:  BorderRadius.all(Radius.circular(sizeW45)),
                    borderSide: const BorderSide(
                      color: grey3,
                      width: 0.8,
                    ),
                  ),
                  focusedBorder:   OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(sizeW45)),
                    borderSide: const BorderSide(
                      color: grey3,
                      width: 1,
                    ),
                  ),
                ),
                style:   TextStyle(
                  fontSize: sizeW16,
                  color: blackolor,
                  fontWeight: FontWeight.w300,
                ),
                validator: (value) {
                  // if (value == null || value.isEmpty) {
                  //   return 'Please enter Delivering adress';
                  // }
                  return null;
                },
              ),
              SizedBox(height: sizeH15,),
              Row(
                children: [
                  Text('Payment Summary'.tr,style: TextStyle(fontSize: sizeW18,fontWeight: FontWeight.w600,color: primaryColor),),
                ],
              ),
              SizedBox(height: sizeH15,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Sub Total'.tr,style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w400,color: greyOpacityColor)),
                      Text('${controller.basketStoreTotal.value.toString()} ${'SAR'.tr}',style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w500,color: blackolor)),
                      
                    ],
                  ),
                  SizedBox(height: sizeH5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Delivery fee'.tr,style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w400,color: greyOpacityColor)),
                      Text('${controller.deliveryTotal.value.toString()} ${'SAR'.tr}',style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w500,color: blackolor)),
                    ],
                  ),
                  SizedBox(height: sizeH5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Service fees'.tr,style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w400,color: greyOpacityColor)),
                      Text('${controller.servicePrice.value.toString()} ${'SAR'.tr}',style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w500,color: blackolor)),
                    ],
                  ),
                  SizedBox(height: sizeH5,),
                  controller.salePrice.value > 0 ?Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Discount'.tr,style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w400,color: greyOpacityColor)),
                      Text('-${controller.salePrice.value.toString()} ${'SAR'.tr}',style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w500,color: Colors.red)),
                    ],
                  ):Container(),
                  SizedBox(height: controller.salePrice.value > 0 ?sizeH15:0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total amount'.tr,style: TextStyle(fontSize: sizeW18,fontWeight: FontWeight.w600,color: primaryColor)),
                      Text('${controller.allTotal.value.toString()} ${'SAR'.tr}',style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w500,color: blackolor)),
                    ],
                  ),
                  SizedBox(height: sizeH30,),
                  
                  GestureDetector(
                    onTap: (){
                      FocusManager.instance.primaryFocus?.unfocus();
                      FocusScope.of(context).unfocus();
                      Get.to(()=>CheckOutView(),arguments: [
                        double.parse(Address.a_lat),
                        double.parse(Address.a_long),
                        controller.basketStoreCount.value,
                        controller.basketStoreTotal.value,
                        controller.deliveryTotal.value,
                        controller.servicePrice.value,
                        controller.salePrice.value,
                        controller.allTotal.value,
                        controller.timeAll.value,
                        controller.basketStoreCount.value,
                        controller.notes.text,
                        controller.storeId.value,
                        controller.sale.value,
                        controller.couponId.value,

                      ]);
                    },
                    child: Container(
                      width: Get.width / 1,
                      height: sizeH50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(sizeW45),
                        color:  primaryColor,
                      ),
                      child:  Center(
                        child: Text(
                          'Check out'.tr,
                          style:  TextStyle(
                            fontSize: sizeW22,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ):SizedBox(
            width: Get.width,
            height: Get.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: FadeInRight(
                    child:  Text('My Cart empty'.tr,style: TextStyle(color: primaryColor,fontSize: sizeW20,fontWeight: FontWeight.w600),),
                  ),
                ),
              ],
            ),
          ),),
        ),
      ),
    );
  }

  List<Widget> createBaskets() {
    List<Widget> imageSliders = controller.basketsData.asMap().entries.map((item) {
      return Column(
        children: [
          Container(
            padding:  EdgeInsets.only(right: sizeW10,left: sizeW10,bottom: sizeH15,top: sizeH15),
            margin:  EdgeInsets.only(right: sizeW5,left: sizeW5),
            decoration:  BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(sizeW15),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color:  const Color.fromARGB(31, 153, 152, 152).withOpacity(0.2),
                  offset:  const Offset(0, 0),
                  blurRadius: 10.0,
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FadeInDown(child:Image.network(item.value.image,width: sizeW50,height: sizeW45,fit: BoxFit.fill,),),
                SizedBox(width: sizeW10,),
                SizedBox(
                  width: Get.width/2.2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.value.name,style: TextStyle(color: primaryColor,fontSize: sizeW16,fontWeight: FontWeight.w500),),
                      Text(item.value.desc,style: TextStyle(color: greyOpacityColor,fontSize: sizeW12,fontWeight: FontWeight.w300),),
                      SizedBox(height: sizeH5,),
                      Text('${item.value.price} ${'SAR'.tr}',style: TextStyle(color: primaryColor,fontSize: sizeW14,fontWeight: FontWeight.w500),),
                    ],
                  ),
                ),
                
                Expanded(
                  child: !controller.isWait.value? Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: (){
                              var data = {
                                'item_id' : item.value.id,
                                'price' : item.value.price,
                                'quantity' : item.value.count - 1,
                                'total' : item.value.price  * (item.value.count - 1),
                                'sale' : item.value.sale,
                                'choose_req_id':item.value.chooseReqId,
                                'choose_req_price':item.value.chooseReqPrice,
                                'choose_req_total':item.value.chooseReqTotal,
                                'choose_opt_id':item.value.chooseOptId,
                                'choose_opt_price':item.value.chooseOptPrice,
                                'choose_opt_total':item.value.chooseOptTotal,
                              };
                              controller.editItem(data,item.value.count - 1);
                            },
                            child: Container(
                              height: sizeW20,
                              width: sizeW20,
                              decoration: BoxDecoration(
                                color:  grey3,
                                borderRadius: BorderRadius.circular(sizeW25),
                              ),
                              child:  Center(
                                child: Container(height: 1.5,width: sizeW10,color: Colors.white,),
                              ),
                            ),
                          ),
                          Container(
                            height: sizeH25,
                            margin:  EdgeInsets.only(right: sizeW10,left: sizeW10),
                            child:  Center(
                              child: Text(item.value.count.toString(),style:  TextStyle(fontSize: sizeW18,fontWeight: FontWeight.w500,color: primaryColor)),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              var data = {
                                'item_id' : item.value.id,
                                'price' : item.value.price,
                                'quantity' : item.value.count + 1,
                                'total' : item.value.price  * (item.value.count + 1),
                                'sale' : item.value.sale,
                                'choose_req_id':item.value.chooseReqId,
                                'choose_req_price':item.value.chooseReqPrice,
                                'choose_req_total':item.value.chooseReqTotal,
                                'choose_opt_id':item.value.chooseOptId,
                                'choose_opt_price':item.value.chooseOptPrice,
                                'choose_opt_total':item.value.chooseOptTotal,
                              };
                              controller.editItem(data,item.value.count + 1);
                            },
                            child: Container(
                              height: sizeW20,
                              width: sizeW20,
                              decoration: BoxDecoration(
                                color:  primaryColor,
                                borderRadius: BorderRadius.circular(sizeW25),
                              ),
                              child:  Center(
                                child: Icon(Icons.add,color: Colors.white,size: sizeW15,),
                              ),
                            ),
                          ),
                          
              
                        ],
                      ),
                      SizedBox(height: sizeH5,),
                      GestureDetector(
                        onTap: (){
                          var data = {
                            'item_id' : item.value.id,
                          };
                          controller.deleteItem(data);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset('assets/icons/trash.png',width: sizeW16,height: sizeW16,fit: BoxFit.fill,color:  primaryColor,),
                            SizedBox(width: sizeW5,),
                            Text('Delete'.tr,style: TextStyle(color: primaryColor,fontSize: sizeW14,fontWeight: FontWeight.w600),),
                          ],
                        ),
                      ),
                    ],
                  ):Container(),
                ),
              ],
            ),
          ),
          SizedBox(height: sizeH15,),
        ],
      );
    }).toList();
    return imageSliders;
  }
}
