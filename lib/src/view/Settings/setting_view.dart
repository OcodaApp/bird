// ignore_for_file: must_be_immutable

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';
import '../../../constance.dart';
import 'complains_view.dart';
import 'contact_view.dart';
import 'controllers/terms_controller.dart';
import 'post_complain_view.dart';

class SettingView extends StatelessWidget {
  SettingView({Key? key}) : super(key: key);
  final TermsController controller = Get.put(TermsController());
  @override
  Widget build(BuildContext context) {
    final pageIndexNotifier = ValueNotifier(0);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: Get.width,
        height: Get.height,
        color: Colors.white,
        padding:  EdgeInsets.all(sizeW15),
        child: ListView(
          children: [
            FadeInRight(
              child:  Text('Settings'.tr,style: TextStyle(color: primaryColor,fontSize: sizeW20,fontWeight: FontWeight.w600),),
            ),
            SizedBox(height: sizeH20,),
            GestureDetector(
              onTap: (){
                Get.to(()=> ComplainsView());
              },
              child: Container(
                padding:  EdgeInsets.only(bottom: sizeH10),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color:  grey3.withOpacity(0.1)),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        FadeInDown(child:Image.asset('assets/icons/msg.png',width: sizeW35,height: sizeH35,fit: BoxFit.fill,),),
                         SizedBox(width: sizeW15,),
                         Text('Your complains'.tr,style: TextStyle(color: primaryColor,fontSize: sizeW16,fontWeight: FontWeight.w600),),
                      ],
                    ),
                     Icon(Icons.arrow_forward_ios_outlined,size: sizeW16,color: primaryColor,),
                  ],
                ),
              ),
            ),
             SizedBox(height: sizeH10,),
            GestureDetector(
              onTap: (){
                WoltModalSheet.show<void>(
                  pageIndexNotifier: pageIndexNotifier,
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
                    debugPrint('Closed modal sheet with barrier tap');
                    Navigator.of(context).pop();
                    pageIndexNotifier.value = 0;
                  },
                  // maxDialogWidth: 560,
                  // minDialogWidth: 400,
                  // minPageHeight: 0.0,
                  // maxPageHeight: Get.height /2,
                );
              },
              child: Container(
                padding:  EdgeInsets.only(bottom: sizeH10),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color:  grey3.withOpacity(0.1)),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        FadeInDown(child:Image.asset('assets/icons/lang.png',width: sizeW35,height: sizeH35,fit: BoxFit.fill,),),
                         SizedBox(width: sizeW15,),
                         Text('Languages'.tr,style: TextStyle(color: primaryColor,fontSize: sizeW16,fontWeight: FontWeight.w600),),
                      ],
                    ),
                     Icon(Icons.arrow_forward_ios_outlined,size: sizeW16,color: primaryColor,),
                  ],
                ),
              ),
            ),
             SizedBox(height: sizeH10,),
            GestureDetector(
              onTap: (){
                Get.to(()=>ContactView());
              },
              child: Container(
                padding:  EdgeInsets.only(bottom: sizeH10),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color:  grey3.withOpacity(0.1)),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        FadeInDown(child:Image.asset('assets/icons/chat.png',width: sizeW35,height: sizeH35,fit: BoxFit.fill,),),
                         SizedBox(width: sizeW15,),
                         Text('Contact Us'.tr,style: TextStyle(color: primaryColor,fontSize: sizeW16,fontWeight: FontWeight.w600),),
                      ],
                    ),
                     Icon(Icons.arrow_forward_ios_outlined,size: sizeW16,color: primaryColor,),
                  ],
                ),
              ),
            ),
            SizedBox(height: sizeH10,),
            GestureDetector(
              onTap: (){
                Get.to(()=> PostComplainView());
              },
              child: Container(
                padding:  EdgeInsets.only(bottom: sizeH10),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color:  grey3.withOpacity(0.1)),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        FadeInDown(child:Image.asset('assets/icons/contact.png',width: sizeW35,height: sizeH35,fit: BoxFit.fill,),),
                         SizedBox(width: sizeW15,),
                         Text('File a complain'.tr,style: TextStyle(color: primaryColor,fontSize: sizeW16,fontWeight: FontWeight.w600),),
                      ],
                    ),
                     Icon(Icons.arrow_forward_ios_outlined,size: sizeW16,color: primaryColor,),
                  ],
                ),
              ),
            ),

            SizedBox(height: sizeH10,),
           
            GestureDetector(
              onTap: (){
                WoltModalSheet.show<void>(
                  pageIndexNotifier: pageIndexNotifier,
                  context: context,
                  pageListBuilder: (modalSheetContext) {
                    return [
                      controller.page1(modalSheetContext),
                    ];
                  },
                  modalTypeBuilder: (context) {
                    return WoltModalType.bottomSheet();
                  },
                  onModalDismissedWithBarrierTap: () {
                    debugPrint('Closed modal sheet with barrier tap');
                    Navigator.of(context).pop();
                    pageIndexNotifier.value = 0;
                  },
                  // maxDialogWidth: 560,
                  // minDialogWidth: 400,
                  // minPageHeight: 0.0,
                  // maxPageHeight: Get.height /2,
                );
              },
              child: Container(
                padding:  EdgeInsets.only(bottom: sizeH10),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color:  grey3.withOpacity(0.1)),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        FadeInDown(child:Image.asset('assets/icons/note.png',width: sizeW35,height: sizeH35,fit: BoxFit.fill,),),
                         SizedBox(width: sizeW15,),
                         Text('Terms & conditions'.tr,style: TextStyle(color: primaryColor,fontSize: sizeW16,fontWeight: FontWeight.w600),),
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios_outlined,size: sizeW16,color: primaryColor,),
                  ],
                ),
              ),
            ),
             SizedBox(height: sizeH10,),
            GestureDetector(
              onTap: (){
                WoltModalSheet.show<void>(
                  pageIndexNotifier: pageIndexNotifier,
                  context: context,
                  pageListBuilder: (modalSheetContext) {
                    return [
                      controller.page2(modalSheetContext),
                    ];
                  },
                  modalTypeBuilder: (context) {
                    return WoltModalType.bottomSheet();
                  },
                  onModalDismissedWithBarrierTap: () {
                    debugPrint('Closed modal sheet with barrier tap');
                    Navigator.of(context).pop();
                    pageIndexNotifier.value = 0;
                  },
                  // maxDialogWidth: 560,
                  // minDialogWidth: 400,
                  // minPageHeight: 0.0,
                  // maxPageHeight: Get.height /2,
                );
              },
              child: Container(
                padding:  EdgeInsets.only(bottom: sizeH10),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color:  grey3.withOpacity(0.1)),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        FadeInDown(child:Image.asset('assets/icons/key.png',width: sizeW35,height: sizeH35,fit: BoxFit.fill,),),
                         SizedBox(width: sizeW15,),
                         Text(' Privacy Policy'.tr,style: TextStyle(color: primaryColor,fontSize: sizeW16,fontWeight: FontWeight.w600),),
                      ],
                    ),
                     Icon(Icons.arrow_forward_ios_outlined,size: sizeW16,color: primaryColor,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
