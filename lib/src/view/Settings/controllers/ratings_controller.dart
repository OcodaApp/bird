import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import '../../../../constance.dart';
import '../../../../http/request.dart';
import '../../../../http/url.dart';
import '../../../../model/orders_list_model.dart';

class RatingsController extends GetxController {
  var orderssData = [].obs;
  void getRatingsOrders() async {
    Request request = Request(url: urlMyRatings, body: null);
    request.postAuth().then((value) async {
      if (value['status']) {
        OrderssListModel ordersListModel = OrderssListModel.fromJson(value);
        orderssData.value = ordersListModel.data!;
      } 
    }).catchError((onError) {
    });
  }

  @override
  void onInit() {
    getRatingsOrders();
    super.onInit();
  }

  List<Widget> createOrders() {
    List<Widget> imageSliders = orderssData.asMap().entries.map((item) {
      return Column(
        children: [
          Container(
              padding:  EdgeInsets.all(sizeW20),
              decoration:  BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(sizeW15),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: const Color.fromARGB(31, 153, 152, 152).withOpacity(0.2),
                    offset: const Offset(2.0, 2.0),
                    blurRadius: 20.0,
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     item.value.storeLogo != 'null' && item.value.storeLogo != ''?
                      FadeInDown(child:Image.network(item.value.storeLogo,width: sizeW30,height: sizeW30,fit: BoxFit.fill,),):
                      FadeInDown(child:Image.asset('assets/logo.png',width: sizeW30,height: sizeW30,fit: BoxFit.fill,),),
                      SizedBox(width: sizeW10,),
                      Text(item.value.storeName != 'null'&& item.value.storeName != ''? item.value.storeName:'Deliver Package'.tr,
                            style: TextStyle(color: primaryColor,fontSize: sizeW16,fontWeight: FontWeight.w500),),
                    ],
                  ),
                  SizedBox(height: sizeH5,),
                  Text(item.value.date,style: TextStyle(color: greyOpacityColor,fontSize: sizeW14,fontWeight: FontWeight.w300),),
                  SizedBox(height: sizeH5,),
                  Text('${'Order ID'.tr}: ${item.value.code}',style: TextStyle(color: greyOpacityColor,fontSize: sizeW14,fontWeight: FontWeight.w300),),
                  SizedBox(height: sizeH10,),
                  item.value.note != 'null' && item.value.note != ''?Text(item.value.note,
                  style: TextStyle(color: greyOpacityColor,fontSize: sizeW14,fontWeight: FontWeight.w300),):Container(),
                  SizedBox(height: sizeH20,),
                  SmoothStarRating(
                    allowHalfRating: false,
                    onRatingChanged: (v) {
                    },
                    starCount: 5,
                    rating: double.parse(item.value.rateAvg.toString()),
                    size: sizeW25,
                    filledIconData: Icons.star,
                    halfFilledIconData: Icons.star,
                    color: Colors.orange,
                    borderColor: Colors.orange,
                    spacing:5.0
                  ),
                ],
              ),
            ),
          SizedBox(height: sizeH15,),
        ],
      );
    }).toList();
    return imageSliders;
  }
}
