// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constance.dart';
import '../controllers/forget_change_pass_controller.dart';

class ForgetChangePasswordView extends StatelessWidget {
  String email,userId;
  ForgetChangePasswordView({Key? key,required this.email,required this.userId}) : super(key: key);
  final ForgetChangePassController controller = Get.put(ForgetChangePassController());
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
            Text('change password'.tr,style: TextStyle(fontSize: sizeW25,fontWeight: FontWeight.w600,color: blackolor),textAlign: TextAlign.center,),
            SizedBox(height: sizeH25,),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('New Password'.tr,style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w600,color: greyOpacityColor),textAlign: TextAlign.center,),
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
                  SizedBox(height: sizeH15,),
                  Row(
                    children: [
                      Text('Confirm Password'.tr,style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w600,color: greyOpacityColor),textAlign: TextAlign.center,),
                    ],
                  ),
                  SizedBox(height: sizeH10,),
                  Obx(() => TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType : TextInputType.visiblePassword,
                    obscureText: controller.showCoPass.value ?false:true,
                    controller: controller.copassword,
                    decoration:  InputDecoration(
                      suffixIcon: Padding(
                        padding:  const EdgeInsets.fromLTRB(0, 0, 4, 0),
                        child: GestureDetector(
                          onTap: (){
                            if(controller.showCoPass.value){
                              controller.showCoPass.value = false;
                            }else{
                              controller.showCoPass.value = true;
                            }
                            
                          },
                          child: Icon(
                            Icons.visibility_rounded,
                            size: sizeW25,
                            color: controller.showCoPass.value ? primaryColor :grey4,
                          ),
                        ),),
                      hintText: 'Enter Confirm Password'.tr,
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
                        return 'Enter Confirm Password'.tr;
                      }
                      if (controller.password.text != controller.copassword.text) {
                        return 'Passwords do not match'.tr;
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
              color: const Color(0xFF36388E),
              minWidth: Get.width / 1.1,
              height: sizeH50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(45),
              ),
              onPressed: (){
                if (!_formKey.currentState!.validate()) {
                }else{
                  controller.changePass(email,context,userId);
                }
              },
              child: Text(
                'change password'.tr,
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
                Get.offNamed('/loginView');
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
          ],
        ),
      ),
    );
  }
}
