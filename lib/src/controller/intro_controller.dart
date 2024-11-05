

import 'package:get/get.dart';
import '../../http/request.dart';
import '../../http/url.dart';
import '../../model/intros_list_model.dart';

class IntroController extends GetxController {
  var current = 0.obs;
  var isData = false.obs;
  var introsData = [].obs;
  // intros
  void getIntrosList() async {
    Request request = Request(url: urlIntros, body: null);
    request.get().then((value) async {
      if (value['status']) {
        IntrosListModel introsListModel = IntrosListModel.fromJson(value);
        introsData.value = introsListModel.intros!;
        isData.value = true;
      } else {
        // Get.offNamed('/loginView');
      }
    }).catchError((onError) {
      // Get.offNamed('/loginView');
    });
  }

  @override
  void onInit() {
    getIntrosList();
    super.onInit();
  }
}
