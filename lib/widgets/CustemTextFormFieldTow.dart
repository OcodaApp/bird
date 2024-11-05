// ignore_for_file: file_names, prefer_typing_uninitialized_variables, void_checks

import 'package:flutter/material.dart';
import '../../constance.dart';

// ignore: must_be_immutable
class CustomTextFormFieldThree extends StatelessWidget {
  final String hint, lable, initialValue;
  // final Function validator, ontap, onChange;
  final Function(String)  onChange;
  // String Function(String) validator;
  final String? Function(String?)? validator;
  final VoidCallback ontap;
  final inputController;
  final TextInputType type;
  final double fontSize;
  final FontWeight fontWeight;
  final bool obscureText;
  var autofillHints;
  final Color fillColor, iconColor;
  final IconData icon;
  final double prefixMarginRight, prefixMarginLeft, iconSize, iconOpacity;
  final double contentPaddingTop,
      contentPaddingBottom,
      contentPaddingRight,
      contentPaddingLeft;
  final bool suffixIcon;
  final bool suffixIconMap;

  CustomTextFormFieldThree({Key? key, 
    this.initialValue = '',
    this.lable = '',
    this.hint = '',
    required this.validator,
    this.inputController,
    required this.type,
    required this.fontSize,
    required this.fontWeight,
    this.obscureText = false,
    this.autofillHints,
    // ignore: avoid_init_to_null
    required this.ontap,
    this.fillColor = whitecolor,
    required this.icon,
    this.prefixMarginRight = 0,
    this.prefixMarginLeft = 0,
    this.iconColor = greycolor,
    this.iconSize = 10,
    this.iconOpacity = 0.5,
    this.contentPaddingTop = 0,
    this.contentPaddingBottom = 0,
    this.contentPaddingLeft = 0,
    this.contentPaddingRight = 0,
    this.suffixIcon = false,
    this.suffixIconMap = false,
    // ignore: avoid_init_to_null
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: TextEditingController()..text = initialValue,
      onTap: ontap,
      onChanged: (ss){
        return onChange(ss);
      },
      keyboardType: type,
      obscureText: obscureText,
      decoration: InputDecoration(
        suffixIcon: suffixIcon
            ? const Icon(Icons.edit)
            : suffixIconMap
                ? Image.asset(
                  'assets/icons/pin.png',
                  width: 10,
                  height: 5,
                )
                : Container(
                    width: 0,
                  ),
        prefix: Container(
          margin:
              EdgeInsets.only(right: prefixMarginRight, left: prefixMarginLeft),
          child: Icon(
            icon,
            color: iconColor.withOpacity(iconOpacity),
            size: iconSize,
          ),
        ),
        labelText: lable,
        fillColor: fillColor,
        contentPadding: EdgeInsets.only(
          top: contentPaddingTop,
          bottom: contentPaddingBottom,
          right: contentPaddingRight,
          left: contentPaddingLeft,
        ),
        hintText: hint,
        filled: true,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: primaryColor,
            width: 1,
          ),
        ),
        hintStyle:  TextStyle(
          fontSize: fontSize,
          color: greycolor,
          fontWeight: fontWeight,
          fontFamily: 'URW-DIN',
        ),
        labelStyle:  TextStyle(
          fontSize: sizeW12,
          color: greycolor,
          fontWeight: FontWeight.bold,
          fontFamily: 'URW-DIN',
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: iconColor.withOpacity(iconOpacity),
            width: 0.5,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: primaryColor,
            width: 1,
          ),
        ),
      ),
      style:  TextStyle(
        fontSize: fontSize,
        color: blackolor,
        fontWeight: fontWeight,
        fontFamily: '',
      ),
      // validator: (aa){
      //   return validator();
      // },
      validator: validator,
    );
  }
}
