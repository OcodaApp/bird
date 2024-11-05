
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import '../../constance.dart';
import '../src/controller/lang_controller.dart';

class CustomMaterialButton extends StatelessWidget {
  final String? text, image;
  final Color colorText, colorButton;
  final VoidCallback onPressed;
  final double fontSize, height, minWidth, borderRadius;
  final FontWeight fontWeight;
  final bool isImage;
  

  CustomMaterialButton({Key? key, 
    this.text = '',
    required this.colorText,
    required this.colorButton,
    required this.onPressed,
    required this.fontSize,
    required this.height,
    required this.minWidth,
    required this.borderRadius,
    required this.fontWeight,
     this.image,
    this.isImage = false,
  }) : super(key: key);

  final LangController langController = Get.put(LangController());

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      color: colorButton,
      height: height,
      minWidth: minWidth,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          
          Text(
            text!,
            style:  TextStyle(
              fontSize: fontSize,
              color: colorText,
              fontWeight: fontWeight,
            ),
          ),
          isImage  ?  SizedBox(width: sizeW5) : Container(),
          langController.appLocale == 'ar' && isImage
              ? Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(math.pi),
                  child:  Image.asset(
                  image!,
                  width:sizeW15,
                  height:sizeW15,
                  fit: BoxFit.fill,
                ),
                )
              :  const SizedBox(width: 0,height: 0,),
          isImage && langController.appLocale != 'ar'
              ? Image.asset(
                  image!,
                  width:sizeW15,
                  height:sizeW15,
                  fit: BoxFit.fill,
                )
              : Container(),
          
        ],
      ),
    );
  }
}
