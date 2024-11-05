import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constance.dart';
import '../../controller/lang_controller.dart';
import 'controllers/login_controller.dart';
import 'forget/forget_email.dart';
import 'login_or_signapp.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final LoginController controller = Get.put(LoginController());
  final LangController langController = Get.put(LangController());
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
            Text('Login'.tr,style: TextStyle(fontSize: sizeW25,fontWeight: FontWeight.w600,color: blackolor),textAlign: TextAlign.center,),
            SizedBox(height: sizeH25,),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('Email'.tr,style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w600,color: greyOpacityColor),textAlign: TextAlign.center,),
                    ],
                  ),
                  SizedBox(height: sizeH10,),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType : TextInputType.phone,
                    textDirection: TextDirection.ltr,
                    controller: controller.email,
                    maxLength: 9,
                    decoration:  InputDecoration(
                      hintText: 'Phone'.tr,
                      counterText: "",
                      suffixIconConstraints:  BoxConstraints(
                        minWidth: langController.appLocale == 'ar' ? 2:sizeW15,
                        minHeight: langController.appLocale == 'ar' ? 2:0,
                      ),
                      suffixIcon: langController.appLocale == 'ar' ?Padding(
                        padding:  EdgeInsets.only(right: sizeW10,left: sizeW10),
                        child: Text('+966',style: TextStyle(color: blackolor,fontSize: sizeW16),textDirection: TextDirection.ltr,),
                      ):Container(width: 0,),
                      prefixIconConstraints:  BoxConstraints(
                        minWidth: langController.appLocale == 'en' ? 2:sizeW15,
                        minHeight: langController.appLocale == 'en' ? 2:0,
                      ),
                      prefixIcon: langController.appLocale == 'en' ?Padding(
                        padding:  EdgeInsets.only(right: sizeW10,left: sizeW10),
                        child: Text('+966',style: TextStyle(color: blackolor,fontSize: sizeW16),textDirection: TextDirection.ltr,),
                      ):Container(width: 0,),
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
                          width: 1,
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
                          width: 1,
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
                    style: TextStyle(
                      fontSize: sizeW16,
                      color: blackolor,
                      fontWeight: FontWeight.w300,
                    ),
                    validator: (value) {
                      if (!GetUtils.isPhoneNumber(value!)) {
                        return 'Phone number is wrong'.tr;
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
                  const SizedBox(height: 10,),
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
            SizedBox(height: sizeH25,),
            MaterialButton(
              elevation: 0,
              color: primaryColor,
              minWidth: Get.width / 1.1,
              height: sizeH50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(sizeW45),
              ),
              onPressed: (){
                if (!_formKey.currentState!.validate()) {
                }else{
                  controller.login();
                }
                
              },
              child: Text(
                'Login'.tr,
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
                Get.to(()=> ForgetEmailView());
              },
              child: Text('Forget your password?'.tr,style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w700,color: primaryColor),textAlign: TextAlign.center,)),
            SizedBox(height: sizeH25,),
            GestureDetector(
              onTap: (){
                Get.to(()=> const LoginOrSignUpView());
              },
              child: Center(
                child: Text.rich(
                  TextSpan(
                    children: [
                       TextSpan(
                        text: 'Don’t have an account? '.tr,
                        style:  TextStyle(
                          fontSize: sizeW16,
                          color: greyOpacityColor,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      TextSpan(
                        text: 'Sign Up'.tr,
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
          ],
        ),
      ),
    );
  }
}
