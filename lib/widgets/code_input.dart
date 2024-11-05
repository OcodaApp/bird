
// ignore_for_file: prefer_typing_uninitialized_variables, void_checks

import 'package:flutter/material.dart';
import '../../constance.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class CustomCodeFormField extends StatelessWidget {
  final String? text;
  final String? hint;
  final Function validator, ontap, onChange;
  final inputController;
  final TextInputType? type;
  final double? fontSize;
  final FontWeight? fontWeight;
  final bool? obscureText;
  var autofillHints;
  bool readOnly = false;

  CustomCodeFormField({Key? key, 
    this.text = '',
    this.hint,
    required this.validator,
    this.inputController,
    this.type,
    this.fontSize,
    this.fontWeight,
    this.obscureText = false,
    this.autofillHints,
    // ignore: avoid_init_to_null
    required this.ontap ,
    this.readOnly = false,
    // ignore: avoid_init_to_null
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  EdgeInsets.only(right: sizeW10, left: sizeW10),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        maxLength: 10,
        readOnly: readOnly,
        // onTap: ontap(),
        // onChanged: onChange(),
        onTap: () {
          return ontap();
        },
        onChanged: (value) {
          return onChange(value);
        },
        controller: inputController,
        keyboardType: type,
        obscureText: obscureText!,
        textDirection: TextDirection.ltr,
        inputFormatters: [ FilteringTextInputFormatter.allow(RegExp('[0-9.,]+')),],
        decoration: InputDecoration(
          counterText: '',
          icon: SizedBox(
            child: Icon(
              Icons.phone_android_outlined,
              color: greycolor.withOpacity(0.5),
              size: sizeW12,
            ),
          ),
          isDense: true,
          contentPadding: const EdgeInsets.only(top: 0, bottom: 0, right: 0, left: 0),
          hintText: hint,
          border:  const UnderlineInputBorder(
            borderSide:  BorderSide(
              color: primaryColor,
              width: 0.0,
            ),
          ),
          hintStyle:  TextStyle(
            fontSize: sizeW12,
            color: greycolor,
            fontWeight: fontWeight,
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: whitecolor,
              width: 0.0,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: whitecolor,
              width: 0,
            ),
          ),
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: whitecolor,
              width: 0,
            ),
          ),
          disabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: whitecolor,
              width: 0,
            ),
          ),
          focusedErrorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: whitecolor,
              width: 0,
            ),
          ),
        ),
        style:  TextStyle(
          fontSize: fontSize,
          color: blackolor,
          fontWeight: fontWeight,
        ),
        // validator: validator(),
        validator: (value) {
          return validator(value);
        },
      ),
    );
  }
}
