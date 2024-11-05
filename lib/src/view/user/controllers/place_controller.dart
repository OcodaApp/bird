// ignore_for_file: avoid_print, empty_catches

import 'package:birdandroid/utility/General.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_place/google_place.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';
import '../../../../constance.dart';
import '../../../../http/request.dart';
import '../../../../http/url.dart';
import '../../../../model/address_list_model.dart';
import '../../../controller/lang_controller.dart';
import '../../../controller/tabbar_controller.dart';
import '../../home_view.dart';
import 'add_address_controller.dart';
import 'map_search_controller.dart';

class PlaceController extends GetxController {
  final LangController _langController = Get.put(LangController());
  final TabBarController tabController = Get.put(TabBarController());
  final SeaConController searchController = Get.put(SeaConController());
  var googlePlace = GooglePlace("AIzaSyATuEq0qRHi33CVV_q9_RwuQ6JRm7C0fWY");
  late DetailsResult detailsResult;
  late TextEditingController locationName;
  late TextEditingController street;
  late TextEditingController city;
  late TextEditingController building;
  late TextEditingController flat;
  late TextEditingController floor;
  var lat = General.latitude.obs;
  var long = General.longitude.obs;
  var addressText = ''.obs;

  @override
  void onInit() {
    getAddressUser();
    locationName = TextEditingController();
    street = TextEditingController();
    city = TextEditingController();
    building = TextEditingController();
    flat = TextEditingController();
    floor = TextEditingController();
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
  

  var isDataAddress = false.obs;
  var addrssData = [].obs;
  void getAddressUser() async {
    Request request = Request(url: urlMyAddress, body: null);
    request.getAuth().then((value) {
      if (value['status']) {
        AddressListModel addressListModel = AddressListModel.fromJson(value);
        addrssData.value = addressListModel.address!;
        isDataAddress.value = true;
      } else {
      }
    }).catchError((onError) {
    });
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

  getCurrentLocationDriver() async {
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
      getCurrentLocation();
    });
  }


  List predictions = [].obs;
  var isSearch = false.obs;

  page1(BuildContext modalSheetContext) {
    isSearch.value = false;
    predictions.clear();
    locationName.clear();
    street.clear();
    city.clear();
    building.clear();
    flat.clear();
    floor.clear();
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
              child: !isSearch.value ?ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: addrssData.isNotEmpty? createSliders():[
                      Center(child: Text('no address add'.tr),)
                    ],
                  ),
                  
                ],
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
                  const SizedBox(height: 15,),
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
                        addAddressController.addAddressHome(
                          locationName.text, street.text, city.text, building.text, flat.text, floor.text, lat.value, long.value, defaultLocation.value);
                      }
                      
                    },
                    child:  Text(
                      'Add Location'.tr,
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

  List<Widget> createSliders() {
    List<Widget> imageSliders = addrssData.map((item) {
      return GestureDetector(
        onTap: (){
          Get.to(()=>const HomeView());
        },
        child: Container(
          margin:  EdgeInsets.only(right: sizeW15,left: sizeW15,bottom: sizeH20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title,
                style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w600,color: primaryColor),
              ),
              SizedBox(height: sizeH5,),
              Text(
                item.street,
                style: TextStyle(fontSize: sizeW14,fontWeight: FontWeight.w300,color: primaryColor),
              ),
            ],
          ),
        ),
      );
    }).toList();
    return imageSliders;
  }

  
}
