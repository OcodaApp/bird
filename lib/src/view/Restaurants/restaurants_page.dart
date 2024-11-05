// ignore_for_file: must_be_immutable, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';
import '../../../constance.dart';
import '../../controller/lang_controller.dart';
import 'controller/store_data_controller.dart';

class RestaurantPage extends StatelessWidget {
  String? type;
  RestaurantPage({Key? key,this.type}) : super(key: key);
  final StoreDataController controller = Get.put(StoreDataController());
  final LangController langcontroller = Get.put(LangController());
  @override
  Widget build(BuildContext context) {
    final pageIndexNotifier = ValueNotifier(0);
    return RefreshIndicator(
      onRefresh: ()async{
        controller.searchForm.clear();
        controller.textSearch.value = '';
        controller.radioValue.value = 0;
        controller.radioValueOld.value = 0;
        controller.radioText.value = '';
        controller.radioTextOld.value = '';
        controller.searchSectionId.value = 0;
        controller.section.value = '-1';
        controller.sort.value = false;
        controller.getStoreDataList();
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
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        Get.back();
                      },
                      child: const Icon(Icons.arrow_back_ios,color: blackolor,),
                    ),
                    SizedBox(width: sizeW10,),
                    Expanded(
                      child: Form(
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType : TextInputType.name,
                          controller: controller.searchForm,
                          onFieldSubmitted: (value){
                            controller.getStoreDataList();
                          },
                          onChanged: (value)async{
                            controller.textSearch.value = value;
                          },
                          decoration:  InputDecoration(
                            isDense: true,
                            hintText: 'searchHome'.tr,
                            contentPadding:  EdgeInsets.only(
                              top: sizeH10,
                              bottom: sizeH10,
                              right: 0,
                              left: 0,
                            ),
                            border:   OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(sizeW45)),
                              borderSide: const BorderSide(
                                color: grey3,
                                width: 0.8,
                              ),
                            ),
                            prefixIcon: Image.asset(
                              "assets/search2.png",
                              color:  primaryColor,
                              width: sizeW10,
                              height: sizeH10,
                            ),
                            hintStyle:   TextStyle(
                              fontSize: sizeW14,
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
                            color: grey3,
                            fontWeight: FontWeight.w300,
                          ),
                          validator: (value) {
                          
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: sizeH15,),
              Obx(() => SizedBox(
                height: sizeH50,
                child: ListView.builder(
                  itemCount: controller.sectionsData.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: (){
                        controller.isStores.value = false;
                        controller.searchSectionId.value = controller.sectionsData[index].id;
                        controller.section.value = controller.sectionsData[index].id.toString();
                        controller.sort.value = true;
                        controller.getStoreDataList();
                      },
                      child: Stack(
                        children: [
                          Obx(() => Container(
                            height: sizeH30,
                            margin:  EdgeInsets.only(top: sizeH8,left: sizeW10,right: sizeW10),
                            padding:  EdgeInsets.all(sizeW5),
                            decoration: BoxDecoration(
                              color: controller.section.value == controller.sectionsData[index].id.toString() ?  primaryColor.withOpacity(0.1):Colors.white,
                              borderRadius: BorderRadius.circular(sizeW25),
                              border: Border.all(color:  const Color(0xFF7D7D7D).withOpacity(.2))
                            ),
                            child:  Row(
                              children: [
                                SizedBox(width: sizeW25,),
                                Text(controller.sectionsData[index].title,style:  TextStyle(fontSize: sizeW14,fontWeight: FontWeight.w300,color: greyOpacityColor)),
                                SizedBox(width: sizeW15,),
                              ],
                            ),
                          ),),
                          langcontroller.appLocale == 'en'?  Positioned(
                            top: 0,
                            bottom: 5,
                            left: -15,
                            child: Container(
                              padding:  const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                              alignment: Alignment.center,
                              child: Image.network(
                                controller.sectionsData[index].icon,
                                height: sizeW50,
                                width: sizeW50,
                              ),
                            ),
                          ):Positioned(
                            top: 0,
                            bottom: 5,
                            right: -15,
                            child: Container(
                              padding:  const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                              alignment: Alignment.center,
                              child: Image.network(
                                controller.sectionsData[index].icon,
                                height: sizeW50,
                                width: sizeW50,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),),
              SizedBox(height: sizeH5,),
              Obx(() => Visibility(
                visible: controller.sort.value,
                child: SizedBox(
                  height: sizeH30,
                  child: ListView.builder(
                    itemCount: 1,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              WoltModalSheet.show<void>(
                                pageIndexNotifier: pageIndexNotifier,
                                context: context,
                                pageListBuilder: (modalSheetContext) {
                                  return [
                                    controller.page3(modalSheetContext),
                                  ];
                                },
                                modalTypeBuilder: (context) {
                                  return WoltModalType.bottomSheet();
                                },
                                onModalDismissedWithBarrierTap: () {
                                  debugPrint('Closed modal sheet with barrier tap');
                                  Navigator.of(context).pop();
                                  pageIndexNotifier.value = 0;
                                },
                                // minPageHeight: 0.0,
                                // maxPageHeight: Get.height /2,
                              );
                            },
                            child: Obx(() => Container(
                              padding:  EdgeInsets.only(right: sizeW10,left: sizeW10,bottom: sizeH5,top: sizeH5),
                              decoration: BoxDecoration(
                                color: controller.radioValue.value > 0? primaryTowColor:Colors.white,
                                borderRadius: BorderRadius.circular(sizeW25),
                                border: Border.all(color:  primaryTowColor)
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/frame.png',width: 16,height: 16,color: controller.radioValue.value > 0? Colors.white: primaryTowColor,),
                                     SizedBox(width: sizeW5,),
                                    Obx(() => 
                                      controller.radioValue.value > 0? Text(
                                        controller.radioText.value == ''?'Sort by'.tr:controller.radioText.value,
                                        style:  TextStyle(fontSize: sizeW14,fontWeight: FontWeight.w300,color: Colors.white),
                                      ):Text(
                                        controller.radioText.value == ''?'Sort by'.tr:controller.radioText.value,
                                        style:  TextStyle(fontSize: sizeW14,fontWeight: FontWeight.w300,color: primaryTowColor),
                                      ),
                                    ),
                                     SizedBox(width: sizeW5,),
                                    Image.asset('assets/arwo.png',width: 12,height: 6,color: controller.radioValue.value > 0? Colors.white: primaryTowColor),
                                  ],
                                ),
                              ),
                            ),),
                          ),
                          SizedBox(width: sizeW5,),
                          GestureDetector(
                            onTap: (){
                              if(!controller.rating.value){
                                controller.mins.value = false;
                                controller.radioValue.value = 0;
                                controller.radioValueOld.value = 0;
                                controller.radioText.value = '';
                                controller.radioTextOld.value = '';
                                controller.searchSectionId.value = 0;
                                controller.rating.value = true;
                                controller.rateBy();
                              }else{
                                controller.rating.value = false;
                                controller.getStoreDataList();
                              }
                            },
                            child: Obx(() => Container(
                              padding:  EdgeInsets.only(right: sizeW10,left: sizeW10,bottom: sizeH5,top: sizeH5),
                              decoration: BoxDecoration(
                                color: controller.rating.value ? primaryTowColor:Colors.white,
                                borderRadius: BorderRadius.circular(sizeW25),
                                border: Border.all(color:  primaryTowColor)
                              ),
                              child:  Center(
                                child:  Row(
                                  children: [
                                    Text(
                                      'Rating'.tr,
                                      style: TextStyle(fontSize: sizeW14,fontWeight: FontWeight.w300,color: !controller.rating.value ? primaryTowColor:whitecolor)
                                    ),
                                    Text(
                                      ' 4.0+',
                                      style: TextStyle(fontSize: sizeW14,fontWeight: FontWeight.w300,color: !controller.rating.value ? primaryTowColor:whitecolor)
                                    ),
                                  ],
                                ),
                              ),
                            ),),
                          ),
                          SizedBox(width: sizeW5,),
                          GestureDetector(
                            onTap: (){
                              if(!controller.mins.value){
                                controller.mins.value = true;
                                controller.rating.value = false;
                                controller.radioValue.value = 0;
                                controller.radioValueOld.value = 0;
                                controller.radioText.value = '';
                                controller.radioTextOld.value = '';
                                controller.searchSectionId.value = 0;
                                controller.timeBy();
                              }else{
                                controller.mins.value = false;
                                controller.getStoreDataList();
                              }
                            },
                            child: Obx(() => Container(
                              padding:  EdgeInsets.only(right: sizeW10,left: sizeW10,bottom: sizeH5,top: sizeH5),
                              decoration: BoxDecoration(
                                color: controller.mins.value ? primaryTowColor:Colors.white,
                                borderRadius: BorderRadius.circular(sizeW25),
                                border: Border.all(color:  primaryTowColor)
                              ),
                              child:  Center(
                                child:  Text(
                                  'Under 30 mins'.tr,
                                  style: TextStyle(fontSize: sizeW14,fontWeight: FontWeight.w300,color: !controller.mins.value ? primaryTowColor:whitecolor)
                                ),
                              ),
                            ),),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),),
              SizedBox(height: sizeH5,),
              //
              Obx(() => Visibility(
                visible: controller.sort.value ? false:true,
                child:  Text(
                  controller.titlePage.value,
                  style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w500,color: primaryColor)),
              ),),
              SizedBox(height: sizeH10,),
              Obx(() => controller.isStores.value? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: controller.storesData.isNotEmpty? controller.createSliders():[
                  Container()
                ],
              ):Container(),),
              
              
            ],
          ),
        ),
      ),
    );
  }
}
