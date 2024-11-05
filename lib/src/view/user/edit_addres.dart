// ignore_for_file: avoid_print, must_be_immutable, no_logic_in_create_state
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_picker/map_picker.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';
import '../../../constance.dart';
import '../../controller/lang_controller.dart';
import 'controllers/edit_address_controller.dart';

class EditAddress extends StatefulWidget {
  const EditAddress({Key? key}) : super(key: key);
  @override
  State<EditAddress> createState() => EditAddressState();
}
class EditAddressState extends State<EditAddress> {
  
  final EditAddressController controller = Get.put(EditAddressController());
  final LangController _langController = Get.put(LangController());
  var startLocation =   LatLng(Get.arguments[0], Get.arguments[1]);
  var cameraPosition =   CameraPosition(
    target: LatLng(Get.arguments[0], Get.arguments[1]),
    zoom: 14.4746,
  );
  var textController = TextEditingController();
  List predictions = [];
  late GoogleMapController mapController;
  MapPickerController mapPickerController = MapPickerController();
  @override
  initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final pageIndexNotifier = ValueNotifier(0);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Stack(
        children: [
          MapPicker(
            iconWidget: Image.asset(
              "assets/marker.png",
            ),
            mapPickerController: mapPickerController,
            child: GoogleMap(
              myLocationEnabled: true,
              zoomControlsEnabled: false,
              myLocationButtonEnabled: false,
              mapType: MapType.normal,
              rotateGesturesEnabled : true,
              initialCameraPosition: CameraPosition( //innital position in map
                target: startLocation, //initial position
                zoom: sizeH15, //initial zoom level
              ),
              onMapCreated: (controller) { //method called when map is created
                setState(() {
                  mapController = controller; 
                });
              },
              onCameraMoveStarted: () {
                print('onCameraMoveStarted');
                mapPickerController.mapMoving!();
                textController.text = "checking ...";
              },
              onCameraMove: (cameraPosition) async{
                print('onCameraMove');
                cameraPosition = cameraPosition;
                List<Placemark> placemarks = await placemarkFromCoordinates(
                  cameraPosition.target.latitude,
                  cameraPosition.target.longitude,
                  // localeIdentifier:  _langController.appLocale,
                );
                controller.addressText.value = '${placemarks.first.street}, ${placemarks.first.name}, ${placemarks.first.administrativeArea}';
                controller.street.text = placemarks.first.street.toString();
                controller.city.text = placemarks.first.locality.toString();
                controller.lat.value = cameraPosition.target.latitude;
                controller.long.value = cameraPosition.target.longitude;
                print(controller.street.text);
              },
              onCameraIdle: () async {
                print('onCameraIdle');
                
                mapPickerController.mapFinishedMoving!();
                
                List<Placemark> placemarks = await placemarkFromCoordinates(
                  cameraPosition.target.latitude,
                  cameraPosition.target.longitude,
                  // localeIdentifier:  _langController.appLocale,
                );
                controller.addressText.value = '${placemarks.first.street}, ${placemarks.first.name}, ${placemarks.first.administrativeArea}';
                controller.street.text = placemarks.first.street.toString();
                controller.city.text = placemarks.first.locality.toString();
                controller.lat.value = cameraPosition.target.latitude;
                controller.long.value = cameraPosition.target.longitude;
              },
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).viewPadding.top + sizeH25,
            width: MediaQuery.of(context).size.width - 0,
            child: Column(
              children: [
                FadeInUp(
                  child: GestureDetector(
                    onTap: (){
                      FocusScope.of(context).requestFocus(FocusNode());
                      WoltModalSheet.show<void>(
                        pageIndexNotifier: pageIndexNotifier,
                        context: context,
                        pageListBuilder: (modalSheetContext) {
                          return [
                            controller.page1(modalSheetContext),
                          ];
                        },
                        modalTypeBuilder: (context) {
                          return WoltModalType.bottomSheet();
                        },
                        onModalDismissedWithBarrierTap: () {
                          debugPrint('Closed modal omar oamr');
                          Navigator.of(context).pop();
                          mapController.animateCamera( 
                            CameraUpdate.newCameraPosition(
                              CameraPosition(target: LatLng(controller.lat.value,controller.long.value), zoom: 14) 
                            )
                          );
                          pageIndexNotifier.value = 0;
                        },
                        // maxDialogWidth: 560,
                        // minDialogWidth: 400,
                        // minPageHeight: 0.0,
                        // maxPageHeight: Get.height /2,
                      ).then((value) {
                        mapController.animateCamera( 
                          CameraUpdate.newCameraPosition(
                            CameraPosition(target: LatLng(controller.lat.value,controller.long.value), zoom: 14) 
                          )
                        );
                      });
                    },
                    child: Container(
                      width: Get.width / 1.1,
                      height: sizeH50,
                      padding:  EdgeInsets.only(right: sizeW15,left: sizeW15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(sizeW45),
                        color:  Colors.white,
                      ),
                      child: Row(
                        children: [
                          Image.asset('assets/search.png',width: sizeW25,height: sizeW25,),
                          SizedBox(width: sizeW10,),
                          Text(
                            'search'.tr,
                            style:  TextStyle(
                              fontSize: sizeW18,
                              color: const Color(0xFFD9D9D9),
                              fontWeight: FontWeight.w400
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: sizeH30,
            left: 0,
            right: 0,
            child: Column(
              children: [
                MaterialButton(
                  elevation: 0,
                  color: primaryColor,
                  minWidth: Get.width / 1.1,
                  height: sizeH50,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(sizeW45),
                  ),
                  onPressed: (){
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
                  child:  Text(
                    'Edit location'.tr,
                    style:  TextStyle(
                      fontSize: sizeW22,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
