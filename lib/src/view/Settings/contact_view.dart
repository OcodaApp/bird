// ignore_for_file: must_be_immutable

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constance.dart';
import 'controllers/contacts_controller.dart';

class ContactView extends StatelessWidget {
  final ContactsController controller = Get.put(ContactsController());
  RegExp get _emailRegex => RegExp(r'^\S+@\S+$');
  ContactView({Key? key}) : super(key: key);
  final _formKey2 = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: ()async{
        controller.isBranch.value = false;
        controller.getBranchesList();
        controller.getSettingList();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: Get.width,
          height: Get.height,
          color: Colors.white,
          padding:  EdgeInsets.all(sizeW15),
          child: ListView(
            children: [
              FadeInRight(
                child:  Text('Contact Us'.tr,style: TextStyle(color: primaryColor,fontSize: sizeW20,fontWeight: FontWeight.w600),),
              ),
              SizedBox(height: sizeH20,),
              Image.asset('assets/icons/postcontact.png',height: Get.height /5.5,width: Get.width /3),
              SizedBox(height: sizeH20,),
              Form(
                key: _formKey2,
                child: Column(
                  children: [
                     Row(
                      children: [
                        Text('First Name'.tr,style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w600,color: greyOpacityColor),textAlign: TextAlign.center,),
                      ],
                    ),
                    SizedBox(height: sizeH10,),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType : TextInputType.name,
                      controller: controller.fristName,
                      decoration:  InputDecoration(
                        hintText: 'First Name'.tr,
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
                          color: grey5,
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
                      style:   TextStyle(
                        fontSize: sizeW16,
                        color: blackolor,
                        fontWeight: FontWeight.w300,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'required'.tr;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: sizeH10,),
                    Row(
                      children: [
                        Text('Last Name'.tr,style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w600,color: greyOpacityColor),textAlign: TextAlign.center,),
                      ],
                    ),
                    SizedBox(height: sizeH10,),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType : TextInputType.name,
                      controller: controller.lastname,
                      decoration:   InputDecoration(
                        hintText: 'Last Name'.tr,
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
                          color: grey5,
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
                      style:   TextStyle(
                        fontSize: sizeW16,
                        color: blackolor,
                        fontWeight: FontWeight.w300,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'required'.tr;
                        }
                        return null;
                      },
                    ),
                     SizedBox(height: sizeH10,),
                     Row(
                      children: [
                        Text('Phone'.tr,style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w600,color: greyOpacityColor),textAlign: TextAlign.center,),
                      ],
                    ),
                    SizedBox(height: sizeH10,),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType : TextInputType.phone,
                      controller: controller.phonetext,
                      decoration:   InputDecoration(
                        hintText: 'Phone'.tr,
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
                          color: grey5,
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
                      style:   TextStyle(
                        fontSize: sizeW16,
                        color: blackolor,
                        fontWeight: FontWeight.w300,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'required'.tr;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: sizeH10,),
                    Row(
                      children: [
                        Text('Email'.tr,style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w600,color: greyOpacityColor),textAlign: TextAlign.center,),
                      ],
                    ),
                     SizedBox(height: sizeH10,),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType : TextInputType.name,
                      controller: controller.emailtext,
                      decoration:   InputDecoration(
                        hintText: 'Email'.tr,
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
                          color: grey5,
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
                      style:   TextStyle(
                        fontSize: sizeW16,
                        color: blackolor,
                        fontWeight: FontWeight.w300,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'required'.tr;
                        }
                        if (!_emailRegex.hasMatch(value)) {
                          return 'Email address is not valid'.tr;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: sizeH15,),
                    Row(
                      children: [
                        Text('the message'.tr,style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w600,color: greyOpacityColor),textAlign: TextAlign.center,),
                      ],
                    ),
                    SizedBox(height: sizeH10,),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType : TextInputType.name,
                      maxLines: 6,
                      controller: controller.msg,
                      decoration:   InputDecoration(
                        hintText: 'the message'.tr,
                        contentPadding: EdgeInsets.only(
                          top: sizeH15,
                          bottom: sizeH15,
                          right: sizeW15,
                          left: sizeW15,
                        ),
                        border:   OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(sizeW25)),
                          borderSide: const BorderSide(
                            color: grey3,
                            width: 0.8,
                          ),
                        ),
                        hintStyle:  TextStyle(
                          fontSize: sizeW16,
                          color: grey5,
                          fontWeight: FontWeight.w300,
                        ),
                        enabledBorder:  OutlineInputBorder(
                          borderRadius:  BorderRadius.all(Radius.circular(sizeW25)),
                          borderSide: const BorderSide(
                            color: grey3,
                            width: 0.8,
                          ),
                        ),
                        focusedBorder:   OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(sizeW25)),
                          borderSide: const BorderSide(
                            color: grey3,
                            width: 1,
                          ),
                        ),
                      ),
                      style:   TextStyle(
                        fontSize: sizeW16,
                        color: blackolor,
                        fontWeight: FontWeight.w300,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'required'.tr;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: sizeH20,),
                    MaterialButton(
                      elevation: 0,
                      color:  primaryColor,
                      minWidth: Get.width / 1.1,
                      height: sizeH50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(sizeW45),
                      ),
                      onPressed: (){
                        if (!_formKey2.currentState!.validate()) {
                        }else{
                          controller.postContacts(context);
                        }
                      },
                      child:   Text(
                        'send'.tr,
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
              SizedBox(height: sizeH20,),
              Text('Get in touch'.tr,style: TextStyle(color: primaryColor,fontSize: sizeW20,fontWeight: FontWeight.w600),),
              SizedBox(height: sizeH20,),
              Container(
                width: Get.width / 1,
                padding: EdgeInsets.only(right: sizeW25,left: sizeW25,top: sizeH15,bottom: sizeH15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(sizeW45),
                  color:  Colors.white,
                  border: Border.all(color:  const Color(0xFFE6E6E6))
                ),
                child: Row(
                  children: [
                    Image.asset('assets/icons/call.png',height: sizeW25,width: sizeW25,fit: BoxFit.fill,),
                    SizedBox(width: sizeW25,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Phone'.tr,
                          style:  TextStyle(
                            fontSize: sizeW16,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: sizeH5,),
                        Obx(() => Text(
                          controller.phone.value,
                          style:  TextStyle(
                            fontSize: sizeW16,
                            color: greyOpacityColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: sizeH15,),
              Container(
                width: Get.width / 1,
                padding:   EdgeInsets.only(right: sizeW25,left: sizeW25,top: sizeH15,bottom: sizeH15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(sizeW45),
                  color:  Colors.white,
                  border: Border.all(color:  const Color(0xFFE6E6E6))
                ),
                child: Row(
                  children: [
                    Image.asset('assets/icons/sms.png',height: sizeW25,width: sizeW25,fit: BoxFit.fill,),
                     SizedBox(width: sizeW25,),
                     Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email'.tr,
                          style:  TextStyle(
                            fontSize: sizeW16,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: sizeH5,),
                        Obx(() => Text(
                          controller.email.value,
                          style:  TextStyle(
                            fontSize: sizeW16,
                            color: greyOpacityColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: sizeH15,),
              Obx(() => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: controller.branchesData.isNotEmpty? controller.createSliders():[
                  Container()
                ],
              ),),
              
              
              Obx(() => controller.isBranch.value? controller.getMap():Container(height: Get.height /3.5,)),
              SizedBox(height: sizeH45,),
              
            ],
          ),
        ),
      ),
    );
  }
}
