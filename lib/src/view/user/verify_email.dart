// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_route_transition/page_route_transition.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../constance.dart';
import 'create_acc.dart';
import 'drivers/crearte_acc_driver.dart';
class VerifyView extends StatelessWidget {
  String email,code,type;
  VerifyView({Key? key,required this.code,required this.email,required this.type}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  StreamController<ErrorAnimationType>? errorController;
  TextEditingController textEditingController = TextEditingController();
  String currentText = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: Get.width,
        height: Get.height,
        color: Colors.white,
        padding:  EdgeInsets.all(sizeW15),
        child: ListView(
          children: [
            SizedBox(height: sizeH50,),
            Image.asset('assets/logo.png',width: Get.width / 2,height: Get.height/4.5,),
            SizedBox(height: sizeH35,),
            Text('Verify mail'.tr,style: TextStyle(fontSize: sizeW25,fontWeight: FontWeight.w600,color: blackolor),textAlign: TextAlign.center,),
            SizedBox(height: sizeH15,),
            // Wrap(
            //   alignment : WrapAlignment.center,
            //   children: [
            //     Text('Verification code'.tr,style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w600,color: Colors.red),textAlign: TextAlign.center,),
            //     Text(code.tr,style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w600,color: Colors.red),textAlign: TextAlign.center,),
            //   ],
            // ),
            // SizedBox(height: sizeH20,),
            Wrap(
              alignment : WrapAlignment.center,
              children: [
                Text('Code sent to'.tr,style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w300,color: greyOpacityColor),textAlign: TextAlign.center,),
                Text(' 966$email',style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w300,color: greyOpacityColor),textAlign: TextAlign.center,),
              ],
            ),
            SizedBox(height: sizeH30,),
            Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 1.0,
                  horizontal: sizeW50,
                ),
                
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: PinCodeTextField(
                    autoDisposeControllers: false,
                    appContext: context,
                    pastedTextStyle: const TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                    
                    length: 4,
                    blinkWhenObscuring: true,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    validator: (v) {
                      if (v!.length < 3) {
                        return "Im from validator".tr;
                      } else {
                        return null;
                      }
                    },
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(sizeW45),
                      fieldHeight: sizeH45,
                      fieldWidth: sizeW45,
                      activeFillColor: grey3,
                      inactiveColor: grey3,
                      activeColor : grey3,
                      selectedColor : grey3,
                      selectedFillColor : grey3,
                      borderWidth: 1,
                      activeBorderWidth: 1,
                      errorBorderColor: Colors.red,
                      errorBorderWidth: 1,
                      disabledBorderWidth: 1,
                      inactiveBorderWidth: 1,
                      selectedBorderWidth: 1,
                    ),
                    cursorColor: Colors.black,
                    
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: false,
                    keyboardType: TextInputType.number,
                    backgroundColor: Colors.transparent,
                    errorAnimationController: errorController,
                    controller: textEditingController,
                    onCompleted: (v) {
                      if(v == code){
                      }else{
                        SnackBar(content:Text("Im from validator".tr));
                      }
                    },
                    onChanged: (value) {
                      if(value == code){
                      }
                    },
                    beforeTextPaste: (text) {
                      if(text == code){
                      }else{
                        SnackBar(content:Text("Im from validator".tr));
                      }
                      return true;
                    },
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 25,),
            MaterialButton(
              elevation: 0,
              color: primaryColor,
              minWidth: Get.width / 1.1,
              height: sizeH50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(sizeW45),
              ),
              onPressed: (){
                if(textEditingController.text == code){
                  PageRouteTransition.effect = TransitionEffect.leftToRight;
                  PageRouteTransition.pushReplacement(context,  type == 'client'?CreateAccView(email:email,type: type,):CreateAccDriverView(email:email,type: type,));
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Im from validator".tr)));
                }
              },
              child: Text(
                'Verify'.tr,
                style:  TextStyle(
                  fontSize: sizeW22,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: sizeH20,),
            

            GestureDetector(
              onTap: (){
                Get.back();
              },
              child:  Center(
                child: Text.rich(
                  TextSpan(
                    children: [
                       TextSpan(
                        text: 'Didn’t recieve code?'.tr,
                        style:  TextStyle(
                          fontSize: sizeW16,
                          color: greyOpacityColor,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      TextSpan(
                        text: 'Request'.tr,
                        style:  TextStyle(
                          fontSize: sizeW16,
                          color: primaryColor,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
