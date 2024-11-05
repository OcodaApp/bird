import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import '../../../../constance.dart';
import '../../../controller/lang_controller.dart';
import '../controllers/forget_email_controller.dart';

class ForgetEmailView extends StatelessWidget {
  ForgetEmailView({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  // RegExp get _emailRegex => RegExp(r'^\S+@\S+$');
  final ForgetEmailController controller = Get.put(ForgetEmailController());
  final LangController langController = Get.put(LangController());
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
            FadeInUp(child:Image.asset('assets/logo.png',width: Get.width / 2,height: Get.height/4.5,),),
             SizedBox(height: sizeH35,),
             Text('Forget Pass'.tr,style: TextStyle(fontSize: sizeW25,fontWeight: FontWeight.w600,color: blackolor),textAlign: TextAlign.center,),
             SizedBox(height: sizeH35,),
            FadeInUp(
              child: Form(
                key: _formKey,
                child: TextFormField(
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
              ),
            ),
            SizedBox(height: sizeH25,),
            FadeInUp(
              child: MaterialButton(
                elevation: 0,
                color:  primaryColor,
                minWidth: Get.width / 1.1,
                height: sizeH50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(sizeW45),
                ),
                onPressed: (){
                  if (!_formKey.currentState!.validate()) {
                    
                  }else{
                    controller.checkEmail(context);
                  }
                },
                child:  Text(
                  'Verification code'.tr,
                  style:  TextStyle(
                    fontSize: sizeW22,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
             SizedBox(height: sizeH20,),
            

            GestureDetector(
              onTap: (){
                Get.back();
              },
              child: FadeInUp(
                child:  Center(
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
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
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
