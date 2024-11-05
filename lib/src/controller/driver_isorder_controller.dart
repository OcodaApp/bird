import 'package:get/get.dart';

import '../../utility/General.dart';


class DriverIsOrderCountController extends GetxController {
  var isOrder = false.obs;

  @override
  void onInit() {
    isOrder.value = General.isOrder;
    super.onInit();
  }
}
