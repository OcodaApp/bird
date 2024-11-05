import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constance.dart';
import '../controller/splash_controller.dart';
import 'package:animate_do/animate_do.dart';

class SplashView extends StatelessWidget {
  final SplashController spalshController = Get.put(SplashController());
   SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: Get.width,
        height: Get.height,
        color: Colors.white,
        padding:  EdgeInsets.all(sizeW35),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: sizeH100,),
                FadeInDown(child:Image.asset('assets/bird.png'),),
                SizedBox(height: sizeH50,),
                FadeInUp(child:Image.asset('assets/logo.png'),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
