

import 'package:birdandroid/utility/Address.dart';
import 'package:birdandroid/utility/General.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';
import '../../../../constance.dart';
import '../../../../http/request.dart';
import '../../../../http/url.dart';
import '../../../../model/sections_list_model.dart';
import '../../../../model/stores_list_model.dart';
import '../restaurant_view.dart';

class StoreDataController extends GetxController {
  late TextEditingController searchForm;
  var current = 0.obs;
  var type = ''.obs;
  var titlePage = ''.obs;
  var isSection = false.obs;
  var isStores = false.obs;
  var sectionsData = [].obs;
  var storesData = [].obs;
  //
  var sort = false.obs;
  var rating = false.obs;
  var mins = false.obs;
  var section = '-1'.obs;
  var radioValue = 0.obs;
  var radioValueOld = 0.obs;
  var radioText = ''.obs;
  var radioTextOld = ''.obs;
  var textSearch = ''.obs; 

  var searchSectionId = 0.obs;

  void getStoreDataList() async {
    isStores.value = false;
    isSection.value = false;
    var data = {
      'latitude' : Address.a_lat,
      'longitude' : Address.a_long,
      // 'user_id' : General.id,
      'type' : type.value,
    };

    if(searchSectionId.value >0){
      data.addAll({'section_id':searchSectionId.value.toString()});
    }
    if(textSearch.value.isNotEmpty){
      data.addAll({'word':textSearch.value});
    }

    Request request = Request(url: urlGetStoresType, body: data);
    request.post().then((value) async {
      print("Value data type");
      print(value);
      if (value['status']) {
        SectionsListModel sectionsListModel = SectionsListModel.fromJson(value);
        sectionsData.value = sectionsListModel.data!;
        isSection.value = true;
        print("storesDatastoresDatastoresData");
        print(storesData);
        StoresListModel storesListModel = StoresListModel.fromJson(value);
        storesData.value = storesListModel.data!;
        isStores.value = true;

      }
    }).catchError((onError) {
      print(onError);
    });
  }

  @override
  void onInit() {
    type.value = Get.arguments[0];
    if(type.value == 'restaurant'){
      titlePage.value = 'All restaurants'.tr;
    }
    searchForm = TextEditingController();
    getStoreDataList();
    super.onInit();
  }
  final pageIndexNotifier = ValueNotifier(0);
  page3(modalSheetContext) {
    return SliverWoltModalSheetPage(
      isTopBarLayerAlwaysVisible: true,
      hasTopBarLayer : true,
      topBarTitle:  Text('Sort by'.tr,style: TextStyle(fontSize: sizeW18,fontWeight: FontWeight.w600,color: primaryColor),),
      trailingNavBarWidget: IconButton(
        padding:  EdgeInsets.all(sizeW10),
        icon:  Icon(Icons.close,color: const Color.fromARGB(255, 153, 152, 152),size: sizeW15,),
        onPressed: () {
          Navigator.of(modalSheetContext).pop();
          pageIndexNotifier.value = 0;
        },
      ),
      mainContentSliversBuilder: (_)=> [
        SliverPadding(
          padding: EdgeInsets.all(sizeW10),
          sliver: const SliverToBoxAdapter(
          ),
        ),
        SliverPadding(
          padding:  EdgeInsets.all(sizeW10),
          sliver: SliverToBoxAdapter(
            child: Column(
              children: [
                GestureDetector(
                  onTap: (){
                    radioValueOld.value = 0;
                    radioTextOld.value = '';
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: grey3.withOpacity(0.5)),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Basic arrangement'.tr,
                          style:  TextStyle(
                            fontSize: sizeW14,
                            color: greyOpacityColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                
                        Obx(() => SizedBox(
                          width: sizeW20,
                          child: Radio(
                            value: radioValueOld.value,
                            groupValue: 0,
                            activeColor: primaryColor,
                            onChanged: (value) {
                            },
                          ),
                        ),),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    radioValueOld.value = 0;
                    radioTextOld.value = 'A to Z'.tr;
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: grey3.withOpacity(0.5)),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'A to Z'.tr,
                          style:  TextStyle(
                            fontSize: sizeW14,
                            color: greyOpacityColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                
                        Obx(() => SizedBox(
                          width: sizeW20,
                          child: Radio(
                            value: radioValueOld.value,
                            groupValue: 2,
                            activeColor: primaryColor,
                            onChanged: (value) {
                            },
                          ),
                        ),),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    radioValueOld.value = 3;
                    radioTextOld.value = 'High rating'.tr;
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: grey3.withOpacity(0.5)),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'High rating'.tr,
                          style:  TextStyle(
                            fontSize: sizeW14,
                            color: greyOpacityColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                
                        Obx(() => SizedBox(
                          width: sizeW20,
                          child: Radio(
                            value: radioValueOld.value,
                            groupValue: 3,
                            activeColor: primaryColor,
                            onChanged: (value) {
                            },
                          ),
                        ),),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    radioValueOld.value = 4;
                    radioTextOld.value = 'Preparation time'.tr;
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: grey3.withOpacity(0.5)),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Preparation time'.tr,
                          style:  TextStyle(
                            fontSize: sizeW14,
                            color: greyOpacityColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                
                        Obx(() => SizedBox(
                          width: sizeW20,
                          child: Radio(
                            value: radioValueOld.value,
                            groupValue: 4,
                            activeColor: primaryColor,
                            onChanged: (value) {
                            },
                          ),
                        ),),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding:  EdgeInsets.all(sizeW10),
          sliver: SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(sizeW10),
              color: Colors.white,
              child: MaterialButton(
                elevation: 0,
                color: primaryColor,
                minWidth: Get.width / 1.1,
                height: sizeH50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(sizeW45),
                ),
                onPressed: (){
                  radioValue.value = radioValueOld.value;
                  radioText.value = radioTextOld.value;
                  if(radioValue.value == 2){
                    sortBy();
                  }

                  if(radioValue.value == 3){
                    rateBy();
                  }

                  if(radioValue.value == 4){
                    timeBy();
                  }

                  if(radioValue.value == 0){
                    
                    getStoreDataList();
                  }

                  
                  Get.back();
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: Text(
                  'Apply'.tr,
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
      ],
    );
  }

  sortBy(){
    storesData.sort((a, b) {
      return a.name!.compareTo(b.name!);
    });
  }

  rateBy(){
    storesData.sort((a, b) {
      return b.rateAvg!.compareTo(a.rateAvg!);
    });
  }

  timeBy(){
    storesData.sort((a, b) {
      return b.time!.compareTo(a.time!);
    });
  }

  

  List<Widget> createSliders() {
    List<Widget> imageSliders = storesData.map((item) {
      return Column(
        children: [
          GestureDetector(
            onTap: ()async{
              await Get.to(()=>RestaurantView(storeData: item,),arguments: [item.id,item.userFav]);
              getStoreDataList();
            },
            child: Container(
              height: Get.height  /4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(sizeW25),
                border: Border.all(color:  primaryColor,width: 0.8)
              ),
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: Get.height / 7.9,width: Get.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(sizeW25),
                            topRight: Radius.circular(sizeW25)
                          ),
                          image: DecorationImage(image: NetworkImage(item.cover),fit: BoxFit.cover)
                        ),
                      ),
                      // Image.network(item.cover,height: Get.height / 7.9,width: Get.width,fit: BoxFit.cover,),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color:  const Color.fromARGB(255, 133, 133, 160).withOpacity(.1),
                            borderRadius:  BorderRadius.only(
                              bottomLeft : Radius.circular(sizeW25),
                              bottomRight : Radius.circular(sizeW25),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    width: Get.width / 2,
                                    child: Wrap(
                                      crossAxisAlignment : WrapCrossAlignment.end,
                                      alignment : WrapAlignment.end,
                                      children: [
                                        Text(item.name,style: TextStyle(fontSize: sizeW12,fontWeight: FontWeight.w500,color: primaryColor)),
                                      ],
                                    )),
                                  SizedBox(height: sizeH5,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/marker.png',color:  primaryColor,width: sizeW12,height: sizeW12,),
                                      SizedBox(width: sizeW5,),
                                      Text(item?.km?.toStringAsFixed(2)??"0",style: TextStyle(fontSize: sizeW10,fontWeight: FontWeight.w300,color: primaryColor)),
                                      SizedBox(width: sizeW25,),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(width: sizeW5,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    padding:  EdgeInsets.only(right: sizeW5,left: sizeW5,top: sizeH2,bottom: sizeH2),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(sizeW25),
                                      color:  primaryColor,
                                    ),
                                    child: Center(
                                      child: SizedBox(
                                        width: sizeW65,
                                        height: sizeH10,
                                        child: Wrap(
                                          crossAxisAlignment : WrapCrossAlignment.center,
                                          alignment : WrapAlignment.center,
                                          children: [
                                            Image.asset('assets/dd.png',color:Colors.white,width: sizeW10,height: sizeW10,),
                                            SizedBox(width: sizeW5,),
                                            Text(item?.delevryPrice??"0",
                                            style: TextStyle(fontSize: sizeW10,fontWeight: FontWeight.w400,color: Colors.white,overflow: TextOverflow.ellipsis)),
                                            SizedBox(width: sizeW5,),
                                            Text('SAR'.tr,style: TextStyle(fontSize: sizeW10,fontWeight: FontWeight.w400,color: Colors.white)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  
                                  SizedBox(height: sizeW5,),
                                  SizedBox(
                                    width: sizeW100,
                                    height: sizeH10,
                                    child: Wrap(
                                      children: [
                                        Image.asset('assets/clock.png',color:  primaryColor,width: sizeW10,height: sizeW10,),
                                        SizedBox(width: sizeW5,),
                                        SizedBox(
                                          height: sizeH10,
                                          child: Text('${item.fromTime} - ${item.toTime}',
                                          style: TextStyle(fontSize: sizeW10,fontWeight: FontWeight.w400,color: primaryColor)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: sizeW20,),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Get.height / 11,),
                      Container(
                        width: sizeW50,
                        height: sizeW50,
                        margin:  EdgeInsets.only(left: sizeW20,right: sizeW20),
                        padding:  EdgeInsets.all(sizeW5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(sizeW45),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.black.withOpacity(.1),
                                blurRadius: 15.0,
                                offset:  const Offset(0.0, 0.75)
                            )
                          ],
                          image: DecorationImage(image: NetworkImage(item.logo,),fit: BoxFit.fill)
                        ),
                      ),
                      Container(
                        margin:  EdgeInsets.only(left: sizeW20,right: sizeW20,top: sizeH5),
                        child:  Row(
                          children: [
                            Icon(Icons.star,color: Colors.orange,size: sizeW12,),
                            SizedBox(width: sizeW5,),
                            Text(item.rateAvg?.toString()??"0",style: TextStyle(fontSize: sizeW10,fontWeight: FontWeight.w500,color: primaryColor)),
                            SizedBox(width: sizeW5,),
                            SizedBox(
                              width: sizeW50,
                              child: Text('(${item.rateCount.toString()})',style: TextStyle(fontSize: sizeW10,fontWeight: FontWeight.w300,color: primaryColor,overflow: TextOverflow.ellipsis))),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: sizeH15,),
        ],
      );
    }).toList();
    return imageSliders;
  }

  @override
  void onClose() {
    searchForm.dispose();
    super.onClose();
  }
}
