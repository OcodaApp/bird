// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../constance.dart';
import 'controllers/create_acc_controller.dart';
import 'login_view.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class CreateAccView extends StatelessWidget {
  String email,type;
  CreateAccView({Key? key,required this.email,required this.type}) : super(key: key);
  final CreateAccController controller = Get.put(CreateAccController());
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final pageIndexNotifier = ValueNotifier(0);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: Get.width,
        height: Get.height,
        color: Colors.white,
        padding: EdgeInsets.all(sizeW15),
        child: ListView(
          children: [
            SizedBox(height: sizeH25,),
            Image.asset('assets/logo2.png',width: Get.width / 1.7,height: Get.height/4.8,),
            SizedBox(height: sizeH25,),
            Text('Create account'.tr,style: TextStyle(fontSize: sizeW25,fontWeight: FontWeight.w600,color: blackolor),textAlign: TextAlign.center,),
            SizedBox(height: sizeH25,),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('First Name'.tr,style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w600,color: greyOpacityColor),textAlign: TextAlign.center,),
                    ],
                  ),
                  SizedBox(height: sizeH10,),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType : TextInputType.name,
                    controller: controller.fristName,
                    decoration:  InputDecoration(
                      hintText: 'Enter Your First Name'.tr,
                      contentPadding: EdgeInsets.only(
                        top: 0,
                        bottom: 0,
                        right: sizeW15,
                        left: sizeW15,
                      ),
                      border:  OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(sizeW45)),
                        borderSide: const BorderSide(
                          color: grey3,
                          width: 0.8,
                        ),
                      ),
                      
                      hintStyle:  TextStyle(
                        fontSize: sizeW16,
                        color: blackolor,
                        fontWeight: FontWeight.w300,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:  BorderRadius.all(Radius.circular(sizeW45)),
                        borderSide: const BorderSide(
                          color: grey3,
                          width: 0.8,
                        ),
                      ),
                      focusedBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(sizeW45)),
                        borderSide: const BorderSide(
                          color: grey3,
                          width: 1,
                        ),
                      ),
                    ),
                    style:  TextStyle(
                      fontSize: sizeW16,
                      color: blackolor,
                      fontWeight: FontWeight.w300,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter First Name'.tr;
                      }
                      return null;
                    },
                  ),
                  
                  SizedBox(height: sizeH15,),
                  Row(
                    children: [
                      Text('Password'.tr,style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w600,color: greyOpacityColor),textAlign: TextAlign.center,),
                    ],
                  ),
                  SizedBox(height: sizeH10,),
                  Obx(() => TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType : TextInputType.visiblePassword,
                    obscureText: controller.showPass.value ?false:true,
                    controller: controller.password,
                    decoration:  InputDecoration(
                      suffixIcon: Padding(
                        padding:  const EdgeInsets.fromLTRB(0, 0, 4, 0),
                        child: GestureDetector(
                          onTap: (){
                            if(controller.showPass.value){
                              controller.showPass.value = false;
                            }else{
                              controller.showPass.value = true;
                            }
                            
                          },
                          child: Icon(
                            Icons.visibility_rounded,
                            size: sizeW25,
                            color: controller.showPass.value ? primaryColor :grey4,
                          ),
                        ),),
                      hintText: 'Enter Your Password'.tr,
                      contentPadding: EdgeInsets.only(
                        top: 0,
                        bottom: 0,
                        right: sizeW15,
                        left: sizeW15,
                      ),
                      border:  OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(sizeW45)),
                        borderSide: const BorderSide(
                          color: grey3,
                          width: 0.8,
                        ),
                      ),
                      
                      hintStyle:  TextStyle(
                        fontSize: sizeW16,
                        color: blackolor,
                        fontWeight: FontWeight.w300,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:  BorderRadius.all(Radius.circular(sizeW45)),
                        borderSide: const BorderSide(
                          color: grey3,
                          width: 0.8,
                        ),
                      ),
                      focusedBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(sizeW45)),
                        borderSide: const BorderSide(
                          color: grey3,
                          width: 1,
                        ),
                      ),
                    ),
                    style:  TextStyle(
                      fontSize: sizeW16,
                      color: blackolor,
                      fontWeight: FontWeight.w300,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Your Password'.tr;
                      }
                      if (value.length < 4) {
                        return 'Enter a stronger password'.tr;
                      }
                      return null;
                    },
                  ),),
                ],
              ),
            ),
            SizedBox(height: sizeH15,),
            MaterialButton(
              elevation: 0,
              color: primaryColor,
              minWidth: Get.width / 1.1,
              height: sizeH50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(45),
              ),
              onPressed: (){
                if (!_formKey.currentState!.validate()) {
                }else{
                  if(controller.terms.value == 1){
                    controller.signUp(email,context);
                  }else{
                    Fluttertoast.showToast(
                      msg: 'termsCheck'.tr,
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.redAccent,
                      textColor: Colors.white,
                      fontSize: sizeW14,
                    );
                  }
                }
              },
              child: Text(
                'Submit'.tr,
                style:  TextStyle(
                  fontSize: sizeW22,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: sizeH15,),
            GestureDetector(
              onTap: (){
                Get.to(()=> LoginView());
              },
              child: Center(
                child: Text.rich(
                  TextSpan(
                    children: [
                       TextSpan(
                        text: 'Already have an account?'.tr,
                        style:  TextStyle(
                          fontSize: sizeW16,
                          color: greyOpacityColor,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      TextSpan(
                        text: 'Login'.tr,
                        style:  TextStyle(
                          fontSize: sizeW16,
                          color: primaryColor,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
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
                    Navigator.of(context).pop();
                    pageIndexNotifier.value = 0;
                  },
                  // maxDialogWidth: 560,
                  // minDialogWidth: 400,
                  // minPageHeight: 0.0,
                  // maxPageHeight: Get.height /2,
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Obx(() => SizedBox(
                    width: sizeW20,
                    child: Radio(
                      value: controller.terms.value,
                      groupValue: 1,
                      activeColor: primaryColor,
                      onChanged: (value) {
                      },
                    ),
                  ),),
                  SizedBox(width: sizeH10,),
                  SizedBox(
                    width: Get.width / 1.2,
                    child: Text.rich(
                      TextSpan(
                        children: [
                           TextSpan(
                            text: 'By clicking this it means that you are agree to'.tr,
                            style:  TextStyle(
                              fontSize: sizeW14,
                              color: greyOpacityColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: 'Terms & conditions'.tr,
                            style:  TextStyle(
                              fontSize: sizeW14,
                              color: primaryColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
