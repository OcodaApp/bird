// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, avoid_function_literals_in_foreach_calls


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../constance.dart';
import 'controllers/fnish_order_controller.dart';

class IsOrderViewFnish extends StatelessWidget {
  IsOrderViewFnish({Key? key,this.order}) : super(key: key);
  var order;
  final FnishOrderController controller = Get.put(FnishOrderController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.white,
    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GestureDetector(
        onTap: (){
          controller.changeOrderDeliveryStatus();
        },
        child: Container(
          width: Get.width / 1,
          height: sizeH50,
          margin: EdgeInsets.all(sizeW15),
          decoration:  BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(sizeW25),
            
          ),
          child: Center(
            child: Text(
              'Arrived destination 2'.tr,
              style: TextStyle(color: whitecolor,fontSize: sizeW22,fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
      body: Container(
        width: Get.width,
        height: Get.height,
        color: Colors.white,
        child: Obx(() => controller.isMap.value? Container(
          height: Get.height /3,
          width: Get.width,
          decoration:   BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(sizeW25),
            ),
          ),
          child: ClipRRect(
            borderRadius:  BorderRadius.all(
              Radius.circular(sizeW25),
            ),
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
              target: LatLng(controller.originLatitude.value, controller.originLongitude.value),
              zoom: 12,
              ),
              
              onMapCreated: (mapController) {
                controller.onMapCreated(mapController);
              },
              markers: Set<Marker>.of(controller.markers.values),
              
              // polylines: Set<Polyline>.of(controller.polylines.values),
              polylines: {
                Polyline(
                  polylineId: const PolylineId("route"),
                  points: controller.polylineCoordinates,
                  color: primaryColor,
                  width: 5,
                ),
              },
            ),
          ),
        ):Container(),),
      ),
    );
  }
}
