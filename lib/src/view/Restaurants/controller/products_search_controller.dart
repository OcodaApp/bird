import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ProductsSearchController extends GetxController {
  TextEditingController searchTextController = TextEditingController();
  var productsData = [].obs;
  @override
  void onInit() {
    productsData.value = Get.arguments[0];
    searchTextController = TextEditingController();
    super.onInit();
  }

  List searchResult = [].obs;
  onSearchTextChanged(String text) async {
    searchResult.clear();
    // ignore: avoid_function_literals_in_foreach_calls
    productsData.forEach((countryDetail) {
      if (countryDetail.name!.toLowerCase().contains(text.toLowerCase())) {
        searchResult.add(countryDetail);
      }
    });
  }

  @override
  void onClose() {
    searchTextController.dispose();
    super.onClose();
  }
}
