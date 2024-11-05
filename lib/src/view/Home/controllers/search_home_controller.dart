import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constance.dart';
import '../../../../http/request.dart';
import '../../../../http/url.dart';
import '../../../../model/stores_list_model.dart';
import '../../../../utility/Address.dart';
import '../../../../utility/General.dart';
import '../../Restaurants/restaurant_view.dart';


class SearchHomeController extends GetxController {
  TextEditingController searchTextController = TextEditingController();
  var isStores = false.obs;
  var storesData = [].obs;
  @override
  void onInit() {
    searchTextController = TextEditingController();
    getStoreDataListNoSearch();
    super.onInit();
  }

  void getStoreDataListNoSearch() async {
    var data = {
      'latitude' : Address.a_lat,
      'longitude' : Address.a_long,
      'user_id' : General.id,
      'type' : 'restaurant',
    };

    Request request = Request(url: urlGetStoresType, body: data);
    request.post().then((value) async {
      if (value['status']) {
        StoresListModel storesListModel = StoresListModel.fromJson(value);
        storesData.value = storesListModel.data!;
        isStores.value = true;
      } 
    }).catchError((onError) {
    });
  }

  void getStoreDataList() async {
    isStores.value = false;
    var data = {
      'latitude' : Address.a_lat,
      'longitude' : Address.a_long,
      'user_id' : General.id,
    };
    if(searchTextController.text.isNotEmpty){
      data.addAll({'word':searchTextController.text});
    }

    Request request = Request(url: urlSearchStoreHome, body: data);
    request.post().then((value) async {
      if (value['status']) {
        StoresListModel storesListModel = StoresListModel.fromJson(value);
        storesData.value = storesListModel.data!;
        isStores.value = true;
      } 
    }).catchError((onError) {
    });
  }

  List<Widget> createSliders() {
    List<Widget> imageSliders = storesData.map((item) {
      return Column(
        children: [
          GestureDetector(
            onTap: ()async{
              await Get.to(()=>RestaurantView(storeData: item,),arguments: [item.id,item.userFav]);
              getStoreDataList();
            },
            child: Container(
              height: Get.height  /5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(sizeW25),
                border: Border.all(color:  primaryColor,width: 0.8)
              ),
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: Get.height / 7.9,width: Get.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(sizeW25),
                            topRight: Radius.circular(sizeW25)
                          ),
                          image: DecorationImage(image: NetworkImage(item.cover),fit: BoxFit.cover)
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color:  const Color.fromARGB(255, 133, 133, 160).withOpacity(.1),
                            borderRadius:  BorderRadius.only(
                              bottomLeft : Radius.circular(sizeW25),
                              bottomRight : Radius.circular(sizeW25),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    width: Get.width / 2,
                                    child: Wrap(
                                      crossAxisAlignment : WrapCrossAlignment.end,
                                      alignment : WrapAlignment.end,
                                      children: [
                                        Text(item.name,style: TextStyle(fontSize: sizeW12,fontWeight: FontWeight.w500,color: primaryColor)),
                                      ],
                                    )),
                                  SizedBox(height: sizeH5,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/marker.png',color:  primaryColor,width: sizeW12,height: sizeW12,),
                                      SizedBox(width: sizeW5,),
                                      Text(item.km.toStringAsFixed(2),style: TextStyle(fontSize: sizeW10,fontWeight: FontWeight.w300,color: primaryColor)),
                                      SizedBox(width: sizeW25,),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(width: sizeW5,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    padding:  EdgeInsets.only(right: sizeW5,left: sizeW5,top: sizeH2,bottom: sizeH2),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(sizeW25),
                                      color:  primaryColor,
                                    ),
                                    child: Center(
                                      child: SizedBox(
                                        width: sizeW65,
                                        height: sizeH10,
                                        child: Wrap(
                                          crossAxisAlignment : WrapCrossAlignment.center,
                                          alignment : WrapAlignment.center,
                                          children: [
                                            Image.asset('assets/dd.png',color:Colors.white,width: sizeW10,height: sizeW10,),
                                            SizedBox(width: sizeW5,),
                                            Text(item.delevryPrice,
                                            style: TextStyle(fontSize: sizeW10,fontWeight: FontWeight.w400,color: Colors.white,overflow: TextOverflow.ellipsis)),
                                            SizedBox(width: sizeW5,),
                                            Text('SAR'.tr,style: TextStyle(fontSize: sizeW10,fontWeight: FontWeight.w400,color: Colors.white)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  
                                  SizedBox(height: sizeW5,),
                                  SizedBox(
                                    width: sizeW100,
                                    height: sizeH10,
                                    child: Wrap(
                                      children: [
                                        Image.asset('assets/clock.png',color:  primaryColor,width: sizeW10,height: sizeW10,),
                                        SizedBox(width: sizeW5,),
                                        SizedBox(
                                          height: sizeH10,
                                          child: Text('${item.fromTime} - ${item.toTime}',
                                          style: TextStyle(fontSize: sizeW10,fontWeight: FontWeight.w400,color: primaryColor)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: sizeW20,),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Get.height / 11,),
                      Container(
                        width: sizeW50,
                        height: sizeW50,
                        margin:  EdgeInsets.only(left: sizeW20,right: sizeW20),
                        padding:  EdgeInsets.all(sizeW5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(sizeW45),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.black.withOpacity(.1),
                                blurRadius: 15.0,
                                offset:  const Offset(0.0, 0.75)
                            )
                          ],
                          image: DecorationImage(image: NetworkImage(item.logo,),fit: BoxFit.fill)
                        ),
                      ),
                      Container(
                        margin:  EdgeInsets.only(left: sizeW20,right: sizeW20,top: sizeH5),
                        child:  Row(
                          children: [
                            Icon(Icons.star,color: Colors.orange,size: sizeW12,),
                            SizedBox(width: sizeW5,),
                            Text(item.rateAvg.toString(),style: TextStyle(fontSize: sizeW10,fontWeight: FontWeight.w500,color: primaryColor)),
                            SizedBox(width: sizeW5,),
                            SizedBox(
                              width: sizeW50,
                              child: Text('(${item.rateCount.toString()})',style: TextStyle(fontSize: sizeW10,fontWeight: FontWeight.w300,color: primaryColor,overflow: TextOverflow.ellipsis))),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: sizeH15,),
        ],
      );
    }).toList();
    return imageSliders;
  }

  

  @override
  void onClose() {
    searchTextController.dispose();
    super.onClose();
  }
}
