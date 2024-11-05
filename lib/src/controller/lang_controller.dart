import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utility/local_storage/local_storgae.dart';
import 'tabbar_controller.dart';

class LangController extends GetxController {
  final TabBarController tabBarController = Get.put(TabBarController());
  var appLocale = Platform.localeName.substring(0, 2);

  @override
  void onInit() async {
    String phoneLang;
    if (Platform.localeName.substring(0, 2) != 'ar' &&
        Platform.localeName.substring(0, 2) != 'en') 
    {
      phoneLang = 'en';
    } else {
      phoneLang = Platform.localeName.substring(0, 2);
    }

    LocalStorage localStorage = LocalStorage();
    appLocale = await localStorage.languageSelected ?? phoneLang;

    update();
    Get.updateLocale(Locale(appLocale));
    super.onInit();
  }

  void changeLanguage(String type) async {
    LocalStorage localStorage = LocalStorage();
    if (type == 'ar') {
      appLocale = 'ar';
      localStorage.saveLanguageToDisk('ar');
      Get.updateLocale(const Locale('ar', 'EG'));
      tabBarController.onTabTapped(0);
      Get.offAllNamed('/Splash');
    } else {
      appLocale = type;
      localStorage.saveLanguageToDisk(type);
      Get.updateLocale(Locale(type, 'EG'));
      tabBarController.onTabTapped(0);
      Get.offAllNamed('/Splash');
    }
  }
}
