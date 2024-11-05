import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:page_route_transition/page_route_transition.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';
import '../../../../constance.dart';
import '../../../../http/request.dart';
import '../../../../http/url.dart';
import '../../../../model/terms_list_model.dart';
import '../login_view.dart';

class CreateAccController extends GetxController {
  late TextEditingController fristName;
  late TextEditingController password;
  var terms = 0.obs;
  var showPass = false.obs;

  String? deviceToken = '';
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  getToken() async {
    await firebaseMessaging.getToken().then((value) {
      deviceToken = value!;
    });
  }
  
  // setting
  var termsUpdated = ''.obs;
  var isData = false.obs;
  var settingsData = [].obs;
  void getSettingList() async {
    Request request = Request(url: urlGetSetting, body: null);
    request.get().then((value) async {
      if (value['status']) {
        termsUpdated.value = value['data']['terms_updated_user'];
        TermsListModel termsListModel = TermsListModel.fromJson(value['data']);
        settingsData.value = termsListModel.terms!;
        isData.value = true;
      } else {
        isData.value = false;
      }
    }).catchError((onError) {
      isData.value = false;
    });
  }

  @override
  void onInit() {
    getToken();
    getSettingList();
    fristName = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  SliverWoltModalSheetPage page1(BuildContext modalSheetContext) {
    return WoltModalSheetPage(
      navBarHeight : sizeH30,
      hasSabGradient: false,
      stickyActionBar: Container(
        padding: EdgeInsets.all(sizeW10),
        color: Colors.white,
        child: MaterialButton(
          elevation: 0,
          color: primaryColor,
          minWidth: Get.width / 1.1,
          height: sizeH50,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(sizeW45),
          ),
          onPressed: (){
            FocusManager.instance.primaryFocus?.unfocus();
            terms.value = 1;
            Get.back();
          },
          child: Text(
            'Got it'.tr,
            style:  TextStyle(
              fontSize: sizeW22,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      // topBarTitle: const Text('Pagination'),
      isTopBarLayerAlwaysVisible: false,
      
      child: SizedBox(
        height: Get.height / 1.3,
        child:  Padding(
          padding: EdgeInsets.only(right: sizeW15,left: sizeW15),
          child: ListView(
            children:[
              Text(
                'Terms & conditions'.tr,
                style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w800),
              ),
              SizedBox(height: sizeH15,),
              Text(
                termsUpdated.value,
                style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w500,color: const Color(0xFF808080)),
              ),
              
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: createSliders(),),
              SizedBox(height: sizeH100,),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> createSliders() {
    List<Widget> imageSliders = settingsData.map((item) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: sizeH15,),
          Text(
            '${item.name}',
            style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w600),
          ),
          Text(
            '${item.desc}',
            style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w400,color: const Color(0xFF999999)),
          ),
        ],
      );
    }).toList();
    return imageSliders;
  }

  void signUp(email,context) async {
    var data = {
      'device_token': deviceToken,
      'phone': '966$email',
      'name': fristName.text,
      'password': password.text,
      'type': 'client',
    };
    Request request = Request(url: urlsignUp, body: data);
    request.post().then((value) {
      if (value['status']) {
        Fluttertoast.showToast(
          msg: value['msg'],
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.greenAccent,
          textColor: Colors.white,
          fontSize: sizeW14,
        );
        PageRouteTransition.effect = TransitionEffect.scale;
        PageRouteTransition.push(context,  LoginView());
      } else {
        Fluttertoast.showToast(
          msg: value['msg'],
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: sizeW14,
        );
      }
    }).catchError((onError) {
      Fluttertoast.showToast(
        msg: 'agien'.tr,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: sizeW14,
      );
    });
  }

  @override
  void onClose() {
    fristName.dispose();
    password.dispose();
    super.onClose();
  }
}
