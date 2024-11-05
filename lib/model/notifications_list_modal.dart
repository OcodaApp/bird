// ignore_for_file: prefer_typing_uninitialized_variables

class NotificationsListModel {
  List<Order>? data;
  NotificationsListModel({
    this.data,
  });

  NotificationsListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Order>[];
      json['data'].forEach((v) {
        data?.add( Order.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};

    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Order {
  int? id,sale,storeId,addressId,delegateId,itemsCount,active,fromAddressId,toAddressId,servicePrice,rateAvg,rateCount;
  String? type,payMethod,pay,status,orderDate,note,package,code,statusName,username,storeName,date,method,storeLogo,time;
  double? itemsTotal,deliveryTotal,saleTotal,total,latitude,longitude,fromLatitude,fromLongitude,toLatitude,toLongitude;
  var store,user,address,fromAddress,toAddress,items,delegate,orderStatus;

  Order({
    this.id,
    this.sale,this.storeId,this.addressId,this.delegateId,
    this.itemsCount,this.active,this.fromAddressId,this.toAddressId,
    this.servicePrice,this.rateAvg,this.rateCount,

    this.type,this.payMethod,this.pay,this.status,this.orderDate,this.note,
    this.package,this.code,this.statusName,this.username,
    this.storeName,this.date,this.method,this.storeLogo,this.time,

    this.itemsTotal,this.deliveryTotal,this.saleTotal,this.total,
    this.latitude,this.longitude,this.fromLatitude,this.fromLongitude,
    this.toLatitude,this.toLongitude,
    this.store,this.user,this.address,this.fromAddress,this.toAddress,this.items,this.delegate,this.orderStatus
  });

  

  Order.fromJson(Map<String, dynamic> json) {

    id= json['id'];sale= json['sale'];storeId= json['store_id'];addressId= json['address_id'];delegateId= json['delegate_id'];
    itemsCount= json['items_count'];active= json['active'];fromAddressId= json['from_address_id'];toAddressId= json['to_address_id'];
    servicePrice= json['service_price'];rateAvg= json['rate_avg'];rateCount= json['rate_count'];

    
    type=json['type'].toString();
    payMethod=json['pay_method'].toString();
    pay=json['pay'].toString();
    status=json['status'].toString();
    orderDate=json['order_date'].toString();
    note=json['note'].toString();
    package=json['package'].toString();
    code=json['code'].toString();
    statusName=json['status_name'].toString();
    username=json['username'].toString();
    
    storeName=json['store_name'].toString();
    storeLogo=json['store_logo'].toString();
    date=json['date'].toString();
    method=json['method'].toString();
    time=json['time'].toString();

    itemsTotal= json['items_total'] != null ? double.parse(json['items_total'].toString()):0.0;
    deliveryTotal= json['delivery_total'] != null ? double.parse(json['delivery_total'].toString()):0.0;
    saleTotal= json['sale_total'] != null ? double.parse(json['sale_total'].toString()):0.0;
    total= json['total'] != null ? double.parse(json['total'].toString()):0.0;
    latitude= json['latitude'] != null ? double.parse(json['latitude'].toString()):0.0;
    longitude= json['longitude'] != null ? double.parse(json['longitude'].toString()):0.0;
    fromLatitude= json['from_latitude'] != null ? double.parse(json['from_latitude'].toString()):0.0;
    fromLongitude= json['from_longitude'] != null ? double.parse(json['from_longitude'].toString()):0.0;
    toLatitude= json['to_latitude'] != null ? double.parse(json['to_latitude'].toString()):0.0;
    toLongitude= json['to_longitude'] != null ? double.parse(json['to_longitude'].toString()):0.0;
  
    store= json['store'];
    user= json['user'];
    address= json['address'];
    fromAddress= json['from_address'];
    toAddress= json['to_address'];
    items= json['items'];
    delegate=json['delegate'];
    orderStatus=json['order_status'];
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sale'] = sale;
    data['storeId'] = storeId;
    data['addressId'] = addressId;
    data['delegateId'] = delegateId;
    data['itemsCount'] = itemsCount;
    data['active'] = active;
    data['fromAddressId'] = fromAddressId;
    data['toAddressId'] = toAddressId ;
    data['servicePrice'] = servicePrice ;
    data['rateAvg'] = rateAvg ;
    data['rateCount'] = rateCount ;

     data['type'] = type ;
     data['payMethod'] = payMethod ;
     data['pay'] = pay ;
     data['status'] = status ;
     data['orderDate'] = orderDate ;
     data['note'] = note ;
     data['storeLogo'] = storeLogo ;
     data['package'] = package ;
     data['code'] = code ;
     data['statusName'] = statusName ;
     data['username'] = username ;
     data['time'] = time ;
     

     data['storeName'] = storeName ;
     data['date'] = date ;
     data['method'] = method ;


     data['itemsTotal'] = itemsTotal ;
     data['deliveryTotal'] = deliveryTotal ;
     data['saleTotal'] = saleTotal ;
     data['total'] = total ;

     data['latitude'] = latitude ;
     data['longitude'] = longitude ;
     data['fromLatitude'] = fromLatitude ;
     data['fromLongitude'] = fromLongitude ;

     data['toLatitude'] = toLatitude ;
     data['toLongitude'] = toLongitude ;

     data['store'] = store ;
     data['user'] = user ;
     data['address'] = address ;
     data['fromAddress'] = fromAddress ;
     data['toAddress'] = toAddress ;
     data['items'] = items ;
     data['delegate'] = delegate ;
     data['orderStatus'] = orderStatus ;

     

    return data;
  }
}
