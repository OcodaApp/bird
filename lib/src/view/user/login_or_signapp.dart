import 'package:birdandroid/src/view/user/sign_up_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import 'package:light_modal_bottom_sheet/light_modal_bottom_sheet.dart';
import 'package:page_route_transition/page_route_transition.dart';

import '../../../constance.dart';
import '../home_view.dart';
import 'login_view.dart';

class LoginOrSignUpView extends StatelessWidget {
  final bool skipVisible;
  const LoginOrSignUpView({Key? key, this.skipVisible = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: Get.width,
        height: Get.height,
        color: Colors.white,
        padding: EdgeInsets.all(sizeW35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FadeInUp(child:Image.asset('assets/logo2.png',width: Get.width / 1.7,height: Get.height/3.5,),),
            SizedBox(height: sizeH45,),
            Text('Welcome to'.tr,style: TextStyle(fontSize: sizeW25,fontWeight: FontWeight.w600,color: blackolor),),
            SizedBox(height: sizeH25,),
            FadeInDown(child:Image.asset('assets/bird.png',width: Get.width / 1.8,),),
            SizedBox(height: sizeH35,),
            FadeInUp(
              child: MaterialButton(
                elevation: 0,
                color: primaryColor,
                minWidth: Get.width / 1.1,
                height: sizeH50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(sizeW45),
                ),
                onPressed: (){
                  showMaterialModalBottomSheet(
                    expand: false,
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context) => Container(
                      // height: Get.height / 4,
                      padding: EdgeInsets.all(sizeW25),
                      decoration:  BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(sizeW25),
                          topRight: Radius.circular(sizeW25),
                        ),
                        color:  Colors.white,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: (){
                              Get.back();
                              PageRouteTransition.effect = TransitionEffect.topToBottom;
                              PageRouteTransition.push(context,  SignUpView(type: 'client',));
                            },
                            child: Container(
                              width: Get.width / 1.1,
                              height: sizeH50,
                              // padding: EdgeInsets.symmetric(
                              //   vertical: 12
                              // ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(sizeW45),
                                color:  primaryColor,
                              ),
                              child:  Center(
                                child: Text(
                                  'Sign Up client'.tr,
                                  style:  TextStyle(
                                    fontSize: sizeW22,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: sizeH20,),
                          GestureDetector(
                            onTap: (){
                              Get.back();
                              PageRouteTransition.effect = TransitionEffect.topToBottom;
                              PageRouteTransition.push(context,  SignUpView(type: 'driver',));
                            },
                            child: Container(
                              width: Get.width / 1.1,
                              height: sizeH50,
                              // padding: EdgeInsets.symmetric(
                              //     vertical: 12
                              // ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(sizeW45),
                                color:  Colors.white,
                                border: Border.all(color: primaryColor)
                              ),
                              child:  Center(
                                child: Text(
                                  'Sign Up Delivery'.tr,
                                  style:  TextStyle(
                                    fontSize: sizeW22,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Text(
                  'Sign Up'.tr,
                  style:  TextStyle(
                    fontSize: sizeW22,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(height: sizeH20,),
            FadeInUp(
              child: GestureDetector(
                onTap: (){
                  PageRouteTransition.effect = TransitionEffect.topToBottom;
                  PageRouteTransition.push(context,  LoginView());
                },
                child: Container(
                  width: Get.width / 1.1,
                  height: sizeH50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(sizeW45),
                    color:  Colors.white,
                    border: Border.all(color: primaryColor)
                  ),
                  child:  Center(
                    child: Text(
                      'Login'.tr,
                      style:  TextStyle(
                        fontSize: sizeW22,
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: sizeH20,),
            if(skipVisible)FadeInUp(
              child: GestureDetector(
                onTap: (){
                  PageRouteTransition.effect = TransitionEffect.topToBottom;
                  PageRouteTransition.pushReplacement(context,  HomeView());
                },
                child: Container(
                  width: Get.width / 1.1,
                  height: sizeH50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(sizeW45),
                    color:  Colors.white,
                    border: Border.all(color: primaryColor)
                  ),
                  child:  Center(
                    child: Text(
                      'Skip'.tr,
                      style:  TextStyle(
                        fontSize: sizeW22,
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
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
