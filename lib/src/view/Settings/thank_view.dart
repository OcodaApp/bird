// ignore_for_file: must_be_immutable

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constance.dart';
import '../home_view.dart';

class ThankView extends StatelessWidget {
  const ThankView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
          builder: (context) => const HomeView()), (Route route) => false);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        
        body: Container(
          width: Get.width,
          height: Get.height,
          color: Colors.white,
          padding:EdgeInsets.all(sizeW15),
          child: FadeInRight(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/icons/thank.png'),
                SizedBox(height: sizeH20,),
                Text('Thank You!'.tr,style: TextStyle(color: primaryColor,fontSize: sizeW30,fontWeight: FontWeight.w900),),
                SizedBox(height: sizeH25,),
                Text('successfully submitted'.tr,style: TextStyle(color: primaryColor,fontSize: sizeW25,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
                SizedBox(height: sizeH50,),
                MaterialButton(
                  elevation: 0,
                  color: primaryColor,
                  minWidth: Get.width / 1.1,
                  height: sizeH50,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(sizeW45),
                  ),
                  onPressed: (){
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                        builder: (context) => const HomeView()), (Route route) => false);
                  },
                  child:  Text(
                    'Go to Homepage'.tr,
                    style:  TextStyle(
                      fontSize: sizeW22,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
