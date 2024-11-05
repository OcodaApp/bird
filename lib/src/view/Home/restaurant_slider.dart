// ignore_for_file: must_be_immutable, unnecessary_null_comparison, prefer_typing_uninitialized_variables

import 'package:birdandroid/utility/Address.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import '../../../constance.dart';
import '../../controller/lang_controller.dart';
import '../Cart/cart_view.dart';
import '../Restaurants/controller/restaurant_page_controller.dart';
import '../Restaurants/products_search_page.dart';

class RestaurantSlider extends StatelessWidget {
  RestaurantSlider({Key? key,this.storeData}) : super(key: key);
  final LangController langcontroller = Get.put(LangController());
  final RestaurantPageController controller = Get.put(RestaurantPageController());
  var storeData;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: ()async{
        controller.getStoreDataAndProductsList();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(Get.height / 3.5),
          child: FadeInDown(
            child: SizedBox(
              child: Stack(
                children: [
                  Container(
                    height: Get.height / 4,
                    decoration:  BoxDecoration(
                      image: DecorationImage(
                            image: NetworkImage(storeData['cover_url']),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: sizeH100,
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
                              ),
                              child: Padding(
                                padding:  EdgeInsets.only(right: langcontroller.appLocale == 'ar'? sizeW5:0,left: langcontroller.appLocale == 'en'? sizeW5:0),
                                child: Center(child: Icon(Icons.arrow_back_ios,color: greyOpacityColor,size: sizeW15,)),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Obx(() => GestureDetector(
                                onTap: (){
                                  controller.addFav();
                                },
                                child: Container(
                                  width: sizeW25,
                                  height: sizeW25,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(sizeW25),
                                  ),
                                  child: Center(child: Image.asset('assets/icons/userFav.png',width: sizeW25,height: sizeW25,color: controller.userFav.value == 0? primaryColor:Colors.red),),
                                ),
                              ),),
                              SizedBox(width: sizeW5,),
                              GestureDetector(
                                onTap: (){
                                },
                                child: Container(
                                  width: sizeW25,
                                  height: sizeW25,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(sizeW25),
                                  ),
                                  child: Center(child: Image.asset('assets/icons2/share2.png',width: sizeW25,height: sizeW25,),),
                                ),
                              ),
                              SizedBox(width: sizeW5,),
                              GestureDetector(
                                onTap: ()async{
                                  await Get.to(()=>ProductsSearch(),arguments: [controller.productsData]);
                                  controller.getBasketWithStore();
                                },
                                child: Container(
                                  width: sizeW25,
                                  height: sizeW25,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(sizeW25),
                                  ),
                                  child: Center(child: Image.asset('assets/icons/searchpage.png',width: sizeW15,height: sizeW15,),),
                                ),
                              ),
                              
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: Get.height / 5.1,
                      margin:  EdgeInsets.only(right: sizeW10,left: sizeW10),
                      padding:  EdgeInsets.all(sizeW20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(sizeW25),
                        border: Border.all(color: primaryColor,width: 0.5)
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: sizeW65,
                                height: sizeW65,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(sizeW45),
                                  image: DecorationImage(image: NetworkImage(storeData['logo_url'],),fit: BoxFit.fill)
                                ),
                              ),
                              SizedBox(width: sizeW20,),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(storeData['name'],style: TextStyle(fontSize: sizeW18,fontWeight: FontWeight.w600,color: primaryColor)),
                                    SizedBox(height: sizeH2,),
                                    Text(storeData['desc'],style: TextStyle(fontSize: sizeW14,fontWeight: FontWeight.w400,color: primaryColor),overflow: TextOverflow.ellipsis,),
                                    SizedBox(height: sizeH2,),
                                    Wrap(
                                      children: [
                                        Icon(Icons.star,color: Colors.orange,size: sizeW12,),
                                        SizedBox(width: sizeW5,),
                                        Text(storeData['rate_avg'].toString(),style: TextStyle(fontSize: sizeW12,fontWeight: FontWeight.w500,color: primaryColor)),
                                        SizedBox(width: sizeW5,),
                                        SizedBox(
                                          height: sizeH8,
                                          width: sizeW80,
                                          child: Row(
                                            children: [
                                              Text(storeData['rate_count'].toString(),style: TextStyle(fontSize: sizeW10,fontWeight: FontWeight.w300,color: primaryColor),overflow: TextOverflow.ellipsis),
                                              Text('Reviews'.tr,
                                                style: TextStyle(fontSize: sizeW10,fontWeight: FontWeight.w300,color: primaryColor),overflow: TextOverflow.ellipsis
                                              ),
                                            ],
                                          )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: sizeH15,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('Delivery fee'.tr,style: TextStyle(fontSize: sizeW10,fontWeight: FontWeight.w300,color: greyOpacityColor)),
                                  SizedBox(height: sizeH2,),
                                  Row(
                                    children: [
                                      Image.asset('assets/dd.png',color:primaryColor,width: sizeW10,height: sizeW10,),
                                      SizedBox(width: sizeW5,),
                                      Text(storeData['delivery_price'].toString(),style: TextStyle(fontSize: sizeW12,fontWeight: FontWeight.w500,color: primaryColor)),
                                      Text('SAR'.tr,style: TextStyle(fontSize: sizeW12,fontWeight: FontWeight.w500,color: primaryColor)),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                height: sizeH20,
                                width: 1,
                                color: grey3,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('Nearest branch'.tr,style: TextStyle(fontSize: sizeW10,fontWeight: FontWeight.w300,color: greyOpacityColor)),
                                  SizedBox(height: sizeH2,),
                                  Row(
                                    children: [
                                      Image.asset('assets/marker.png',color:primaryColor,width: sizeW10,height: sizeW10,),
                                      SizedBox(width: sizeW5,),
                                      Text(controller.calculateDistance(
                                        double.parse(storeData['latitude']),
                                        double.parse(storeData['longitude']),
                                        double.parse(Address.a_lat),
                                        double.parse(Address.a_long),
                                      ).toStringAsFixed(2),style: TextStyle(fontSize: sizeW12,fontWeight: FontWeight.w500,color: primaryColor)),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                height: sizeH20,
                                width: 1,
                                color: grey3,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('Opening time'.tr,style: TextStyle(fontSize: sizeW10,fontWeight: FontWeight.w300,color: greyOpacityColor)),
                                  SizedBox(height: sizeH2,),
                                  Row(
                                    children: [
                                      Image.asset('assets/clock.png',color:primaryColor,width:sizeW10,height: sizeW10,),
                                      SizedBox(width: sizeW5,),
                                      Text('${storeData['from_time']}- ${storeData['to_time']}',style: TextStyle(fontSize: sizeW12,fontWeight: FontWeight.w500,color: primaryColor)),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Obx(() => controller.basketStoreCount.value > 0 ?FadeInUp(
          child:GestureDetector(
            onTap: ()async{
              if(controller.basketStoreCount.value > 0){
                await Get.to(()=> CartView());
                controller.getBasketWithStore();
              }
            },
            child: Container(
              width: Get.width / 1.5,
              height: sizeH50,
              margin: EdgeInsets.only(right: sizeW20,left: sizeW20,bottom: sizeH10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(sizeW45),
                color:  primaryColor,
              ),
              child: 
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'View Cart'.tr,
                      style:  TextStyle(
                        fontSize: sizeW22,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
          
                    Text(
                      '${controller.basketStoreTotal.value} ${'SAR'.tr}',
                      style:  TextStyle(
                        fontSize: sizeW22,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )
            ),
          ),
        ):Container(height: 0,)),
        body: Container(
          width: Get.width,
          height: Get.height,
          padding: EdgeInsets.all(sizeW10),
          child: Obx(() => ListView(
            children:  [
              SizedBox(height: sizeH10,),
              SizedBox(
                height: sizeH50,
                child: Row(
                  children: [
                    controller.isSales.value ?  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('Fire Offers'.tr,style: TextStyle(fontSize: sizeW18,fontWeight: FontWeight.w500,color: primaryColor)),
                            SizedBox(width: sizeW10,),
                            Image.asset('assets/nar.png',width: sizeW12,height: sizeH15,),
                          ],
                        ),
                        Container(
                          height: sizeH5,
                          width: sizeW65,
                          margin:EdgeInsets.only(top: sizeH5),
                          color: primaryColor,
                        )
                      ],
                    ):Container(),
                    SizedBox(width: sizeW15,),
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.typesData.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: (){
                              Scrollable.ensureVisible(controller.keyCap[index].currentContext!);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(controller.typesData[index].title,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: greyOpacityColor)),
                                    SizedBox(width: sizeW15,),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              controller.isSales.value ? Row(
                children: [
                  Text('Fire Offers'.tr,style: TextStyle(fontSize: sizeW18,fontWeight: FontWeight.w600,color: primaryColor)),
                  SizedBox(width: sizeW10,),
                  Image.asset('assets/nar.png',width: sizeW12,height: sizeH15,),
                ],
              ):Container(),
              SizedBox(height: sizeH20,),
              // sales products,
              Obx(() => controller.isSales.value? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: controller.salesData.isNotEmpty? controller.createSales():[
                  Container()
                ],
              ):Container(),),
              // end sales
              Obx(() => controller.istypes.value? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: controller.typesData.isNotEmpty? controller.createTypes():[
                  Container()
                ],
              ):Container(),),
            ],
          ),),
        ),
      ),
    );
  }
}
