import 'package:get/get.dart';

import '../../utility/General.dart';

class CartCountController extends GetxController {
  var cartCoynt = 0.obs;

  @override
  void onInit() {
    cartCoynt.value = int.parse(General.cartCount.toString());
    super.onInit();
  }
}
