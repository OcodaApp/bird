// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:birdandroid/utility/General.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../constance.dart';
import '../../controller/lang_controller.dart';
import '../chat/chat_ad.dart';
import 'controllers/order_show_controller.dart';

class ShowOrderView extends StatelessWidget {
  String type = '';
  var orderData;
  var store, user, address, fromAddress, toAddress, items = [], delegate;
  final LangController langcontroller = Get.put(LangController());

  ShowOrderView(
      {Key? key,
      required this.type,
      required this.store,
      required this.user,
      required this.address,
      required this.fromAddress,
      required this.toAddress,
      required this.items,
      this.orderData,
      this.delegate})
      : super(key: key);
  final OrderShowController controller = Get.put(OrderShowController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Order details'.tr,
          style: TextStyle(
              color: primaryColor,
              fontSize: sizeW20,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            width: sizeW25,
            height: sizeW25,
            margin: EdgeInsets.all(sizeW12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(sizeW25),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color:
                      const Color.fromARGB(31, 153, 152, 152).withOpacity(0.2),
                  offset: const Offset(0, 0),
                  blurRadius: 10.0,
                )
              ],
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  right: langcontroller.appLocale == 'ar' ? sizeW5 : 0,
                  left: langcontroller.appLocale == 'en' ? sizeW5 : 0),
              child: Center(
                  child: Icon(
                Icons.arrow_back_ios,
                color: greyOpacityColor,
                size: sizeW15,
              )),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        width: Get.width,
        height: Get.height,
        color: Colors.white,
        padding: EdgeInsets.all(sizeW15),
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.only(bottom: sizeH20),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: grey5),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  orderData.storeLogo != 'null' && orderData.storeLogo != ''
                      ? FadeInDown(
                          child: Image.network(
                            orderData.storeLogo,
                            width: sizeW35,
                            height: sizeW35,
                            fit: BoxFit.fill,
                          ),
                        )
                      : FadeInDown(
                          child: Image.asset(
                            'assets/logo.png',
                            width: sizeW35,
                            height: sizeW35,
                            fit: BoxFit.fill,
                          ),
                        ),
                  SizedBox(
                    width: sizeW15,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        orderData.storeName != 'null' &&
                                orderData.storeName != ''
                            ? orderData.storeName
                            : 'Deliver Package'.tr,
                        style: TextStyle(
                            color: primaryColor,
                            fontSize: sizeW16,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        orderData.statusName,
                        style: TextStyle(
                            color: primaryTowColor,
                            fontSize: sizeW14,
                            fontWeight: FontWeight.w300,
                            height: 1.3),
                      ),
                      Text(
                        orderData.date,
                        style: TextStyle(
                            color: greyOpacityColor,
                            fontSize: sizeW14,
                            fontWeight: FontWeight.w300,
                            height: 1.3),
                      ),
                      Text(
                        '${'Order ID'.tr}: ${orderData.code}',
                        style: TextStyle(
                            color: greyOpacityColor,
                            fontSize: sizeW14,
                            fontWeight: FontWeight.w300,
                            height: 1.3),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: sizeH20,
            ),
            orderData.type == 'order'
                ? Container(
                    padding: EdgeInsets.only(bottom: sizeH20),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: grey5),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FadeInDown(
                              child: Image.asset(
                                'assets/marker.png',
                                width: sizeW25,
                                height: sizeW25,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(
                              width: sizeW15,
                            ),
                            Text(
                              'Delivering to'.tr,
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: sizeW16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: sizeH10,
                        ),
                        Text(
                          jsonDecode(address)['street'].toString(),
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: sizeW16,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  )
                : Container(),
            orderData.type == 'service'
                ? Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: sizeH20),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: grey5),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FadeInDown(
                                  child: Image.asset(
                                    'assets/marker.png',
                                    width: sizeW25,
                                    height: sizeW25,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(
                                  width: sizeW15,
                                ),
                                Text(
                                  'Delivering from'.tr,
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontSize: sizeW16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: sizeH10,
                            ),
                            Text(
                              fromAddress['street'],
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: sizeW16,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: sizeH15,
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: sizeH20),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: grey5),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FadeInDown(
                                  child: Image.asset(
                                    'assets/marker.png',
                                    width: sizeW25,
                                    height: sizeW25,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(
                                  width: sizeW15,
                                ),
                                Text(
                                  'Delivering to'.tr,
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontSize: sizeW16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: sizeH10,
                            ),
                            Text(
                              toAddress['street'],
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: sizeW16,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Container(),
            SizedBox(
              height: sizeH20,
            ),

            Row(
              children: [
                Text(
                  'Order Summery'.tr,
                  style: TextStyle(
                      fontSize: sizeW16,
                      fontWeight: FontWeight.w600,
                      color: primaryColor),
                ),
              ],
            ),
            SizedBox(
              height: sizeH15,
            ),
            Container(
              padding: EdgeInsets.only(bottom: sizeH20),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: grey5),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  orderData.type == 'order'
                      ? Column(
                          children: createItems(),
                        )
                      : Padding(
                          padding: EdgeInsets.only(bottom: sizeH20),
                          child: Text(orderData.package,
                              style: TextStyle(
                                  fontSize: sizeW15,
                                  fontWeight: FontWeight.w400,
                                  color: greyOpacityColor,
                                  height: 1.4)),
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Delivery fee'.tr,
                          style: TextStyle(
                              fontSize: sizeW14,
                              fontWeight: FontWeight.w400,
                              color: greyOpacityColor)),
                      Text('${orderData.deliveryTotal} ${'SAR'.tr}',
                          style: TextStyle(
                              fontSize: sizeW14,
                              fontWeight: FontWeight.w400,
                              color: greyOpacityColor)),
                    ],
                  ),
                  SizedBox(
                    height: sizeH5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Service fees'.tr,
                          style: TextStyle(
                              fontSize: sizeW14,
                              fontWeight: FontWeight.w400,
                              color: greyOpacityColor)),
                      Text('${orderData.servicePrice} ${'SAR'.tr}',
                          style: TextStyle(
                              fontSize: sizeW14,
                              fontWeight: FontWeight.w400,
                              color: greyOpacityColor)),
                    ],
                  ),
                  SizedBox(
                    height: sizeH5,
                  ),
                  orderData.saleTotal > 0
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Discount'.tr,
                                style: TextStyle(
                                    fontSize: sizeW16,
                                    fontWeight: FontWeight.w400,
                                    color: greyOpacityColor)),
                            Text(
                                '-${orderData.saleTotal.toString()} ${'SAR'.tr}',
                                style: TextStyle(
                                    fontSize: sizeW16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.red)),
                          ],
                        )
                      : Container(),
                  SizedBox(
                    height: orderData.saleTotal > 0 ? sizeH15 : 0,
                  ),
                  orderData.type == 'order'
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Grand Total'.tr,
                                style: TextStyle(
                                    fontSize: sizeW14,
                                    fontWeight: FontWeight.w400,
                                    color: greyOpacityColor)),
                            Text('${orderData.itemsTotal} ${'SAR'.tr}',
                                style: TextStyle(
                                    fontSize: sizeW14,
                                    fontWeight: FontWeight.w400,
                                    color: greyOpacityColor)),
                          ],
                        )
                      : Container(),
                ],
              ),
            ),
            SizedBox(
              height: sizeH15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total amount'.tr,
                    style: TextStyle(
                        fontSize: sizeW18,
                        fontWeight: FontWeight.w600,
                        color: primaryColor)),
                Text('${orderData.total} ${'SAR'.tr}',
                    style: TextStyle(
                        fontSize: sizeW16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor)),
              ],
            ),
            SizedBox(
              height: sizeH10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Payment method'.tr,
                    style: TextStyle(
                        fontSize: sizeW14,
                        fontWeight: FontWeight.w400,
                        color: greyOpacityColor)),
                Text('${orderData.method}',
                    style: TextStyle(
                        fontSize: sizeW14,
                        fontWeight: FontWeight.w400,
                        color: greyOpacityColor)),
              ],
            ),
            SizedBox(
              height:
                  type == 'Deliverd' && General.type == 'client' ? sizeH5 : 0,
            ),
            type == 'Deliverd' && General.type == 'client'
                ? Obx(() => Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: sizeH20),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: grey5),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: sizeH20,
                        ),
                        Text(
                          'Rate your order'.tr,
                          style: TextStyle(
                              fontSize: sizeW18,
                              fontWeight: FontWeight.w600,
                              color: primaryColor),
                        ),
                        SizedBox(
                          height: sizeH10,
                        ),
                        SmoothStarRating(
                            allowHalfRating: true,
                            onRatingChanged: (v) {
                              if (!controller.isRating.value) {
                                controller.rating.value = v;
                              }
                            },
                            starCount: 5,
                            rating: controller.rating.value,
                            size: sizeW30,
                            filledIconData: Icons.star,
                            halfFilledIconData: Icons.star,
                            color: orangColor,
                            borderColor: grey5,
                            spacing: 5.0),
                        SizedBox(
                          height: sizeH20,
                        ),
                        !controller.isRating.value
                            ? GestureDetector(
                                onTap: () {
                                  controller.rateOrder(orderData.id);
                                },
                                child: Container(
                                  width: Get.width / 1.1,
                                  height: sizeH50,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(sizeW45),
                                    color: primaryColor,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'send'.tr,
                                      style: TextStyle(
                                        fontSize: sizeW22,
                                        color: whitecolor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ))
                : Container(),
            type == 'Out for delivery' && orderData.active == 1
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: sizeH20),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: grey5),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: sizeH20,
                      ),
                      Text(
                        'Track order'.tr,
                        style: TextStyle(
                            fontSize: sizeW16,
                            fontWeight: FontWeight.w600,
                            color: primaryColor),
                      ),
                      SizedBox(
                        height: sizeH10,
                      ),
                      Text(
                        'Your delivery rider'.tr,
                        style: TextStyle(
                            fontSize: sizeW16,
                            fontWeight: FontWeight.w500,
                            color: primaryColor),
                      ),
                      SizedBox(
                        height: sizeH15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              jsonDecode(delegate)['img'] != null
                                  ? FadeInDown(
                                      child: Image.network(
                                        jsonDecode(delegate)['image_url'],
                                        width: sizeW45,
                                        height: sizeW45,
                                        fit: BoxFit.fill,
                                      ),
                                    )
                                  : FadeInDown(
                                      child: Image.asset(
                                        'assets/profile/person3.png',
                                        width: sizeW45,
                                        height: sizeW45,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                              SizedBox(
                                width: sizeW15,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      width: Get.width / 2,
                                      child: Text(
                                        jsonDecode(delegate)['name'],
                                        style: TextStyle(
                                            fontSize: sizeW16,
                                            fontWeight: FontWeight.w500,
                                            color: primaryColor),
                                      )),
                                  SizedBox(
                                    height: sizeH5,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.orange,
                                        size: sizeW14,
                                      ),
                                      SizedBox(
                                        width: sizeW5,
                                      ),
                                      Text(
                                        jsonDecode(delegate)['rate_avg']
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: sizeW12,
                                            fontWeight: FontWeight.w400,
                                            color: primaryColor),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              jsonDecode(delegate)['phone'] != null
                                  ? FadeInDown(
                                      child: GestureDetector(
                                          onTap: () {
                                            // ignore: deprecated_member_use
                                            launch(
                                                "tel://${jsonDecode(delegate)['phone']}");
                                          },
                                          child: Image.asset(
                                            'assets/profile/phoeb.png',
                                            width: sizeW35,
                                            height: sizeW35,
                                            fit: BoxFit.fill,
                                          )),
                                    )
                                  : Container(),
                              SizedBox(
                                width: sizeW15,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Get.to(
                                        () => ChatAdView(
                                              phone: jsonDecode(
                                                      delegate)['phone'] ??
                                                  'null',
                                              name:
                                                  jsonDecode(delegate)['name'],
                                              image:
                                                  jsonDecode(delegate)['img'] ??
                                                      'null',
                                              imageUrl: jsonDecode(
                                                  delegate)['image_url'],
                                            ),
                                        arguments: [orderData.id]);
                                  },
                                  child: FadeInDown(
                                    child: Image.asset(
                                      'assets/profile/chatb.png',
                                      width: sizeW35,
                                      height: sizeW35,
                                      fit: BoxFit.fill,
                                    ),
                                  )),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: sizeH20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Arrival estimated time'.tr,
                              style: TextStyle(
                                  fontSize: sizeW16,
                                  fontWeight: FontWeight.w500,
                                  color: primaryColor)),
                          Text(orderData.time,
                              style: TextStyle(
                                  fontSize: sizeW16,
                                  fontWeight: FontWeight.w500,
                                  color: primaryColor)),
                        ],
                      ),
                      SizedBox(
                        height: sizeH5,
                      ),
                      Text('The rider arrived to the branch'.tr,
                          style: TextStyle(
                              fontSize: sizeW14,
                              fontWeight: FontWeight.w400,
                              color: greyOpacityColor)),
                      SizedBox(
                        height: sizeH20,
                      ),
                      Obx(
                        () => controller.isMap.value
                            ? Container(
                                height: Get.height / 3,
                                width: Get.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(sizeW25),
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(sizeW25),
                                  ),
                                  child: GoogleMap(
                                    initialCameraPosition: CameraPosition(
                                      target: LatLng(
                                          controller.originLatitude.value,
                                          controller.originLongitude.value),
                                      zoom: 14,
                                    ),

                                    onMapCreated: (mapController) {
                                      controller.onMapCreated(mapController);
                                    },
                                    onCameraMove: (value) {},
                                    markers: Set<Marker>.of(
                                        controller.markers.values),
                                    polylines: {
                                      Polyline(
                                        polylineId: const PolylineId("route"),
                                        points: controller.polylineCoordinates,
                                        color: primaryColor,
                                        width: 5,
                                      ),
                                    },
                                    // polylines: Set<Polyline>.of(controller.polylines.values),
                                  ),
                                ),
                              )
                            : Container(),
                      ),
                    ],
                  )
                : Container(),

            //
            SizedBox(
              height: type == 'Order Placed' ||
                      type == 'wait' && orderData.active == 1
                  ? sizeW35
                  : 0,
            ),
            type == 'Order Placed' || type == 'wait' && orderData.active == 1
                ? FadeInUp(
                    child: GestureDetector(
                      onTap: () {
                        controller.cancelOrder(orderData.id);
                      },
                      child: Container(
                        width: Get.width / 1.1,
                        height: sizeH50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(sizeW45),
                            color: Colors.white,
                            border: Border.all(color: primaryColor)),
                        child: Center(
                          child: Text(
                            'cancel'.tr,
                            style: TextStyle(
                              fontSize: sizeW22,
                              color: primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),

            SizedBox(
              height: type == 'Order Preparing' ||
                      type == 'Out for delivery' && orderData.active == 1
                  ? sizeW35
                  : 0,
            ),
            type == 'Order Preparing' ||
                    type == 'Out for delivery' && orderData.active == 1
                ? FadeInUp(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: Get.width / 1.1,
                          height: sizeH50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(sizeW45),
                              color: Colors.white,
                              border: Border.all(color: grey5)),
                          child: Center(
                            child: Text(
                              'cancel'.tr,
                              style: TextStyle(
                                fontSize: sizeW22,
                                color: grey5,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: sizeH5,
                        ),
                        Text(
                          'Order is preparing and can’t be cancelled'.tr,
                          style: TextStyle(
                            fontSize: sizeW14,
                            color: greyOpacityColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  List<Widget> createItems() {
    List<Widget> imageSliders = items.asMap().entries.map((item) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(item.value['product_name'],
                  style: TextStyle(
                      fontSize: sizeW14,
                      fontWeight: FontWeight.w400,
                      color: greyOpacityColor)),
              Text('${item.value['all_total']} ${'SAR'.tr}',
                  style: TextStyle(
                      fontSize: sizeW14,
                      fontWeight: FontWeight.w400,
                      color: greyOpacityColor)),
            ],
          ),
          SizedBox(
            height: sizeH5,
          ),
        ],
      );
    }).toList();
    return imageSliders;
  }
}
