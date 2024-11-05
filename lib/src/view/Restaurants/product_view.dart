// ignore_for_file: must_be_immutable, unnecessary_null_comparison, prefer_typing_uninitialized_variables


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import '../../../constance.dart';
import '../../controller/lang_controller.dart';
import 'controller/product_controller.dart';

class ProductView extends StatelessWidget {
  ProductView({Key? key,this.product,this.reqs,this.opts}) : super(key: key);
  var product;
  List? reqs = [],opts = [];
  final ProductController controller = Get.put(ProductController());
  final LangController langcontroller = Get.put(LangController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: FadeInUp(
        child: GestureDetector(
          onTap: (){
            controller.countPrice.value = (controller.count.value * double.parse(product.price.toString()));
            var data = {
              'store_id' : product.storeId,
              'product_id' : product.id,
              'price' : product.price,
              'quantity' : controller.count.value,
              'total' : controller.countPrice.value ,
              'product_name' : product.name,
              'product_desc' : product.desc,
              'type' : product.type,
              'image' : product.image,
              'sale' : product.sale,
            };

            if(controller.chooseReqId.value  >0){
              data.addAll({
                'choose_req_id':controller.chooseReqId.value,
                'choose_req_price':controller.chooseReqPrice.value,
                'choose_req_total':controller.chooseReqTotal.value,
              });
            }

            if(controller.chooseOptId.value  >0){
              data.addAll({
                'choose_opt_id':controller.chooseOptId.value,
                'choose_opt_price':controller.chooseOptPrice.value,
                'choose_opt_total':controller.chooseOptTotal.value,
              });
            }
            if(product.reqs.length <1 && product.opts.length <1){
              controller.checkBasketStore(product.storeId,data);
            }

            if(product.reqs.length >0 && controller.chooseReqId.value == 0){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Choose your meal".tr)));
            }

            if(product.reqs.length >0 && controller.chooseReqId.value > 0){
              controller.checkBasketStore(product.storeId,data);
            }
          },
          child:  Container(
            width: Get.width / 1.5,
            height: sizeH50,
            margin:  EdgeInsets.all(sizeW20),
            padding: EdgeInsets.only(right: sizeW25,left: sizeW25),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(sizeW45),
              color: primaryColor,
            ),
            child: Center(
              child: Text(
                'Add to cart'.tr,
                style:  TextStyle(
                  fontSize: sizeW22,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: ListView(
          children:  [
            Stack(
              children: [
                Padding(
                  padding:  EdgeInsets.only(top: sizeH35),
                  child: Center(child: FadeInLeft(child: Image.network(product.image,fit: BoxFit.contain,width: Get.width / 1.5,height: Get.height /4.4,))),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: sizeH35,
                    margin: EdgeInsets.only(top: sizeH5,right: sizeW10,left: sizeW10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Get.back();
                          },
                          child: Container(
                            width: sizeW25,
                            height: sizeW25,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(sizeW25),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: const Color.fromARGB(31, 153, 152, 152).withOpacity(0.2),
                                  offset: const Offset(0, 0),
                                  blurRadius: 10.0,
                                )
                              ],
                            ),
                            child: Padding(
                              padding:  EdgeInsets.only(right: langcontroller.appLocale == 'ar'? sizeW5:0,left: langcontroller.appLocale == 'en'? sizeW5:0),
                              child: Center(child: Icon(Icons.arrow_back_ios,color: greyOpacityColor,size: sizeW15,)),
                            ),
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: sizeH25,),
            Container(
              padding: EdgeInsets.only(bottom: sizeH20,right: sizeW15,left: sizeW15),
              margin: EdgeInsets.only(bottom: sizeH20),
              decoration:  BoxDecoration(
                color: Colors.white,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: const Color.fromARGB(31, 153, 152, 152).withOpacity(0.1),
                    offset: const Offset(15.0, 20.0),
                    blurRadius: 22.0,
                  )
                ],
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: Get.width / 1.6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product.name,style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w500,color: primaryColor)),
                        SizedBox(height: sizeH5,),
                        Text(product.desc,style: TextStyle(fontSize: sizeW12,fontWeight: FontWeight.w300,color: greyOpacityColor)),
                        SizedBox(height: sizeH5,),
                        Text('${product.price} ${'SAR'.tr}',style: TextStyle(fontSize: sizeW14,fontWeight: FontWeight.w500,color: primaryColor)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: (){
                            if(controller.count.value >1){
                              controller.count.value = controller.count.value - 1;
                            }
                          },
                          child: Container(
                            height: sizeW25,
                            width: sizeW25,
                            decoration: BoxDecoration(
                              color: grey3,
                              borderRadius: BorderRadius.circular(sizeW25),
                            ),
                            child:  Center(
                              child: Container(height: 1.5,width: sizeW10,color: Colors.white,),
                            ),
                          ),
                        ),
                        Obx(() => Container(
                          height: sizeH25,
                          margin: EdgeInsets.only(right: sizeW10,left: sizeW10),
                          child:  Center(
                            child: Text(controller.count.value.toString(),
                            style:  TextStyle(fontSize: sizeW18,fontWeight: FontWeight.w500,color: primaryColor)),
                          ),
                        ),),
                        GestureDetector(
                          onTap: (){
                            if(controller.count.value< 999){
                              controller.count.value = controller.count.value + 1;
                            }
                          },
                          child: Container(
                            height: sizeW25,
                            width: sizeW25,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(sizeW25),
                            ),
                            child: Center(
                              child: Icon(Icons.add,color: Colors.white,size: sizeW20,),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            product.reqs.length > 0?Container(
              margin: EdgeInsets.only(right: sizeW10,left: sizeW10),
              child: Column(
                children: [
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Choose your meal'.tr,style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w500,color: primaryColor)),
                      Container(
                        padding: EdgeInsets.only(right: sizeW15,left: sizeW15,bottom: sizeH5,top: sizeH5),
                        decoration: BoxDecoration(
                          color: primaryTowColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child:  Center(
                          child: Text('required'.tr,style: TextStyle(fontSize: sizeW12,fontWeight: FontWeight.w500,color: primaryTowColor)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: sizeH15,),
                  Column(children: createCahooseReq(),),
                  
                ],
              ),
            ):Container(),
            SizedBox(height: product.reqs.length > 0?sizeH10:0,),
            product.opts.length > 0? Container(
              margin:  EdgeInsets.only(right: sizeW10,left: sizeW10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text('Extras'.tr,style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w500,color: primaryColor)),
                      Container(
                        padding:  EdgeInsets.only(right: sizeW15,left: sizeW15,bottom: sizeH5,top: sizeH5),
                        decoration: BoxDecoration(
                          color:  grey5.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(sizeW25),
                        ),
                        child:  Center(
                          child: Text('Optional'.tr,style: TextStyle(fontSize: sizeW12,fontWeight: FontWeight.w500,color: greyOpacityColor)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: sizeH15,),
                  Column(children: createCahooseOpt(),),
                ],
              ),
            ):Container(),
          ],
        ),
      ),
    );
  }

  List<Widget> createCahooseReq() {
    List<Widget> imageSliders = reqs!.asMap().entries.map((item) {
      return Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: sizeH5),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: item.key == reqs!.length - 1?whitecolor:grey3.withOpacity(0.5)),
              ),
            ),
            child: Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                  GestureDetector(
                    onTap: (){
                      controller.chooseReqId.value = item.value['id'];
                      if(item.value['plus_price'] != null && int.parse(item.value['plus_price']) > 0){
                        controller.chooseReqPrice.value = int.parse(item.value['plus_price']);
                        controller.chooseReqTotal.value = int.parse(item.value['plus_price']) * controller.count.value;
                      }
                      
                    },
                    // child: Text(item.value['plus_price']),
                    child: SizedBox(
                      width: Get.width /1.2,
                      child: Text(
                      item.value['plus_price'] != null && int.parse(item.value['plus_price']) > 0? '${item.value['name_${langcontroller.appLocale}']} (+${item.value['plus_price']} ${'SAR'.tr})':
                      '${item.value['name_${langcontroller.appLocale}']}',
                        style:  TextStyle(
                          fontSize: sizeW14,
                          color: greyOpacityColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
              
                GestureDetector(
                  onTap: (){
                    controller.chooseReqId.value = item.value['id'];
                    if(item.value['plus_price'] != null && int.parse(item.value['plus_price']) > 0){
                      controller.chooseReqPrice.value = int.parse(item.value['plus_price']);
                      controller.chooseReqTotal.value = int.parse(item.value['plus_price']) * controller.count.value;
                    }
                  },
                  child: SizedBox(
                    width: sizeW20,
                    child: Radio(
                      value: controller.chooseReqId.value,
                      groupValue: item.value['id'],
                      activeColor: primaryColor,
                      onChanged: (value) {
                      },
                    ),
                  ),
                ),
              ],
            ),)
          ),
          SizedBox(height: item.key == reqs!.length - 1? 0: sizeH5,),
        ],
      );
    }).toList();
    return imageSliders;
  }

  List<Widget> createCahooseOpt() {
    List<Widget> imageSliders = opts!.asMap().entries.map((item) {
      return Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: sizeH5),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: item.key == reqs!.length - 1?whitecolor:grey3.withOpacity(0.5)),
              ),
            ),
            child: Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                  GestureDetector(
                    onTap: (){
                      controller.chooseOptId.value = item.value['id'];
                      if(item.value['plus_price'] != null && int.parse(item.value['plus_price']) > 0){
                        controller.chooseOptPrice.value = int.parse(item.value['plus_price']);
                        controller.chooseOptTotal.value = int.parse(item.value['plus_price']) * controller.count.value;
                      }
                    },
                    child: SizedBox(
                      width: Get.width /1.2,
                      child: Text(
                      item.value['plus_price'] != null && int.parse(item.value['plus_price']) > 0? '${item.value['name_${langcontroller.appLocale}']} (+${item.value['plus_price']} ${'SAR'.tr})':
                      '${item.value['name_${langcontroller.appLocale}']}',
                        style:  TextStyle(
                          fontSize: sizeW14,
                          color: greyOpacityColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
              
                GestureDetector(
                  onTap: (){
                    controller.chooseOptId.value = item.value['id'];
                    if(item.value['plus_price'] != null && item.value['plus_price'] > 0){
                      controller.chooseOptPrice.value = int.parse(item.value['plus_price']);
                      controller.chooseOptTotal.value = int.parse(item.value['plus_price']) * controller.count.value;
                    }
                  },
                  child: SizedBox(
                    width: sizeW20,
                    child: Radio(
                      value: controller.chooseOptId.value,
                      groupValue: item.value['id'],
                      activeColor: primaryColor,
                      onChanged: (value) {
                      },
                    ),
                  ),
                ),
              ],
            ),)
          ),
          SizedBox(height: item.key == reqs!.length - 1? 0: sizeH5,),
        ],
      );
    }).toList();
    return imageSliders;
  }
}
