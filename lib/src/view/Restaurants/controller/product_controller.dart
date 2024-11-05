import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constance.dart';
import '../../../../http/request.dart';
import '../../../../http/url.dart';
import '../../../controller/cart_count_controller.dart';

class ProductController extends GetxController {
  
  var count = 1.obs;
  var cart = false.obs;
  var countPrice = 0.0.obs;
  var chooseReqId = 0.obs;
  var chooseReqPrice = 0.obs;
  var chooseReqTotal = 0.obs;

  var chooseOptId = 0.obs;
  var chooseOptPrice = 0.obs;
  var chooseOptTotal = 0.obs;

  addBasket(data) async {
    Request request = Request(url: urlAddBasket, body: data);
    request.postAuth().then((value) async {
      if (value['status']) {
        final CartCountController controller = Get.put(CartCountController());
        controller.cartCoynt.value = value['count'];
        Get.back();
      } 
    }).catchError((onError) {
      // print(onError);
    });
  }

  checkBasketStore(store,dataBasket) async {
    var data = {'store_id':store};
    Request request = Request(url: urlCheckBasketStore, body: data);
    request.postAuth().then((value) async {
      if (value['status']) {
        addBasket(dataBasket);
      }else{
        Get.dialog(
          Scaffold(
            backgroundColor: greycolor.withOpacity(0.1),
            body: Center(
              child: Container(
                height: Get.height / 3,
                margin: EdgeInsets.all(sizeW20),
                padding: EdgeInsets.all(sizeW20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(sizeW15),
                  color: whitecolor
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('You have products in your cart from elsewhere'.tr,style: TextStyle(color: primaryColor,fontSize: sizeW16,fontWeight: FontWeight.w700),),
                    SizedBox(height: sizeH30,),
                    SizedBox(
                      width: Get.width / 1.5,
                      child: Text('Are you sure you want to delete all basket items?'.tr,
                        style: TextStyle(color: const Color(0xFF797C7E),fontSize: sizeW16,fontWeight: FontWeight.w400)
                        ,textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: sizeH20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MaterialButton(
                          elevation: 0,
                          color: primaryColor,
                          minWidth: Get.width / 2.7,
                          height: sizeH40,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(sizeW15),
                          ),
                          onPressed: (){
                            deleteAllBasket(dataBasket);
                          },
                          child: Text(
                            'Delete'.tr,
                            style:  TextStyle(
                              fontSize: sizeW16,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        MaterialButton(
                          elevation: 0,
                          color: whitecolor,
                          minWidth: Get.width / 2.7,
                          height: sizeH40,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(sizeW15),
                            side: const BorderSide(color: primaryColor)
                          ),
                          onPressed: (){
                            Get.back();
                          },
                          child: Text(
                            'cancel'.tr,
                            style:  TextStyle(
                              fontSize: sizeW16,
                              color: primaryColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          barrierDismissible: false,
        );
      }
    }).catchError((onError) {
    });
  }

  deleteAllBasket(dataBasket) async {
    Request request = Request(url: urlDeleteBasketStore, body: null);
    request.getAuth().then((value) async {
      if (value['status']) {
        Get.back();
        addBasket(dataBasket);
      } 
    }).catchError((onError) {
    });
  }

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
