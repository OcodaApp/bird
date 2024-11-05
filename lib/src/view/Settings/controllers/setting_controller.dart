

// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:birdandroid/utility/General.dart';
import 'package:get/get.dart';


class SettingsController extends SuperController {
  var current = 0.obs;
  var email = General.mobile.obs;
  var name = General.username.obs;
  var imageUrl = General.imgurl.obs;
  var image= General.image.obs;
  var isImage = false.obs;

  
  @override
  void onInit() {
    if(General.image != 'null'){
      isImage.value = true;
      imageUrl.value = General.imgurl;
      image.value = General.image;
    }else{
      isImage.value = false;
      imageUrl.value = '';
      image.value = '';
    }
    email.value = General.mobile;
    name.value = General.username;
    super.onInit();
  }

  @override
  void onDetached() {
    email.value = General.mobile;
    name.value = General.username;
  }

  @override
  void onInactive() {
    email.value = General.mobile;
    name.value = General.username;
  }

  @override
  void onPaused() {
    email.value = General.mobile;
    name.value = General.username;
  }

  @override
  void onResumed() {
    email.value = General.mobile;
    name.value = General.username;
  }

  @override
  void onClose() {
    email.value = General.mobile;
    name.value = General.username;
    super.onClose();
  }

  @override
  void onHidden() {
    // TODO: implement onHidden
  }
}
