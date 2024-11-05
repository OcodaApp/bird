// ignore_for_file: must_be_immutable

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../constance.dart';
import '../user/controllers/edit_profile_controller.dart';
class EditProfileView extends StatelessWidget {
  EditProfileView({Key? key}) : super(key: key);
  final _formKey2 = GlobalKey<FormState>();
  final EditProfileController controller = Get.put(EditProfileController());
  RegExp get _emailRegex => RegExp(r'^\S+@\S+$');
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
            FadeInRight(
              child:  Text('Edit Profile'.tr,style: TextStyle(color: primaryColor,fontSize: sizeW20,fontWeight: FontWeight.w600),),
            ),
            SizedBox(height: sizeH20,),
            Text('Profile picture'.tr,style: TextStyle(color: primaryColor,fontSize: sizeW20,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
            SizedBox(height: sizeH10,),
            GestureDetector(
              onTap: () {
                controller.checkPermission();
                final action = CupertinoActionSheet(
                  title: Text(
                    'change photo'.tr,
                    style:  TextStyle(
                      fontSize: sizeW15,
                      color: blackolor,
                    ),
                  ),
                  actions: <Widget>[
                    CupertinoActionSheetAction(
                      child: Text(
                        'camera'.tr,
                        style:  TextStyle(
                          fontSize: sizeW15,
                          color: primaryColor,
                        ),
                      ),
                      onPressed: () {
                        controller
                              .getImage(ImageSource.camera);
                          Navigator.pop(context);
                      },
                    ),
                    CupertinoActionSheetAction(
                      child: Text(
                        'gallary'.tr,
                        style:  TextStyle(
                          fontSize: sizeW15,
                          color: primaryColor,
                        ),
                      ),
                      onPressed: () {
                        controller
                              .getImage(ImageSource.gallery);
                          Navigator.pop(context);
                      },
                    )
                  ],
                );
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) => action,
                );
              },
              child: Center(
                child: Stack(
                  children: [
                    Obx(() => !controller.isImage.value? CircleAvatar(
                      maxRadius: sizeW65,
                      minRadius: sizeW65,
                      backgroundImage: const AssetImage('assets/profile/person3.png'),
                    ):CircleAvatar(
                      maxRadius: sizeW65,
                      minRadius: sizeW65,
                      backgroundImage: NetworkImage(controller.imageUrl.value),
                    ),),
                    
                    CircleAvatar(
                      maxRadius: sizeW65,
                      minRadius: sizeW65,
                      backgroundColor: Colors.black.withOpacity(.4),
                      child: Center(
                        child: Image.asset('assets/profile/edit-2.png',width: sizeW25,height: sizeW25,fit: BoxFit.fill,),
                      ),
                    ),
                    
                  ],
                ),
              ),
            ),
            SizedBox(height: sizeH20,),
            Text('Profile info'.tr,style: TextStyle(color: primaryColor,fontSize: sizeW20,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
            SizedBox(height: sizeH30,),
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
                      hintText: 'Enter Your First Name'.tr,
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
                        return 'Please enter First Name'.tr;
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
                    controller: controller.phone,
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
                    controller: controller.email,
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
                      Text('Password'.tr,style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w600,color: greyOpacityColor),textAlign: TextAlign.center,),
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
                        if(value!.length > 1){
                          if (value.length < 4) {
                            return 'Enter a stronger password'.tr;
                          }
                        }
                        return null;
                      },
                    ),),
                  // SizedBox(height: sizeH15,),
                  // Row(
                  //   children: [
                  //     Text('Gender'.tr,style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w600,color: greyOpacityColor),textAlign: TextAlign.center,),
                  //   ],
                  // ),
                  // SizedBox(height: sizeH10,),
                  // Container(
                  //   width: Get.width / 1,
                  //   padding:  EdgeInsets.only(right: sizeW20,left: sizeW20,top: sizeH15,bottom: sizeH15),
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(sizeW45),
                  //     color:  Colors.white,
                  //     border: Border.all(color:  grey3)
                  //   ),
                  //   child: DropdownButton<String>(
                  //     hint : Text('Gender'.tr,style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w300,color: greyOpacityColor),textAlign: TextAlign.center,),
                  //     underline : Container(),
                  //     icon:Image.asset('assets/arwo.png',height: sizeW5,width: sizeW10,fit: BoxFit.fill,color: grey3,),
                  //     isDense : true,
                  //     isExpanded: true,
                  //     items: <String>['Male'.tr, 'Famele'.tr].map((String value) {
                  //       return DropdownMenuItem<String>(
                  //         value: value,
                  //         child: Text(value),
                  //       );
                  //     }).toList(),
                  //     onChanged: (_) {},
                  //   ),
                  // ),
                  
                  
                  SizedBox(height: sizeH20,),
                  MaterialButton(
                    elevation: 0,
                    color: primaryColor,
                    minWidth: Get.width / 1.1,
                    height: sizeH50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(sizeW45),
                    ),
                    onPressed: (){
                      if (!_formKey2.currentState!.validate()) {
                      }else{
                        controller.editUserData();
                      }
                    },
                    child:  Text(
                      'Edit'.tr,
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
          ],
        ),
      ),
    );
  }
}
