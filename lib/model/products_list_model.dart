// ignore_for_file: prefer_typing_uninitialized_variables

class ProductsListModel {
  List<Product>? data;
  ProductsListModel({
    this.data,
  });

  ProductsListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Product>[];
      json['data'].forEach((v) {
        data?.add( Product.fromJson(v));
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

class Product {
  int? id,typeId,sale,storeId;
  String? name,type,image,desc;
  double? oldPrice,price;
  var reqs,opts;

  Product({this.id,this.typeId, this.name, this.type, this.image, this.reqs, this.opts,this.storeId});

  Product.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    typeId = int.parse(json['type_id'].toString());
    sale = int.parse(json['sale'].toString());
    storeId = int.parse(json['store_id'].toString());
    // string
    name = json['name'].toString();
    desc = json['desc'].toString();
    type = json['type'].toString();
    image = json['image_url'].toString();
    // doblue
    oldPrice = double.parse(json['old_price'].toString());
    price = double.parse(json['price'].toString());

    // vars
    reqs = json['chosses_req'];
    opts = json['chosses_opt'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['typeId'] = typeId;
    data['sale'] = sale;

    data['name'] = name;
    data['desc'] = desc;
    data['type'] = type;
    data['image'] = image;
    
    data['oldPrice'] = oldPrice;
    data['price'] = price;
    data['storeId'] = storeId;


    

    return data;
  }
}
