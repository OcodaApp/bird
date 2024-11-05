// ignore_for_file: must_be_immutable, unnecessary_null_comparison

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../../../constance.dart';
import '../../../utility/General.dart';
import '../../controller/images_controller.dart';
import '../../controller/lang_controller.dart';
import 'controllers/package_controller.dart';

class PackageView extends StatelessWidget {
  PackageView({Key? key}) : super(key: key);
  final _formKey2 = GlobalKey<FormState>();
  
  final PackageController controller = Get.put(PackageController());
  final ImagesController imagescontroller = Get.put(ImagesController());
  final LangController langcontroller = Get.put(LangController());
  @override
  Widget build(BuildContext context) {
    final pageIndexNotifier = ValueNotifier(0);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Get.height / 4),
        child: FadeInDown(
          child: SizedBox(
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                          image: AssetImage('assets/store/delevry.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: sizeH100,
                    margin: EdgeInsets.only(top: sizeH5,right: sizeW10,left: sizeW10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Get.back();
                          },
                          child: Container(
                            width: sizeW25,
                            height: sizeW25,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(sizeW25),
                            ),
                            child: Padding(
                              padding:  EdgeInsets.only(right: langcontroller.appLocale == 'ar'? sizeW5:0,left: langcontroller.appLocale == 'en'? sizeW5:0),
                              child: Center(child: Icon(Icons.arrow_back_ios,color: greyOpacityColor,size: sizeW15,)),
                            ),
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: FadeInUp(
        child: Obx(() => controller.isPackageText.value && controller.isFromId.value && controller.isToId.value ?  GestureDetector(
          onTap: (){
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Container(
            width: Get.width / 1.5,
            height: Get.height / 4.2,
            padding:  EdgeInsets.all(sizeW20),
            decoration:  BoxDecoration(
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color:  const Color.fromARGB(31, 153, 152, 152).withOpacity(0.1),
                  offset:  const Offset(15.0, 2.0),
                  blurRadius: 22.0,
                )
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Service fees'.tr,style: TextStyle(fontSize: sizeW22,fontWeight: FontWeight.w400,color: greyOpacityColor)),
                    Text('${controller.total.value.toString()} ${'SAR'.tr}',style: TextStyle(fontSize: sizeW22,fontWeight: FontWeight.w600,color: greyOpacityColor)),
                  ],
                ),
                SizedBox(height: sizeH5,),
                Text('This fare is based on the distance'.tr,style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w400,color: greyOpacityColor)),
                SizedBox(height: sizeH20,),
                
                GestureDetector(
                  onTap: (){
                    FocusManager.instance.primaryFocus?.unfocus();
                    FocusScope.of(context).unfocus();
                    if(controller.paymethod.value == 1){
                      controller.payPressed();
                    }else{
                      controller.postOrder();
                    }
                  },
                  child: Container(
                    width: Get.width / 1,
                    height: sizeH50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(sizeW45),
                      color:  primaryColor,
                    ),
                    child:  Center(
                      child: Text(
                        'Order now'.tr,
                        style:  TextStyle(
                          fontSize: sizeW22,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
            
          ),
        ):Container(height: 0,),)
      ),
      body: Container(
        width: Get.width,
        height: Get.height,
        padding:  EdgeInsets.all(sizeW10),
        child: ListView(
          children:  [
             SizedBox(height: sizeH5,),
            Text('Deliver Package'.tr,style: TextStyle(fontSize: sizeW18,fontWeight: FontWeight.w600,color: primaryColor)),
            SizedBox(height: sizeH15,),
            Form(
              key: _formKey2,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('Your package'.tr,style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w600,color: greyOpacityColor),textAlign: TextAlign.center,),
                    ],
                  ),
                  SizedBox(height: sizeH10,),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType : TextInputType.name,
                    controller: controller.packageText,
                    maxLines: 2,
                    minLines: 2,
                    onChanged: (value){
                      if (value != null || value.isNotEmpty) {
                        controller.isPackageText.value = true;
                        if(controller.isToId.value && controller.isFromId.value){
                          controller.calculateDistance(double.parse(controller.fromlat.value),double.parse(controller.fromlong.value),
                          double.parse(controller.tolat.value),double.parse(controller.tolong.value));
                        }
                      }
                    },
                    decoration:  InputDecoration(
                      hintText: 'Your package'.tr,
                      contentPadding: EdgeInsets.only(
                        top: sizeH15,
                        bottom: sizeH15,
                        right: sizeW15,
                        left: sizeW15,
                      ),
                      border:  OutlineInputBorder(
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
                      enabledBorder: OutlineInputBorder(
                        borderRadius:  BorderRadius.all(Radius.circular(sizeW25)),
                        borderSide: const BorderSide(
                          color: grey3,
                          width: 0.8,
                        ),
                      ),
                      focusedBorder:  OutlineInputBorder(
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
                   SizedBox(height: sizeH10,),
                   Row(
                    children: [
                      Text('Pick up adress'.tr,style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w600,color: greyOpacityColor),textAlign: TextAlign.center,),
                    ],
                  ),
                  SizedBox(height: sizeH10,),
                  GestureDetector(
                    onTap: (){
                      FocusManager.instance.primaryFocus?.unfocus();
                      WoltModalSheet.show<void>(
                        pageIndexNotifier: pageIndexNotifier,
                        context: context,
                        pageListBuilder: (modalSheetContext) {
                          return [
                            controller.page3(modalSheetContext),
                          ];
                        },
                        modalTypeBuilder: (context) {
                          return WoltModalType.bottomSheet();
                        },
                        onModalDismissedWithBarrierTap: () {
                          debugPrint('Closed modal sheet with barrier tap');
                          Navigator.of(context).pop();
                          pageIndexNotifier.value = 0;
                        },
                        // minPageHeight: 0.0,
                        // maxPageHeight: Get.height /2,
                      );
                    },
                    child: Container(
                      height: sizeH40,
                      width: Get.width,
                      padding: EdgeInsets.only(right: sizeW15,left: sizeW15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(sizeW25),
                        border: Border.all(color: grey3,width: 0.8)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(() => SizedBox(
                            width: Get.width / 1.5,
                            child: Text(
                              controller.fromstreet.value != ''? controller.fromstreet.value:'Pick up adress'.tr,
                              style:TextStyle(
                                fontSize: sizeW16,
                                color: controller.fromstreet.value != ''?blackolor :grey5,
                                fontWeight: FontWeight.w300,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),),
                          Image.asset('assets/gps.png',color:  grey4,)
                        ],
                      ),
                    )
                  ),
                  
                  SizedBox(height: sizeH10,),
                  Row(
                    children: [
                      Text('Delivering adress'.tr,style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w600,color: greyOpacityColor),textAlign: TextAlign.center,),
                    ],
                  ),
                  SizedBox(height: sizeH10,),
                  GestureDetector(
                    onTap: (){
                      FocusManager.instance.primaryFocus?.unfocus();
                      WoltModalSheet.show<void>(
                        pageIndexNotifier: pageIndexNotifier,
                        context: context,
                        pageListBuilder: (modalSheetContext) {
                          return [
                            controller.page4(modalSheetContext),
                          ];
                        },
                        modalTypeBuilder: (context) {
                          return WoltModalType.bottomSheet();
                        },
                        onModalDismissedWithBarrierTap: () {
                          debugPrint('Closed modal sheet with barrier tap');
                          Navigator.of(context).pop();
                          pageIndexNotifier.value = 0;
                        },
                        // minPageHeight: 0.0,
                        // maxPageHeight: Get.height /2,
                      );
                    },
                    child: Container(
                      height: sizeH40,
                      width: Get.width,
                      padding: EdgeInsets.only(right: sizeW15,left: sizeW15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(sizeW25),
                        border: Border.all(color: grey3,width: 0.8)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          
                          Obx(() => SizedBox(
                            width: Get.width / 1.5,
                            child: Text(
                              controller.tostreet.value != ''? controller.tostreet.value:'Delivering adress'.tr,
                              style:TextStyle(
                                fontSize: sizeW16,
                                color: controller.tostreet.value != ''?blackolor :grey5,
                                fontWeight: FontWeight.w300,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),),
                          Image.asset('assets/gps.png',color:  grey4,)
                        ],
                      ),
                    )
                  ),
                  
                  SizedBox(height: sizeH10,),
                  Row(
                    children: [
                      Text('Add pictures (Optional)'.tr,style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w600,color: greyOpacityColor),textAlign: TextAlign.center,),
                    ],
                  ),
                  SizedBox(height: sizeH10,),
                  GestureDetector(
                    onTap: (){
                      imagescontroller.checkPermission();
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
                              imagescontroller
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
                              imagescontroller
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
                    child: Container(
                      height: sizeH40,
                      width: Get.width,
                      padding: EdgeInsets.only(right: sizeW15,left: sizeW15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(sizeW25),
                        border: Border.all(color: grey3,width: 0.8)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Upload photos'.tr,
                            style:TextStyle(
                              fontSize: sizeW16,
                              color: grey5,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Image.asset('assets/icons/gallery.png',color:  grey4,)
                        ],
                      ),
                    )
                  ),
                ],
              ),
            ),
            SizedBox(height: sizeH15,),

            Obx(() => imagescontroller.imagesUrl.isNotEmpty? SizedBox(
              height: sizeH70,
              child: ListView.builder(
                itemCount: imagescontroller.imagesUrl.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: [
                      Image.network('${imagescontroller.imagesUrl[index]}',height: sizeH70,width: sizeW100,fit: BoxFit.fill,),
                      SizedBox(width: sizeW10,),
                    ],
                  );
                },
              ),
            ):Container(),),
            Obx(() => SizedBox(height: imagescontroller.imagesUrl.isNotEmpty?sizeH15 : 0,),),
            Row(
              children: [
                Text('Add notes'.tr,style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w600,color: greyOpacityColor),textAlign: TextAlign.center,),
              ],
            ),
            SizedBox(height: sizeH10,),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType : TextInputType.name,
              controller: controller.notes,
              maxLines: 3,
              decoration:   InputDecoration(
                hintText: 'Add notes'.tr,
                contentPadding: EdgeInsets.only(
                  top: sizeH15,
                  bottom: sizeH15,
                  right: sizeW15,
                  left: sizeW15,
                ),
                border:  OutlineInputBorder(
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
                enabledBorder: OutlineInputBorder(
                  borderRadius:  BorderRadius.all(Radius.circular(sizeW25)),
                  borderSide: const BorderSide(
                    color: grey3,
                    width: 0.8,
                  ),
                ),
                focusedBorder:  OutlineInputBorder(
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
                // if (value == null || value.isEmpty) {
                //   return 'Please enter Delivering adress';
                // }
                return null;
              },
            ),
            SizedBox(height: sizeH15,),
            Obx(() => controller.isPackageText.value && controller.isFromId.value && controller.isToId.value ? Row(
              children: [
                Text('Get a discount'.tr,style: TextStyle(fontSize: sizeW18,fontWeight: FontWeight.w600,color: primaryColor),),
              ],
            ):Container(),),
            Obx(() => SizedBox(height: controller.isPackageText.value && controller.isFromId.value && controller.isToId.value ? sizeH10:0,),),
            Obx(() => controller.isPackageText.value && controller.isFromId.value && controller.isToId.value ? TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType : TextInputType.name,
              onChanged: (value){
                controller.couponText.value = value;
              },
              controller: controller.coupon,
              decoration:  InputDecoration(
                hintText: 'Enter code'.tr,
                contentPadding:  EdgeInsets.only(
                  top: 0,
                  bottom: 0,
                  right: sizeW15,
                  left: sizeW15,
                ),
                border:   OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(sizeW45)),
                  borderSide: const BorderSide(
                    color: grey3,
                    width: 0.8,
                  ),
                ),
                suffixIcon:  Obx(() => GestureDetector(
                  onTap: (){
                    FocusManager.instance.primaryFocus?.unfocus();
                    FocusScope.of(context).unfocus();
                    if(controller.couponText.value != ''){
                      controller.checkCoupon(context);
                    }
                  },
                  child: !controller.isCoupon.value?Container(
                    margin:  EdgeInsets.all(sizeW10),
                    padding:  EdgeInsets.only(right: sizeW15,left: sizeW15,bottom: 5,top: 5),
                    decoration: BoxDecoration(
                      color:   primaryColor.withOpacity(.1),
                      borderRadius: BorderRadius.circular(sizeW45),
                    ),
                    child:  Text('send'.tr,style: TextStyle(fontSize: sizeW14,fontWeight: FontWeight.w400,color: primaryColor),),
                  ):SizedBox(
                    width: Get.width / 2.5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: Get.width / 3.5,
                          margin:  EdgeInsets.all(sizeW5),
                          padding:  EdgeInsets.only(right: sizeW15,left: sizeW15,bottom: sizeH5,top: sizeH5),
                          decoration: BoxDecoration(
                            color:   primaryTowColor.withOpacity(.2),
                            borderRadius: BorderRadius.circular(sizeW45),
                          ),
                          child:  Row(
                            children: [
                              Container(
                                width: sizeW20,
                                height: sizeW20,
                                decoration: BoxDecoration(
                                  color:   primaryTowColor,
                                  borderRadius: BorderRadius.circular(sizeW45),
                                ),
                                child: Center(
                                  child: Icon(Icons.add_task_outlined,size: sizeW12,color: whitecolor,),
                                ),
                              ),
                              SizedBox(width: sizeW5,),
                              Text('Applied'.tr,style: TextStyle(fontSize: sizeW14,fontWeight: FontWeight.w400,color: primaryColor),),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            controller.coupon.clear();
                            controller.couponText.value = '';
                            controller.salePrice.value = 0.0;
                            controller.sale.value = 0;
                            controller.couponId.value = '0';
                            controller.isCoupon.value = false;
                            if(controller.isToId.value && controller.isFromId.value){
                              controller.calculateDistance(double.parse(controller.fromlat.value),double.parse(controller.fromlong.value),
                              double.parse(controller.tolat.value),double.parse(controller.tolong.value));
                            }
                          },
                          child: Container(
                            width: sizeW20,
                            height: sizeW20,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(sizeW45),
                            ),
                            child: Center(
                              child: Icon(Icons.close_outlined,size: sizeW12,color: whitecolor,),
                            ),
                          ),
                        ),
                        SizedBox(width: sizeW10,)
                      ],
                    ),
                  ),
                ),),
                prefixIcon: Image.asset('assets/icons/ticket-discount.png',color:  grey4,),
                hintStyle:   TextStyle(
                  fontSize: sizeW16,
                  color: grey5,
                  fontWeight: FontWeight.w300,
                ),
                enabledBorder:  OutlineInputBorder(
                  borderRadius:  BorderRadius.all(Radius.circular(sizeW45)),
                  borderSide: const BorderSide(
                    color: grey3,
                    width: 0.8,
                  ),
                ),
                focusedBorder:   OutlineInputBorder(
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
                // if (value == null || value.isEmpty) {
                //   return 'Please enter Delivering adress';
                // }
                return null;
              },
            ):Container(),),
            SizedBox(height: sizeH15,),

            Text('Payment method'.tr,style: TextStyle(color: primaryColor,fontSize: sizeW20,fontWeight: FontWeight.w600),),
            SizedBox(height: sizeH15,),
            GestureDetector(
              onTap: (){
                controller.paymethod.value = 1;
              },
              child: Container(
                width: Get.width / 1,
                padding:  EdgeInsets.only(right: sizeW20,left: sizeW20,top: sizeH5,bottom: sizeH5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(sizeW45),
                  color:  Colors.white,
                  border: Border.all(color:  grey3,width: 1)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        FadeInDown(child:Image.asset('assets/icons/card.png',width: sizeW25,height: sizeW25,fit: BoxFit.fill,color:  greyOpacityColor),),
                         SizedBox(width: sizeW10,),
                         Text(
                          'Different Credit/Debit Card'.tr,
                          style:  TextStyle(
                            fontSize: sizeW14,
                            color: greyOpacityColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Obx(() => SizedBox(
                      width: sizeW20,
                      child: Radio(
                        value: controller.paymethod.value,
                        groupValue: 1,
                        activeColor:  primaryColor,
                        onChanged: (value) {
                        },
                      ),
                    ),)
                  ],
                ),
              ),
            ),
            SizedBox(height: sizeH15,),
            GestureDetector(
              onTap: (){
                controller.paymethod.value = 2;
              },
              child: Container(
                width: Get.width / 1,
                padding:  EdgeInsets.only(right: sizeW20,left: sizeW20,top: sizeH5,bottom: sizeH5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(sizeW45),
                  color:  Colors.white,
                  border: Border.all(color:  grey3,width: 1)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        FadeInDown(child:Image.asset('assets/icons/moneys.png',width: sizeW25,height: sizeW25,fit: BoxFit.fill,color:  greyOpacityColor),),
                         SizedBox(width: sizeW10,),
                         Text(
                          'cash payment'.tr,
                          style:  TextStyle(
                            fontSize: sizeW14,
                            color: greyOpacityColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Obx(() => SizedBox(
                      width: sizeW20,
                      child: Radio(
                        value: controller.paymethod.value,
                        groupValue: 2,
                        activeColor:  primaryColor,
                        onChanged: (value) {
                        },
                      ),
                    ),),
                  ],
                ),
              ),
            ),
            SizedBox(height: General.walletCount > double.parse(controller.total.value) ?sizeH15:0,),
            General.walletCount > double.parse(controller.total.value)? GestureDetector(
              onTap: (){
                controller.paymethod.value = 3;
              },
              child: Container(
                width: Get.width / 1,
                padding:  EdgeInsets.only(right: sizeW20,left: sizeW20,top: sizeH5,bottom: sizeH5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(sizeW45),
                  color:  Colors.white,
                  border: Border.all(color:  grey3,width: 1)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        FadeInDown(child:Image.asset('assets/icons/moneys.png',width: sizeW25,height: sizeW25,fit: BoxFit.fill,color:  greyOpacityColor),),
                         SizedBox(width: sizeW10,),
                         Text(
                          'wallet'.tr,
                          style:  TextStyle(
                            fontSize: sizeW14,
                            color: greyOpacityColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Obx(() => SizedBox(
                      width: sizeW20,
                      child: Radio(
                        value: controller.paymethod.value,
                        groupValue: 3,
                        activeColor:  primaryColor,
                        onChanged: (value) {
                        },
                      ),
                    ),),
                  ],
                ),
              ),
            ):Container(),
            SizedBox(height: sizeH30,)
            
          ],
        ),
      ),
    );
  }

  
}
