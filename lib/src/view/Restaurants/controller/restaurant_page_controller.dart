import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../../../../constance.dart';
import '../../../../http/request.dart';
import '../../../../http/url.dart';
import '../../../../model/products_list_model.dart';
import '../../../../model/sales_list_model.dart';
import '../../../../model/types_list_model.dart';
import '../../../../utility/Address.dart';
import '../../../../utility/General.dart';
import '../product_view.dart';

class RestaurantPageController extends GetxController {
  var storeId = 0.obs;
  var isSales= false.obs;
  var isProducts= false.obs;
  var istypes= false.obs;
  var salesData = [].obs;
  var productsData = [].obs;
  var typesData = [].obs;
  List<GlobalKey> keyCap = [];

  calculateDistance(lat1, lon1, lat2, lon2)async{
    var distanceInMeters = Geolocator.distanceBetween(
      lat1,
      lon1,
      lat2,
      lon2,
    );
    // var p = 0.017453292519943295;
    // var c = cos;
    // var a = 0.5 - c((lat2 - lat1) * p)/2 + 
    //       c(lat1 * p) * c(lat2 * p) * 
    //       (1 - c((lon2 - lon1) * p))/2;
    // return 12742 * asin(sqrt(a));
    return distanceInMeters;
  }

  void getStoreDataAndProductsList() async {
    isProducts.value = false;
    isSales.value = false;
    istypes.value = false;
    var data = {
      // 'user_id' : General.id,
      'store_id' : storeId.value,
    };

    Request request = Request(url: urlGetProducts, body: data);
    request.post().then((value) async {
      print("Value data type url $urlGetProducts");
      print(value);
      if (value['status']) {
        TypesListModel typesListModel = TypesListModel.fromJson(value);
        typesData.value = typesListModel.data!;
        if(typesData.isNotEmpty){
          istypes.value = true;
          keyCap = List<GlobalKey>.generate(typesData.length, (index) => GlobalKey(debugLabel: 'key_$index'),growable: false);
        }
        ProductsListModel productsListModel = ProductsListModel.fromJson(value);
        productsData.value = productsListModel.data!;
        isProducts.value = true;

        SalesListModel salesListModel = SalesListModel.fromJson(value);
        salesData.value = salesListModel.data!;
        if(salesData.isNotEmpty){
          isSales.value = true;
        }
      } 
    }).catchError((onError) {
      // print(onError);
    });
  }

  var userFav = 0.obs;

  void addFav() async {
    var data = {
      'store_id' : storeId.value,
    };

    Request request = Request(url: urlAddFav, body: data);
    request.postAuth().then((value) async {
      if (value['status']) {
        if(value['data'] == 1){
          userFav.value = value['data'];
        }else{
          userFav.value = 0;
        }
      } 
    }).catchError((onError) {
    });
  }

  var basketStoreCount = 0.obs;
  var basketStoreTotal = 0.obs;

  void getBasketWithStore() async {
    var data = {
      'store_id' : storeId.value,
      'latitude' : Address.a_lat,
      'longitude' : Address.a_long,
    };
    Request request = Request(url: urlGetBasketWithStore, body: data);
    request.postAuth().then((value) async {
      if (value['status']) {
        basketStoreCount.value = int.parse(value['count'].toString());
        basketStoreTotal.value = int.parse(value['total']);
      } 
    }).catchError((onError) {
      // print(onError);
    });
  }

  @override
  void onInit() {
    storeId.value = Get.arguments[0];
    userFav.value = Get.arguments[1];
    getStoreDataAndProductsList();
    getBasketWithStore();
    super.onInit();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  List<Widget> createSales() {
    List<Widget> imageSliders = salesData.asMap().entries.map((item) {
      return GestureDetector(
        onTap: ()async{
          await Get.to(()=>ProductView(product: item.value,reqs: item.value.reqs,opts: item.value.opts),arguments: [item.value.id]);
          getBasketWithStore();
        },
        child: Container(
          padding: EdgeInsets.only(bottom: sizeH20),
          margin: EdgeInsets.only(bottom: sizeH20),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: item.key == salesData.length - 1? whitecolor: grey3.withOpacity(0.5),width:  1),
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: Get.width / 1.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.value.name,style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w500,color: primaryColor)),
                    SizedBox(height: sizeH5,),
                    Text(item.value.desc,style: TextStyle(fontSize: sizeW12,fontWeight: FontWeight.w300,color: greyOpacityColor)),
                    SizedBox(height: sizeH5,),
                    Text('${item.value.price} ${'SAR'.tr}',style: TextStyle(fontSize: sizeW14,fontWeight: FontWeight.w500,color: primaryColor)),
                  ],
                ),
              ),
              Expanded(
                child: Image.network(item.value.image,fit: BoxFit.fill,),
              )
            ],
          ),
        ),
      );
    }).toList();
    return imageSliders;
  }

  List<Widget> createTypes() {
    List<Widget> imageSliders = typesData.asMap().entries.map((item) {
      return Column(
        key: keyCap[item.key],
        children: [
          Row(
            children: [
              Text(item.value.title.toString(),style: TextStyle(fontSize: sizeW18,fontWeight: FontWeight.w600,color: primaryColor)),
            ],
          ),
          SizedBox(height: sizeH20,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: createProducts(item.value.id),
          ),
        ],
      );
    }).toList();
    return imageSliders;
  }

  

  List<Widget> createProducts(typeId) {
    List<Widget> imageSliders = productsData.asMap().entries.map((item) {
      return item.value.typeId == typeId? GestureDetector(
        onTap: ()async{
          await Get.to(()=>ProductView(product: item.value,reqs: item.value.reqs,opts: item.value.opts,),arguments: [item.value.id]);
          getBasketWithStore();
        },
        child: Container(
          padding: EdgeInsets.only(bottom: sizeH20),
          margin: EdgeInsets.only(bottom: sizeH20),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: item.key == productsData.length - 1? whitecolor: grey3.withOpacity(0.5),width:  1),
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: Get.width / 1.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.value.name,style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w500,color: primaryColor)),
                    SizedBox(height: sizeH5,),
                    Text(item.value.desc,style: TextStyle(fontSize: sizeW12,fontWeight: FontWeight.w300,color: greyOpacityColor)),
                    SizedBox(height: sizeH5,),
                    Text('${item.value.price} ${'SAR'.tr}',style: TextStyle(fontSize: sizeW14,fontWeight: FontWeight.w500,color: primaryColor)),
                  ],
                ),
              ),
              Expanded(
                child: Image.network(item.value.image,fit: BoxFit.fill,),
              )
            ],
          ),
        ),
      ):Container();
    }).toList();
    return imageSliders;
  }
}
