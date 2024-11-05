// ignore_for_file: prefer_typing_uninitialized_variables

class BasketsListModel {
  List<Basket>? basket;
  BasketsListModel({
    this.basket,
  });

  BasketsListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      basket = <Basket>[];
      json['data'].forEach((v) {
        basket?.add( Basket.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};

    if (basket != null) {
      data['data'] = basket?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Basket {
  int? id,productId,sale,storeId,count,chooseReqId,chooseOptId;
  String? name,type,image,desc;
  double? price,total,allTotal,chooseReqPrice,chooseOptPrice,chooseReqTotal,chooseOptTotal;
  var product;

  Basket({this.id,
  this.product,
  this.productId,
  this.sale,
  this.storeId,
  this.count,
  this.chooseReqId,
  this.chooseOptId,this.name,this.type,this.image,this.desc,this.price,this.total,this.allTotal,this.chooseReqPrice,this.chooseOptPrice,this.chooseReqTotal,this.chooseOptTotal,});

  
  Basket.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    productId = int.parse(json['product_id'].toString());
    sale = int.parse(json['sale'].toString());
    storeId = int.parse(json['store_id'].toString());
    count = int.parse(json['quantity'].toString());
    chooseReqId = json['chosses_req_price'] != null?int.parse(json['chosses_req_id'].toString()):0;
    chooseOptId = json['chosses_req_price'] != null?int.parse(json['chosses_opt_id'].toString()):0;
    // string
    name = json['product_name'].toString();
    desc = json['product_desc'].toString();
    type = json['type'].toString();
    image = json['image'].toString();
    // doblue
    allTotal = double.parse(json['all_total'].toString());
    price = double.parse(json['price'].toString());
    total = double.parse(json['total'].toString());

    chooseReqPrice= json['chosses_req_price'] != null? double.parse(json['chosses_req_price'].toString()):0.0;
    chooseOptPrice= json['chosses_opt_price'] != null ?  double.parse(json['chosses_opt_price'].toString()):0.0;
    chooseReqTotal= json['chosses_req_total'] != null? double.parse(json['chosses_req_total'].toString()):0.0;
    chooseOptTotal= json['chosses_opt_total'] != null? double.parse(json['chosses_opt_total'].toString()):0.0;

    // // vars
    product = [json['product']];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['productId'] = productId;
    data['sale'] = sale;
    data['storeId'] = storeId;
    data['count'] = count;
    data['chooseReqId'] = chooseReqId;
    data['chooseOptId'] = chooseOptId;
    data['name'] = name;
    data['desc'] = desc;
    data['type'] = type;
    data['image'] = image;
    data['allTotal'] = allTotal;
    data['price'] = price;
    data['total'] = total;
    data['chooseReqPrice'] = chooseReqPrice;
    data['chooseOptPrice'] = chooseOptPrice;
    data['chooseReqTotal'] = chooseReqTotal;
    data['chooseOptTotal'] = chooseOptTotal;
    data['product'] = product;
    return data;
  }
}
