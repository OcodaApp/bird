// ignore_for_file: file_names, non_constant_identifier_names

// import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Cart {
  static String store_id = "";
  static String product_id = "";
  static String price = "";
  static String count = "";
  static String total = "";
  static String product_name = "";
  static String product_desc = "";
  static String type = "";
  static String image = "";
  static String sale = "";
  static List items = [];

  setitems(List<dynamic> data) async {
    List<String> thisData = data.map((e) => json.encode(e)).toList();
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setStringList("items", thisData);
  }

  getitems() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    items = pref.getStringList("items") ??[];
    return items;
  }


  getStoreId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    store_id = pref.getString("store_id") ?? "";
    return store_id;
  }

  void setStoreId(String id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("store_id", id);
    Cart.store_id = pref.getString("store_id")?? '';
  }

  getProductId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    product_id = pref.getString("product_id") ?? "";
    return product_id;
  }

  void setProductId(String data) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("product_id", data);
    Cart.product_id = pref.getString("product_id")?? '';
  }

  getPrice() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    price = pref.getString("price") ?? "";
    return price;
  }

  getCount() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    count = pref.getString("count") ?? "";
    return count;
  }

  gettotal() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    total = pref.getString("total") ?? "";
    return total;
  }

  getProductName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    product_name = pref.getString("product_name") ?? "";
    return product_name;
  }

  getProductDesc() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    product_desc = pref.getString("product_desc") ?? "";
    return product_desc;
  }

  gettype() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    type = pref.getString("type") ?? "";
    return type;
  }

  getimage() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    image = pref.getString("image") ?? "";
    return image;
  }

  getsale() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    sale = pref.getString("sale") ?? "";
    return sale;
  }


  void setCartItem(var data) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("store_id", data['store_id'].toString());
    pref.setString("product_id", data['product_id'].toString());
    pref.setString("price", data['price'].toString());
    pref.setString("count", data['count'].toString());
    pref.setString("total", data['total'].toString());
    pref.setString("product_name", data['product_name'].toString());
    pref.setString("product_desc", data['product_desc'].toString());
    pref.setString("image", data['image'].toString());
    pref.setString("sale", data['sale'].toString());
    pref.setString("type", data['type'].toString());
    Cart.store_id = pref.getString("store_id")!;
    Cart.product_id = pref.getString("product_id")!;
    Cart.price = pref.getString("price")!;
    Cart.count = pref.getString("count")!;
    Cart.total = pref.getString("total")!;
    Cart.product_name = pref.getString("product_name")!;
    Cart.product_desc = pref.getString("product_desc")!;
    Cart.image = pref.getString("image")!;
    Cart.sale = pref.getString("sale")!;
    Cart.type = pref.getString("type")!;
  }
   
  getCartData() async {
    getStoreId();
    getProductId();
    getProductDesc();
    getProductName();
    getCount();
    getPrice();
    gettotal();
    gettype();
    getsale();
    getimage();
  }
}
