

// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:birdandroid/utility/General.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../../../../constance.dart';
import '../../../../http/request.dart';
import '../../../../http/url.dart';
import '../../../../model/policy_list_modal2.dart';
import '../../../../model/policy_list_model.dart';
import '../../../../model/terms_list_model.dart';
import '../../../../model/terms_list_model2.dart';
import '../../../controller/lang_controller.dart';


class TermsController extends GetxController {
  
  // setting
  var termsUpdated = ''.obs;
  var policyUpdated = ''.obs;
  var isData = false.obs;
  var settingsData = [].obs;
  var policyData = [].obs;
  void getSettingList() async {
    Request request = Request(url: urlGetSetting, body: null);
    request.get().then((value) async {
      if (value['status']) {
        if(General.type == 'user'){
          termsUpdated.value = value['data']['terms_updated_user'];
          policyUpdated.value = value['data']['policy_updated_user'];
          TermsListModel termsListModel = TermsListModel.fromJson(value['data']);
          settingsData.value = termsListModel.terms!;

          PolicyListModel policyListModel = PolicyListModel.fromJson(value['data']);
          policyData.value = policyListModel.plicy!;
        }else{
          termsUpdated.value = value['data']['terms_updated_delegate'];
          policyUpdated.value = value['data']['policy_updated_delegate'];
          TermsListModel2 termsListModel = TermsListModel2.fromJson(value['data']);
          settingsData.value = termsListModel.terms!;

          PolicyListModel2 policyListModel = PolicyListModel2.fromJson(value['data']);
          policyData.value = policyListModel.plicy!;
        }
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
    getSettingList();
    super.onInit();
  }

  List<Widget> terms() {
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

  List<Widget> policys() {
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
  page1(modalSheetContext) {
    return WoltModalSheetPage(
      navBarHeight : sizeH30,
      hasSabGradient: false,
      stickyActionBar: Container(
        padding:  EdgeInsets.all(sizeW10),
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
            Get.back();
          },
          child:  Text(
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
          padding:   EdgeInsets.only(right: sizeW15,left: sizeW15),
          child: ListView(
            children:  [
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
                children: terms(),),
              SizedBox(height: sizeH100,),
            ],
          ),
        ),
      ),
    );
  }
  page2(modalSheetContext) {
    return WoltModalSheetPage(
      navBarHeight : sizeH30,
      hasSabGradient: false,
      stickyActionBar: Container(
        padding:  EdgeInsets.all(sizeW10),
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
            Get.back();
          },
          child:  Text(
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
          padding:   EdgeInsets.only(right: sizeW15,left: sizeW15),
          child: ListView(
            children:  [
              Text(
                ' Privacy Policy'.tr,
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
                children: policys(),),
              SizedBox(height: sizeH100,),
            ],
          ),
        ),
      ),
    );
  }
  final LangController langController = Get.put(LangController());

  var chooseLang = ''.obs;
  page3( modalSheetContext) {
    chooseLang.value = langController.appLocale;
    return SliverWoltModalSheetPage(
      isTopBarLayerAlwaysVisible: true,
      hasTopBarLayer : true,
      topBarTitle: Text('Lang'.tr,style: TextStyle(fontSize: sizeW18,fontWeight: FontWeight.w600,color: primaryColor),),
      trailingNavBarWidget: IconButton(
        padding:  EdgeInsets.all(sizeW10),
        icon:  Icon(Icons.close,color: const Color.fromARGB(255, 153, 152, 152),size: sizeW15,),
        onPressed: () {
          Navigator.of(modalSheetContext).pop();
        },
      ),
      mainContentSliversBuilder: (_)=> [
        SliverPadding(
          padding: EdgeInsets.all(sizeW10),
          sliver: const SliverToBoxAdapter(
          ),
        ),
        SliverPadding(
          padding:EdgeInsets.all(sizeW10),
          sliver: SliverToBoxAdapter(
            child: Column(
              children: [
                GestureDetector(
                  onTap: (){
                    chooseLang.value = 'en';
                  },
                  child: Container(
                    width: Get.width / 1,
                    padding: EdgeInsets.only(right: sizeW20,left: sizeW20,top: sizeH5,bottom: sizeH5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(sizeW45),
                      color:  Colors.white,
                      border: Border.all(color: const Color(0xFFE6E6E6))
                    ),
                    child: Row(
                      children: [
                        Obx(() => SizedBox(
                          width: sizeW20,
                          child: Radio(
                            value: chooseLang.value == 'en'? 1:0,
                            groupValue: 1,
                            activeColor: primaryColor,
                            onChanged: (value) {
                              chooseLang.value == 'en';
                            },
                          ),
                        ),),
                        SizedBox(width: sizeW15,),
                        Image.asset('assets/icons/en.png',height: sizeW25,width: sizeW30,fit: BoxFit.fill,),
                         SizedBox(width: sizeW10,),
                         Text(
                          'En'.tr,
                          style:  TextStyle(
                            fontSize: sizeW14,
                            color: primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: sizeH15,),
                GestureDetector(
                  onTap: (){
                    chooseLang.value = 'ar';
                  },
                  child: Container(
                    width: Get.width / 1,
                    padding:  EdgeInsets.only(right: sizeW20,left: sizeW20,top: sizeH5,bottom: sizeH5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(sizeW45),
                      color:  Colors.white,
                      border: Border.all(color: const Color(0xFFE6E6E6))
                    ),
                    child: Row(
                      children: [
                        Obx(() => SizedBox(
                          width: sizeW20,
                          child: Radio(
                            value: chooseLang.value == 'ar'? 2:0,
                            groupValue: 2,
                            activeColor: primaryColor,
                            onChanged: (value) {
                              chooseLang.value == 'ar';
                            },
                          ),
                        ),),
                        SizedBox(width: sizeW15,),
                        Image.asset('assets/icons/sa.png',height: sizeW25,width: sizeW30,fit: BoxFit.fill,),
                        SizedBox(width: sizeW10,),
                         Text(
                          'Ar'.tr,
                          style:  TextStyle(
                            fontSize: sizeW14,
                            color: greyOpacityColor,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Bahij'
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding:  EdgeInsets.all(sizeW10),
          sliver: SliverToBoxAdapter(
            child: Container(
              padding:  EdgeInsets.all(sizeW10),
              color: Colors.white,
              child: MaterialButton(
                elevation: 0,
                color:  primaryColor,
                minWidth: Get.width / 1.1,
                height: sizeH50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(45),
                ),
                onPressed: (){
                  if(langController.appLocale == chooseLang.value){
                    Get.back();
                  }else{
                    if(chooseLang.value != ''){
                      langController.changeLanguage(chooseLang.value);
                    }else{
                      Get.back();
                    }
                  }
                },
                child:  Text(
                  'send'.tr,
                  style:  TextStyle(
                    fontSize: sizeW22,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
        
      ],
    );
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
