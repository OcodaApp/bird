import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constance.dart';
import '../../../../http/request.dart';
import '../../../../http/url.dart';
import '../../../../model/Previous_orders_model.dart';
import '../../../../model/notifications_list_modal.dart';

class NotificationsController extends SuperController {
  var orderssData = [].obs;
  var pordersData = [].obs;
  void getNotifications() async {
    Request request = Request(url: urlMyNotifications, body: null);
    request.postAuth().then((value) async {
      if (value['status']) {
        NotificationsListModel ordersListModel = NotificationsListModel.fromJson(value);
        orderssData.value = ordersListModel.data!;

        PreviousOrderssListModel pordersListModel = PreviousOrderssListModel.fromJson(value);
        pordersData.value = pordersListModel.data!;
      } 
    }).catchError((onError) {
    });
  }

  @override
  void onInit() {
    getNotifications();
    super.onInit();
  }

  List<Widget> createNotfys() {
    List<Widget> imageSliders = orderssData.asMap().entries.map((item) {
      return item.value.orderStatus.length > 0? Column(
        children: [
          Container(
            width: Get.width / 1,
            padding: EdgeInsets.all(sizeW15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(sizeW15),
              color:  Colors.white,
              border: Border.all(color: primaryColor)
            ),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: Get.width /3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${'Order ID'.tr} ${item.value.code}',style: TextStyle(color: primaryColor,fontSize: sizeW14,fontWeight: FontWeight.w600),),
                      Text(item.value.storeName != 'null'&& item.value.storeName != ''? item.value.storeName:'Deliver Package'.tr,
                              style: TextStyle(color: primaryColor,fontSize: sizeW14,fontWeight: FontWeight.w600,height: 1.3),),
                      Text(item.value.date,style: TextStyle(color: primaryColor,fontSize: sizeW12,fontWeight: FontWeight.w400,height: 1.3),),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: sizeW10,left: sizeH5,top: sizeH15),
                  child: item.value.orderStatus.length > 1 ?Column(
                    children: [
                      SizedBox(
                        width: sizeW15,
                        child: ListView.builder(
                          itemCount: item.value.orderStatus.length -1,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return SizedBox(
                              width: sizeW15,
                              height: index == 2 ? Get.height / 8:Get.height / 9.5,
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    maxRadius: sizeW5,
                                    minRadius: sizeW5,
                                    backgroundColor: primaryColor,
                                  ),
                                  SizedBox(height: sizeH2,),
                                  Container(
                                    width: 1.5,
                                    height: index == 2 ? Get.height / 11.5:Get.height / 12,
                                    color: primaryColor,
                                  ),
                                  index == 2 ?Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(sizeW45),
                                      color:  primaryColor.withOpacity(.2),
                                    ),
                                    child: CircleAvatar(
                                      maxRadius: sizeW5,
                                      minRadius: sizeW5,
                                      backgroundColor: primaryColor,
                                    ),
                                  ):Container(),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ):Container(),
                ),

                Expanded(
                  child: SizedBox(
                    width: Get.width /2.5,
                    child: ListView.builder(
                      itemCount: item.value.orderStatus.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            SizedBox(
                              width: Get.width /2.5,
                              child: Row(
                                children: [
                                  FadeInDown(child:Image.network(item.value.orderStatus[index]['image_url'],width: sizeW45,height: sizeW45,fit: BoxFit.fill,),),
                                  SizedBox(width: sizeW5,),
                                  SizedBox(
                                    width: Get.width /3.9,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(item.value.orderStatus[index]['status_name'],style: TextStyle(color: greyOpacityColor,fontSize: sizeW16,fontWeight: FontWeight.w600),),
                                        SizedBox(height: sizeH2,),
                                        Text(item.value.orderStatus[index]['time_text'],style: TextStyle(color: greyOpacityColor,fontSize: sizeW14,fontWeight: FontWeight.w300),),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: sizeH25,),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: sizeH20,),
        ],
      ):Container();
    }).toList();
    return imageSliders;
  }

  List<Widget> createPreviews() {
    List<Widget> imageSliders = pordersData.map((item) {
      return Column(
        children: [
          Container(
            padding: EdgeInsets.all(sizeW20),
            margin: EdgeInsets.only(right: sizeW5,left: sizeH5),
            decoration:  BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(sizeW15),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: const Color.fromARGB(31, 153, 152, 152).withOpacity(0.2),
                  offset: const Offset(0, 0),
                  blurRadius: 10.0,
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                   width: Get.width /3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${'Order ID'.tr} ${item.code}',style: TextStyle(color: primaryColor,fontSize: sizeW14,fontWeight: FontWeight.w600),),
                      Text(item.storeName != 'null'&& item.storeName != ''? item.storeName:'Deliver Package'.tr,
                                style: TextStyle(color: primaryColor,fontSize: sizeW14,fontWeight: FontWeight.w600,height: 1.5),),
                      Text(item.date,style: TextStyle(color: primaryColor,fontSize: sizeW12,fontWeight: FontWeight.w400,height: 1.5),),
                    ],
                  ),
                ),
                
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      item.active == 1?
                      FadeInDown(child:Image.asset('assets/icons/Frame 1259.png',width: sizeW45,height: sizeW45,fit: BoxFit.fill,),):
                      FadeInDown(child:Image.asset('assets/icons/Asset124 1-8 1.png',width: sizeW45,height: sizeW45,fit: BoxFit.fill,),),
                      SizedBox(width: sizeW10,),
                      Text(item.statusName,style: TextStyle(color: primaryColor,fontSize: sizeW14,fontWeight: FontWeight.w600),),
                    ],
                  ),
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

  

  @override
  void onDetached() {
    // getNotifications();
  }

  @override
  void onInactive() {
    // getNotifications();
  }

  @override
  void onPaused() {
    // getNotifications();
  }

  @override
  void onResumed() {
    // getNotifications();
  }

  @override
  void onClose() {
    // getNotifications();
    super.onClose();
  }

  @override
  void onHidden() {
    // TODO: implement onHidden
  }
}
