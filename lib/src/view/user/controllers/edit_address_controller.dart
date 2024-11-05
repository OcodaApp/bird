// ignore_for_file: avoid_print, empty_catches

import 'package:birdandroid/utility/General.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_place/google_place.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';
import '../../../../constance.dart';
import '../../../controller/lang_controller.dart';
import '../../../controller/tabbar_controller.dart';
import 'add_address_controller.dart';
import 'map_search_controller.dart';

class EditAddressController extends GetxController {
  final LangController _langController = Get.put(LangController());
  final TabBarController tabController = Get.put(TabBarController());
  final SeaConController searchController = Get.put(SeaConController());
  var googlePlace = GooglePlace("AIzaSyATuEq0qRHi33CVV_q9_RwuQ6JRm7C0fWY");
  late DetailsResult detailsResult;
  late TextEditingController locationName= TextEditingController();
  late TextEditingController street= TextEditingController();
  late TextEditingController city= TextEditingController();
  late TextEditingController building= TextEditingController();
  late TextEditingController flat= TextEditingController();
  late TextEditingController floor= TextEditingController();
  var addressText = ''.obs;
  var lat = 0.0.obs;
  var long = 0.0.obs;
  var addresId = 0.obs;

  @override
  void onInit() {
    print("Get.arguments[2].id");
    print(Get.arguments[2].id);
    addresId.value = Get.arguments[2].id;
    lat.value = Get.arguments[0];
    long.value = Get.arguments[1];
    addressText.value = Get.arguments[2].addressText;
    locationName.text = Get.arguments[2].title;
    street.text = Get.arguments[2].street;
    city.text = Get.arguments[2].city;
    building.text = Get.arguments[2].building;
    flat.text = Get.arguments[2].flat;
    floor.text = Get.arguments[2].floor;
    super.onInit();
  }

  @override
  void onClose() {
    locationName.dispose();
    street.dispose();
    city.dispose();
    building.dispose();
    flat.dispose();
    floor.dispose();
    super.onClose();
  }
  

  // locations
  getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    print(serviceEnabled);
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    ).then((Position position) {
      General().setlongitude(position.longitude);
      General().setlatitude(position.latitude);
    }).catchError((e) {
      // getCurrentLocation();
    });
  }


  List predictions = [].obs;
  var isSearch = false.obs;

  page1(BuildContext modalSheetContext) {
    isSearch.value = false;
    predictions.clear();
    return WoltModalSheetPage(
      navBarHeight : 1,
      topBar : Container(color: primaryColor.withOpacity(.1),),
      hasSabGradient: false,
      stickyActionBar: Container(
        padding: EdgeInsets.only(top: sizeH15,bottom: sizeH15),
        margin: EdgeInsets.only(right: sizeW15,left: sizeW15),
        decoration :  const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: grey3,
              width: 0.5,
            ),
          ),
        ),
        child:  Row(
          children: [
            GestureDetector(
              onTap: (){
                Get.back();
              },
              child: Text(
                'Close'.tr,
                style:  TextStyle(
                  fontSize: sizeW16,
                  color: primaryColor,
                  fontWeight: FontWeight.w500,
                  
                ),
              ),
            ),
          ],
        ),
      ),
      // topBarTitle: const Text('Pagination'),
      isTopBarLayerAlwaysVisible: false,
      child: SizedBox(
        height: Get.height / 2,
        child:  ListView(
          children:  [
            Container(
              padding:  EdgeInsets.only(top: sizeH40,right: sizeW15,left: sizeW15,bottom: sizeH20),
              color: primaryColor.withOpacity(.1),
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    TextField(
                    autofocus: true,
                    enabled: true,
                    cursorColor : primaryColor,
                    onChanged: (word) async {
                      isSearch.value = false;
                      searchController.chacngeData(word).then((value) {
                        predictions = value;
                        isSearch.value = true;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'search'.tr,
                      contentPadding: const EdgeInsets.only(top: 0,bottom: 0,right: 0,left: 0,),
                      prefix: Padding(
                        padding:  EdgeInsets.only(right: _langController.appLocale =='ar'?0:  sizeW15,left: _langController.appLocale =='ar'?sizeW15:0),
                        child: Image.asset(
                          "assets/cc.png",
                          color: primaryColor,
                          width: sizeW16,
                          height: sizeW18,
                        ),
                      ),
                      enabledBorder:  const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: grey3,
                          width: 0.5,
                        ),
                      ),
                      focusedBorder:  const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: grey3,
                          width: 0.5,
                        ),
                      ),
                      border:  const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: grey3,
                          width: 0.5,
                        ),
                      ),
                      hintStyle:  TextStyle(
                        fontSize: sizeW16,
                        color: primaryColor.withOpacity(0.3),
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  SizedBox(height: sizeH10,),
                  GestureDetector(
                    onTap: (){
                      isSearch.value = false;
                      Get.back();
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/marker.png",
                          color: primaryColor,
                          width: sizeW16,
                          height: sizeH18,
                        ),
                        SizedBox(width: sizeW15,),
                        Text(
                          'Choose on map'.tr,
                          style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w500,color: primaryColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: sizeH25,),
            Obx(() => SizedBox(
              height: Get.height /5,
              child: !isSearch.value ?Container(
              ):SizedBox(
                height: Get.height /5,
                child: ListView.builder(
                  itemCount: predictions.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async{
                        FocusManager.instance.primaryFocus!.unfocus();
                        var result = await googlePlace.details.get(
                            predictions[index]['place_id'],
                            language: _langController.appLocale,
                          );
                        if (result != null && result.result != null) {
                          detailsResult = result.result!;
                          
                          lat.value = detailsResult.geometry!.viewport!.southwest!.lat!;
                          long.value = detailsResult.geometry!.viewport!.southwest!.lng!;
                          General().setlongitude(long.value);
                          General().setlatitude(lat.value);
                          General().getlatitude();
                          General().getlongitude();
                          General().getUserData().then((val){
                            Get.back();
                          });
                          
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: sizeW15, right: sizeW15,bottom: sizeH10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: sizeW15,
                              child: Image.asset(
                                "assets/marker.png",
                                color: primaryColor,
                                width: sizeW16,
                                height: sizeH18,
                              ),
                            ),
                            
                            SizedBox(
                              width: sizeW5,
                            ),
                            Expanded(
                              child: Text(
                                predictions[index]['description'],
                                style: TextStyle(
                                  color: blackolor.withOpacity(0.6),
                                  fontSize: sizeW14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),),
            SizedBox(height: sizeH100,),
          ],
        ),
      ),
    );
  }

  var pageIndexNotifier = 0.obs;
  final _formKey = GlobalKey<FormState>();
  var defaultLocation = 0.obs;
  page3(BuildContext modalSheetContext) {
    return SliverWoltModalSheetPage(
      isTopBarLayerAlwaysVisible: true,
      hasTopBarLayer : true,
      topBarTitle:  Text('location'.tr,style: TextStyle(fontSize: sizeW18,fontWeight: FontWeight.w600,color: primaryColor),),
      trailingNavBarWidget: IconButton(
        padding:  EdgeInsets.all(sizeW10),
        icon: const Icon(Icons.close,color: Color.fromARGB(255, 153, 152, 152),size: 15,),
        onPressed: () {
          Navigator.of(modalSheetContext).pop();
          pageIndexNotifier.value = 0;
        },
      ),
      mainContentSliversBuilder: (_)=>[
         SliverPadding(
          padding: EdgeInsets.all(sizeW10),
          sliver: const SliverToBoxAdapter(
          ),
        ),
        SliverPadding(
          padding:  EdgeInsets.all(sizeW10),
          sliver: SliverToBoxAdapter(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('Location name'.tr,style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w600,color: greyOpacityColor),textAlign: TextAlign.center,),
                    ],
                  ),
                  SizedBox(height: sizeH10,),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType : TextInputType.name,
                    controller: locationName,
                    decoration:  InputDecoration(
                      hintText: 'Location name'.tr,
                      contentPadding: EdgeInsets.only(
                        top: 0,
                        bottom: 0,
                        right: sizeW15,
                        left: sizeW15,
                      ),
                      border:  OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(sizeW45)),
                        borderSide: const BorderSide(
                          color: grey3,
                          width: 0.8,
                        ),
                      ),
                      
                      labelStyle:  TextStyle(
                        fontSize: sizeW16,
                        color: blackolor,
                        fontWeight: FontWeight.w300,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:  BorderRadius.all(Radius.circular(sizeW45)),
                        borderSide: const BorderSide(
                          color: grey3,
                          width: 0.8,
                        ),
                      ),
                      focusedBorder:  OutlineInputBorder(
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
                      if (value == null || value.isEmpty) {
                        return 'required'.tr;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: sizeH15,),
                  Row(
                    children: [
                      Text('Street'.tr,style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w600,color: greyOpacityColor),textAlign: TextAlign.center,),
                    ],
                  ),
                  SizedBox(height: sizeH10,),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType : TextInputType.text,
                    controller: street,
                    decoration:  InputDecoration(
                      hintText: 'Street'.tr,
                      contentPadding: EdgeInsets.only(
                        top: 0,
                        bottom: 0,
                        right: sizeW15,
                        left: sizeW15,
                      ),
                      border:  OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(sizeW45)),
                        borderSide: const BorderSide(
                          color: grey3,
                          width: 0.8,
                        ),
                      ),
                      
                      labelStyle:  TextStyle(
                        fontSize: sizeW16,
                        color: blackolor,
                        fontWeight: FontWeight.w300,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:  BorderRadius.all(Radius.circular(sizeW45)),
                        borderSide: const BorderSide(
                          color: grey3,
                          width: 0.8,
                        ),
                      ),
                      focusedBorder:  OutlineInputBorder(
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
                      if (value == null || value.isEmpty) {
                        return 'required'.tr;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: Get.width / 3.5,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Building'.tr,style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w600,color: greyOpacityColor),textAlign: TextAlign.center,),
                              ],
                            ),
                            SizedBox(height: sizeH10,),
                            TextFormField(
                              textAlign: TextAlign.center,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              keyboardType : TextInputType.number,
                              controller: building,
                              decoration:  InputDecoration(
                                hintText: 'Building'.tr,
                                contentPadding:  EdgeInsets.only(
                                  top: 0,
                                  bottom: 0,
                                  right: sizeW5,
                                  left: sizeW5,
                                ),
                                border:  OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(sizeW45)),
                                  borderSide: const BorderSide(
                                    color: grey3,
                                    width: 0.8,
                                  ),
                                ),
                                
                                hintStyle: TextStyle(
                                  fontSize: sizeW16,
                                  color: const Color(0xFFD9D9D9),
                                  fontWeight: FontWeight.w300,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:  BorderRadius.all(Radius.circular(sizeW45)),
                                  borderSide: const BorderSide(
                                    color: grey3,
                                    width: 0.8,
                                  ),
                                ),
                                focusedBorder:  OutlineInputBorder(
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
                                if (value == null || value.isEmpty) {
                                  return 'required'.tr;
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: Get.width / 3.5,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Floor'.tr,style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w600,color: greyOpacityColor),textAlign: TextAlign.center,),
                              ],
                            ),
                            SizedBox(height: sizeH10,),
                            TextFormField(
                              textAlign: TextAlign.center,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              keyboardType : TextInputType.number,
                              controller: floor,
                              decoration:  InputDecoration(
                                hintText: 'Floor'.tr,
                                contentPadding:  EdgeInsets.only(
                                  top: 0,
                                  bottom: 0,
                                  right: sizeW5,
                                  left: sizeW5,
                                ),
                                border:  OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(sizeW45)),
                                  borderSide: const BorderSide(
                                    color: grey3,
                                    width: 0.8,
                                  ),
                                ),
                                
                                hintStyle: TextStyle(
                                  fontSize: sizeW16,
                                  color: const Color(0xFFD9D9D9),
                                  fontWeight: FontWeight.w300,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:  BorderRadius.all(Radius.circular(sizeW45)),
                                  borderSide: const BorderSide(
                                    color: grey3,
                                    width: 0.8,
                                  ),
                                ),
                                focusedBorder:  OutlineInputBorder(
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
                                if (value == null || value.isEmpty) {
                                  return 'required'.tr;
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: Get.width / 3.5,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Flat'.tr,style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w600,color: greyOpacityColor),textAlign: TextAlign.center,),
                              ],
                            ),
                            SizedBox(height: sizeH10,),
                            TextFormField(
                              textAlign: TextAlign.center,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              keyboardType : TextInputType.number,
                              controller: flat,
                              decoration:  InputDecoration(
                                hintText: 'Flat'.tr,
                                contentPadding:  EdgeInsets.only(
                                  top: 0,
                                  bottom: 0,
                                  right: sizeW5,
                                  left: sizeW5,
                                ),
                                border:  OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(sizeW45)),
                                  borderSide: const BorderSide(
                                    color: grey3,
                                    width: 0.8,
                                  ),
                                ),
                                
                                hintStyle: TextStyle(
                                  fontSize: sizeW16,
                                  color: const Color(0xFFD9D9D9),
                                  fontWeight: FontWeight.w300,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:  BorderRadius.all(Radius.circular(sizeW45)),
                                  borderSide: const BorderSide(
                                    color: grey3,
                                    width: 0.8,
                                  ),
                                ),
                                focusedBorder:  OutlineInputBorder(
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
                                if (value == null || value.isEmpty) {
                                  return 'required'.tr;
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                ],
              ),
            ),
          ),
        ),
        SliverPadding(
          padding:  EdgeInsets.all(sizeW10),
          sliver: SliverToBoxAdapter(
            child: Column(
              children: [
                GestureDetector(
                  onTap: (){
                    if(defaultLocation.value == 0){
                      defaultLocation.value = 1;
                    }else{
                      defaultLocation.value = 0;
                    }
                  },
                  child: Row(
                    children: [
                      Obx(() => SizedBox(
                        width: sizeW20,
                        child: Radio(
                          value: defaultLocation.value,
                          groupValue: 1,
                          activeColor: primaryColor,
                          onChanged: (value) {
                          },
                        ),
                      ),),
                      SizedBox(width: sizeW10,),
                      Text(
                        'Make this address default'.tr,
                        style:  TextStyle(
                          fontSize: sizeW14,
                          color: greyOpacityColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:  EdgeInsets.all(sizeW10),
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
                      if (!_formKey.currentState!.validate()) {
                    
                      }else{
                        final AddAddressController addAddressController = Get.put(AddAddressController());
                        addAddressController.editAddressHome(addresId.value,
                          locationName.text, street.text, city.text, building.text, flat.text, floor.text, lat.value, long.value, defaultLocation.value);
                      }
                      
                    },
                    child:  Text(
                      'Edit location'.tr,
                      style:  TextStyle(
                        fontSize: sizeW22,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  
}
