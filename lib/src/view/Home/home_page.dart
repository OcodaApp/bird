// ignore_for_file: must_be_immutable

import 'package:birdandroid/src/view/user/login_or_signapp.dart';
import 'package:birdandroid/utility/General.dart';
import 'package:carousel_slider/carousel_slider.dart' as ca;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';
import '../../../constance.dart';
import '../../../utility/Address.dart';
import '../../controller/cart_count_controller.dart';
import '../../controller/send_test_controller.dart';
import '../Cart/cart_view.dart';
import '../Package/package_view.dart';
import '../Restaurants/restaurants_page.dart';
import '../badge.dart';
import '../user/login_view.dart';
import 'controllers/home_controller.dart';
import 'restaurant_slider.dart';
import 'search_home.dart';

class HomePageView extends StatelessWidget {
  HomePageView({Key? key}) : super(key: key);
  final HomeController controller = Get.put(HomeController());
  final CartCountController cartCountcontroller =
      Get.put(CartCountController());
  final SendNotfyTestController send = Get.put(SendNotfyTestController());
  final ca.CarouselSliderController introCarousel = ca.CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        controller.getIntrosList();
        controller.getAddressUser();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        // floatingActionButton: GestureDetector(
        //   onTap: (){
        //     send.sendAndRetrieveMessage();
        //     // controller.createRecord(General.latitude,General.longitude);
        //   },
        //   child: Container(width: 50,height: 50,color: primaryColor,)),
        body: Container(
          width: Get.width,
          height: Get.height,
          padding: EdgeInsets.all(sizeW20),
          child: ListView(
            children: [
              FadeInRight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: Get.width / 1.3,
                      child: Wrap(
                        children: [
                          Text(
                            'Good evening'.tr,
                            style: TextStyle(
                                color: blackolor,
                                fontSize: sizeW18,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            ' '.tr,
                            style: TextStyle(
                                color: blackolor,
                                fontSize: sizeW18,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            '${General.username}!'.tr,
                            style: TextStyle(
                                color: blackolor,
                                fontSize: sizeW18,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => General.token.isNotEmpty
                              ? CartView()
                              : LoginView());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Obx(
                              () => SizedBox(
                                width: sizeW25,
                                child: IconBadge(
                                  icon: 'assets/bag.png',
                                  itemCount:
                                      cartCountcontroller.cartCoynt.value,
                                  badgeColor: primaryTowColor,
                                  itemColor: Colors.white,
                                  hideZero: true,
                                  onTap: () {
                                    Get.to(() => General.token.isNotEmpty
                                        ? CartView()
                                        : LoginView());
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: sizeH20,
              ),
              FadeInRight(
                child: GestureDetector(
                    onTap: () {
                      Get.to(() => StoresSearchHome());
                    },
                    child: Container(
                      height: sizeH40,
                      width: Get.width,
                      padding: EdgeInsets.only(right: sizeW15, left: sizeW15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(sizeW25),
                          border: Border.all(color: grey3, width: 0.8)),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/search2.png",
                            color: primaryColor,
                            width: sizeW20,
                            height: sizeW20,
                          ),
                          SizedBox(
                            width: sizeW15,
                          ),
                          Text(
                            'searchHome'.tr,
                            style: TextStyle(
                              fontSize: sizeW14,
                              color: grey5,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
              SizedBox(
                height: sizeH15,
              ),
              Visibility(
                visible: Address.a_id.isNotEmpty,
                child: FadeInRight(
                  child: Row(
                    children: [
                      Text(
                        'Delivering to'.tr,
                        style: TextStyle(
                            color: greyOpacityColor,
                            fontSize: sizeW14,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: Address.a_id.isNotEmpty,
                child: FadeInRight(
                  child: GestureDetector(
                    onTap: () {
                      controller.getAddressUser();
                      controller.addrssId.value = int.parse(Address.a_id);
                      WoltModalSheet.show<void>(
                        pageIndexNotifier: controller.pageIndexNotifier,
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
                          Navigator.of(context).pop();
                          controller.pageIndexNotifier.value = 0;
                        },
                        // minPageHeight: 0.0,
                        // maxPageHeight: Get.height /2,
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(
                          () => SizedBox(
                              width: Get.width / 1.3,
                              child: Text(
                                '${controller.addrssName.value} ${controller.addrssStreet.value}',
                                style: TextStyle(
                                    color: primaryColor,
                                    fontSize: sizeW16,
                                    fontWeight: FontWeight.w500),
                                overflow: TextOverflow.ellipsis,
                              )),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: primaryColor,
                                size: sizeW25,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: sizeH10,
              ),
              FadeInUp(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(
                            () => RestaurantPage(
                                  type: 'shop',
                                ),
                            arguments: ['shop']);
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/sections/1.png',
                            height: sizeH100,
                            width: Get.width / 3.6,
                          ),
                          Text(
                            'Stores'.tr,
                            style: TextStyle(
                                color: blackolor,
                                fontSize: sizeW16,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(
                            () => RestaurantPage(
                                  type: 'supermarket',
                                ),
                            arguments: ['supermarket']);
                      },
                      child: Column(
                        children: [
                          Image.asset('assets/sections/2.png',
                              height: sizeH100, width: Get.width / 3.6),
                          Text(
                            'Supermarket'.tr,
                            style: TextStyle(
                                color: blackolor,
                                fontSize: sizeW16,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => RestaurantPage(type: 'restaurant'),
                            arguments: ['restaurant']);
                      },
                      child: Column(
                        children: [
                          Image.asset('assets/sections/3.png',
                              height: sizeH100, width: Get.width / 3.6),
                          Text(
                            'Restaurants'.tr,
                            style: TextStyle(
                                color: blackolor,
                                fontSize: sizeW16,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              FadeInUp(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(
                            () => RestaurantPage(
                                  type: 'pharmacy',
                                ),
                            arguments: ['pharmacy']);
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/sections/4.png',
                            height: sizeH100,
                            width: Get.width / 3.6,
                          ),
                          Text(
                            'Pharmacies'.tr,
                            style: TextStyle(
                                color: blackolor,
                                fontSize: sizeW16,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: sizeW10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => PackageView());
                      },
                      child: Column(
                        children: [
                          Image.asset('assets/sections/5.png',
                              height: sizeH100, width: Get.width / 3.6),
                          Text(
                            'Deliver Package'.tr,
                            style: TextStyle(
                                color: blackolor,
                                fontSize: sizeW16,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: sizeH25,
              ),
              Obx(() => controller.isSliders.value
                  ? SizedBox(
                      height: sizeH100,
                      child: ca.CarouselSlider(
                        options: ca.CarouselOptions(
                          height: Get.height,
                          viewportFraction: 1.0,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          aspectRatio: 2.0,
                          initialPage: 0,
                          onPageChanged: (index, reason) {
                            // controller.current.value = index;
                          },
                        ),
                        carouselController: introCarousel,
                        items: createSliders(),
                      ),
                    )
                  : Container()),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> createSliders() {
    List<Widget> imageSliders = controller.slidersData.map((item) {
      return SizedBox(
        width: Get.width,
        height: Get.height,
        child: item != null
            ? GestureDetector(
                onTap: () async {
                  if (item.type == 'delivery_service') {
                    Get.to(() => PackageView());
                  } else {
                    await Get.to(
                        () => RestaurantSlider(
                              storeData: item.store,
                            ),
                        arguments: [item.store['id'], item.store['user_fav']]);
                  }
                },
                child: Container(
                  width: Get.width,
                  height: Get.height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(sizeW15),
                    image: DecorationImage(
                      image: NetworkImage(
                        '${item.img}',
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              )
            : Image.asset('assets/sliders.png'),
      );
    }).toList();
    return imageSliders;
  }
}
