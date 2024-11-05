

// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_picker/map_picker.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';
import '../../../../constance.dart';
import '../../../../http/request.dart';
import '../../../../http/url.dart';
import '../../../../model/address_list_model.dart';
import '../../../../model/sliders_list_model.dart';
import '../../../../utility/Address.dart' as address;
import '../../../../utility/General.dart';
import '../../user/controllers/add_address_controller.dart';
import '../../user/controllers/place_controller.dart';
import '../../user/edit_addres.dart';
import '../../user/location_view.dart';

class HomeController extends GetxController {
  var current = 0.obs;
  final pageIndexNotifier = ValueNotifier(0);
  LatLng startLocation =  LatLng(General.latitude, General.longitude); 
  var textController = TextEditingController();
  List predictions = [];
  late GoogleMapController mapController;
  MapPickerController mapPickerController = MapPickerController();
  CameraPosition cameraPosition =   CameraPosition(
    target: LatLng(General.latitude, General.longitude),
    zoom: 14.4746,
  );

  late TextEditingController locationName;
  late TextEditingController street;
  late TextEditingController city;
  late TextEditingController building;
  late TextEditingController flat;
  late TextEditingController floor;
  var lat = General.latitude.obs;
  var long = General.longitude.obs;
  var addressText = ''.obs;
  page3(modalSheetContext) {
    return SliverWoltModalSheetPage(
      isTopBarLayerAlwaysVisible: true,
      hasTopBarLayer : true,
      topBarTitle: Text('location'.tr.tr,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: primaryColor),),
      trailingNavBarWidget: IconButton(
        padding:  EdgeInsets.all(sizeW10),
        icon: Icon(Icons.close,color: const Color.fromARGB(255, 153, 152, 152),size: sizeW15,),
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
            child: SizedBox(
              height: Get.height /2,
              child: ListView(
                children: [
                  Obx(() => Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: addrssData.isNotEmpty? createSliders():[
                      Center(child: Text('no address add'.tr),)
                    ],
                  ),),
                  GestureDetector(
                    onTap: (){
                      PlaceController placeController = Get.put(PlaceController());
                      placeController.getCurrentLocation().then((res) {
                        General().getlatitude();
                        General().getlongitude();
                        General().getUserData().then((val){
                          Get.to(()=>MapSearchView(lat: General.latitude,long: General.longitude,));
                        });
                      });
                    },
                    child: Container(
                      height: sizeH75,
                      width: double.infinity,
                      padding:  EdgeInsets.only(right: sizeW15,left: sizeW15,top: sizeH10,bottom: sizeH10),
                      margin:  EdgeInsets.all(sizeW5),
                      decoration:  BoxDecoration(
                        color: Colors.white,
                        borderRadius:  BorderRadius.all(
                          Radius.circular(sizeW45),
                        ),
                        border: Border.all(color: grey3)
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/gps.png",
                            color: greyOpacityColor,
                            width: sizeW16,
                            height: sizeH25,
                          ),
                          SizedBox(width: sizeW15,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Deliver to a different location'.tr,
                                style: TextStyle(fontSize: sizeW14,fontWeight: FontWeight.w600,color: greyOpacityColor),
                              ),
                              SizedBox(height: sizeH5,),
                              Text(
                                'Choose location on map'.tr,
                                style: TextStyle(fontSize: sizeW14,fontWeight: FontWeight.w400,color: greyOpacityColor),
                              ),
                            ],
                          ),
                        ],
                      )
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverPadding(
          padding:  EdgeInsets.all(sizeW10),
          sliver: SliverToBoxAdapter(
            child: Container(
              padding:  EdgeInsets.all(sizeW10),
              color: Colors.white,
              child: MaterialButton(
                elevation: 0,
                color:  primaryColor,
                minWidth: Get.width / 1.1,
                height: sizeH50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(sizeW45),
                ),
                onPressed: (){
                  address.Address().setAddresId(addrssId.value.toString());
                  address.Address().getAddresId();
                  address.Address().setAddressData(addressChoose);
                  address.Address().getAddressData().then((vv){
                    addrssName.value = address.Address.a_name;
                    addrssStreet.value = address.Address.a_street;
                    Get.back();
                    FocusManager.instance.primaryFocus?.unfocus();
                  });
                },
                child:  Text(
                  'Confirm'.tr,
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

  var isSliders = false.obs;
  var slidersData = [].obs;
  // intros
  void getIntrosList() async {
    isSliders.value = false;
    Request request = Request(url: urlSliders, body: null);
    request.get().then((value) async {
      if (value['status']) {
        SlidersListModel lists = SlidersListModel.fromJson(value);
        slidersData.value = lists.sliders!;
        isSliders.value = true;
      } else {
        // Get.offNamed('/loginView');
      }
    }).catchError((onError) {
      // Get.offNamed('/loginView');
    });
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

  var addrssId = 0.obs;
  var addrssName = ''.obs;
  var addrssStreet = ''.obs;
  var addressChoose;

  List<Widget> createSliders() {
    List<Widget> imageSliders = addrssData.map((item) {
      return Container(
        margin:  EdgeInsets.only(right: sizeW15,left: sizeW15,bottom: sizeH10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: (){
                addrssId.value = item.id;
                addressChoose = {
                  'id' : item.id,
                  'location_name' : item.title,
                  'addres_text' : item.addressText,
                  'street' : item.street,
                  'building' : item.building,
                  'floor' : item.floor,
                  'flat' : item.flat,
                  'latitude' : item.latitude,
                  'longitude' : item.longitude,
                  'city' : item.city,
                };
              },
              child: Container(
                height: sizeH75,
                width: double.infinity,
                padding:  EdgeInsets.only(right: sizeW15,left: sizeW15,top: sizeH10,bottom: sizeH10),
                margin:  EdgeInsets.all(sizeW5),
                decoration:  BoxDecoration(
                  color:addrssId.value == item.id ?  const Color.fromARGB(255, 159, 160, 170).withOpacity(0.1):whitecolor,
                  borderRadius:  BorderRadius.all(
                    Radius.circular(sizeW45),
                  ),
                  border: Border.all(color: addrssId.value == item.id ? primaryColor:greyOpacityColor)
                ),
                
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "assets/marker.png",
                          color: addrssId.value == item.id ? primaryColor:greyOpacityColor,
                          width: 16,
                          height: 18,
                        ),
                        SizedBox(width: sizeW15,),
                         Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: TextStyle(fontSize: sizeW14,fontWeight: FontWeight.w600,color: addrssId.value == item.id ? primaryColor:greyOpacityColor),
                            ),
                            SizedBox(height: sizeH5,),
                            SizedBox(
                              width: Get.width / 2,
                              child: Text(
                                item.street,
                                style: TextStyle(fontSize: sizeW14,fontWeight: FontWeight.w400,color: addrssId.value == item.id ? primaryColor:greyOpacityColor,overflow:TextOverflow.ellipsis ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Obx(() => SizedBox(
                      width: sizeW20,
                      child: Radio(
                        value: addrssId.value,
                        groupValue: item.id,
                        activeColor: primaryColor,
                        onChanged: (value) {
                          addrssId.value = item.id;
                        },
                      ),
                    ),)
                  ],
                )
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: (){
                    Get.to(()=>const EditAddress(),arguments: [double.parse(item.latitude),double.parse(item.longitude),item]);
                  },
                  child: Text(
                    'Edit'.tr,
                    style: TextStyle(fontSize: sizeW14,fontWeight: FontWeight.w600,color: primaryColor),
                  ),
                ),
                SizedBox(width: addrssId.value != item.id ? sizeW15:0,),
                addrssId.value != item.id ? GestureDetector(
                  onTap: (){
                    AddAddressController addAddress = AddAddressController();
                    addAddress.deleteAddress(item.id).then((value){
                      getAddressUser();
                    });
                  },
                  child: Text(
                    'Delete'.tr,
                    style: TextStyle(fontSize: sizeW14,fontWeight: FontWeight.w600,color: primaryColor),
                  ),
                ):Container(),
                SizedBox(width: sizeW10,),
              ],
            ),
          ],
        ),
      );
    }).toList();
    return imageSliders;
  }

  
  @override
  void onInit() {
    
    if(General.type == 'client'){
      addrssName.value = address.Address.a_name;
      addrssStreet.value = address.Address.a_street;
      addrssId.value = int.parse(address.Address.a_id);
    }
    locationName = TextEditingController();
    street = TextEditingController();
    city = TextEditingController();
    building = TextEditingController();
    flat = TextEditingController();
    floor = TextEditingController();
    getIntrosList();
    getAddressUser();
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
}
