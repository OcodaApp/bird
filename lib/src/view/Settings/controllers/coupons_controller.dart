import 'package:animate_do/animate_do.dart';
import 'package:birdandroid/utility/General.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../constance.dart';
import '../../../../http/request.dart';
import '../../../../http/url.dart';
import '../../../../model/coupons_list.dart';

class CouponsController extends GetxController {
  var couponsData = [].obs;
  void getCoupons() async {
    var data = {'user_id':General.id};
    Request request = Request(url: urlGetCoupns, body: data);
    request.postAuth().then((value) async {
      if (value['status']) {
        CouponsListModel couponsListModel = CouponsListModel.fromJson(value);
        couponsData.value = couponsListModel.coupon!;
      } 
    }).catchError((onError) {
    });
  }

  @override
  void onInit() {
    getCoupons();
    super.onInit();
  }


  List<Widget> createCoupon(context) {
    List<Widget> imageSliders = couponsData.asMap().entries.map((item) {
      return Column(
        children: [
          Container(
            padding:  EdgeInsets.only(bottom: sizeH20),
            decoration:   BoxDecoration(
              border: Border(
                bottom: BorderSide(color: item.key == couponsData.length - 1?whitecolor: grey5),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInDown(child:Image.asset('assets/logo.png',width: sizeW30,height: sizeW30,fit: BoxFit.fill,),),
                SizedBox(width: sizeW15,),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.value.title,
                        style: TextStyle(color: primaryColor,fontSize: sizeW16,fontWeight: FontWeight.w500),),
                      Text(item.value.couponId,style: TextStyle(color: greyOpacityColor,fontSize: sizeW16,fontWeight: FontWeight.w300,height: 1.5),),
                      Text(item.value.status,style: TextStyle(fontSize: sizeW14,fontWeight: FontWeight.w500,color: primaryTowColor),),
                      Text('${'fnishAt'.tr} : ${item.value.fnish}',
                      style: TextStyle(color: greyOpacityColor,fontSize: sizeW14,fontWeight: FontWeight.w300,height: 1.3)),
                      Text('${item.value.desc}',
                      style: TextStyle(color: greyOpacityColor,fontSize: sizeW14,fontWeight: FontWeight.w300,height: 1.3)),
                      GestureDetector(
                        onTap: () {
                          Clipboard.setData( ClipboardData(text: item.value.couponId));
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Copied".tr)));
                        },
                        onLongPress: () {
                          Clipboard.setData( ClipboardData(text: item.value.couponId));
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Copied".tr)));
                        },
                        child: Container(
                          width: sizeW80,
                          margin:  EdgeInsets.only(top: sizeH5),
                          padding:  EdgeInsets.only(right: sizeW15,left: sizeW15,bottom: sizeH5,top: sizeH5),
                          decoration: BoxDecoration(
                            color:   primaryTowColor.withOpacity(.1),
                            borderRadius: BorderRadius.circular(sizeW45),
                          ),
                          child: Center(child: Text('copy'.tr,style: TextStyle(fontSize: sizeW14,fontWeight: FontWeight.w500,color: primaryTowColor),)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: sizeH20,),
        ],
      );
    }).toList();
    return imageSliders;
  }
  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
