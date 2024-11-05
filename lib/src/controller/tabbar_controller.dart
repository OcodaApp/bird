
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constance.dart';

class TabBarController extends GetxController
    with SingleGetTickerProviderMixin {
  var tabIndex = 0;
  var tabName = ''.obs;

  @override
  void onInit() {
    tabName.value ='Home'.tr;
    update();
    super.onInit();
  }

  // ignore: missing_return
   appBarCustum(isTablet) {
    if (tabIndex == 0) {
      return PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: Container(color: primaryColor),
      );
    } else if (tabIndex == 1) {
      return PreferredSize(
        preferredSize:
            Size.fromHeight(isTablet ? Get.height / 12: Get.height / 15), // here the desired height
        child: Container(),
      );
    } else if (tabIndex == 2) {
      return PreferredSize(
        preferredSize:
            Size.fromHeight(isTablet ? Get.height / 12: Get.height / 15), // here the desired height
        child: Container(),
      );
    } else if (tabIndex == 3) {
      return PreferredSize(
        preferredSize:
            Size.fromHeight(Get.height / 2.5), // here the desired height
        child: Container(),
      );
    }
  }

  void onTabTapped(int index) {
    tabIndex = index;

    switch (index) {
      case 0:
        {
          tabName.value ='Home'.tr;
        }
        break;
      case 1:
        {
          tabName.value = 'explore'.tr;
        }
        break;
      case 2:
        {
          tabName.value = 'my reservations'.tr;
        }
        break;
      case 3:
        {
          tabName.value = 'Arithmetic'.tr;
        }
        break;
    }
    update();
  }

  void changeTabIndex(int index) {
    tabIndex = index;
    update();
  }
}
