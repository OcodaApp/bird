// ignore_for_file: file_names, non_constant_identifier_names

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Address {
  static String a_id = "";
  static String a_name = "";
  static String a_text = "";
  static String a_street = "";
  static String a_building = "";
  static String a_floor = "";
  static String a_flat = "";
  static String a_lat = "";
  static String a_long = "";
  static String a_city = "";

  getAddresId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    a_id = pref.getString("a_id") ?? "";
    return a_id;
  }

  void setAddresId(String id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("a_id", id);
    Address.a_id = pref.getString("a_id")?? '';
  }

  getAddrescity() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    a_city = pref.getString("a_city") ?? "";
    return a_city;
  }

  void setAddresCity(String data) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("a_city", data);
    Address.a_city = pref.getString("a_city")?? '';
  }

  getAddreslong() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    a_long = pref.getString("a_long") ?? "";
    return a_long;
  }

  getAddreslat() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    a_lat = pref.getString("a_lat") ?? "";
    return a_lat;
  }

  getAddresflat() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    a_flat = pref.getString("a_flat") ?? "";
    return a_flat;
  }

  getAddresfloor() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    a_floor = pref.getString("a_floor") ?? "";
    return a_floor;
  }

  getAddresbuilding() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    a_building = pref.getString("a_building") ?? "";
    return a_building;
  }

  getAddresname() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    a_name = pref.getString("a_name") ?? "";
    return a_name;
  }

  getAddrestext() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    a_text = pref.getString("a_text") ?? "";
    return a_text;
  }

  getAddresstreet() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    a_street = pref.getString("a_street") ?? "";
    return a_street;
  }


  void setAddressData(var data) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("a_id", data['id'].toString());
    pref.setString("a_name", data['location_name'].toString());
    pref.setString("a_text", data['addres_text'].toString());
    pref.setString("a_street", data['street'].toString());
    pref.setString("a_building", data['building'].toString());
    pref.setString("a_floor", data['floor'].toString());
    pref.setString("a_flat", data['flat'].toString());
    pref.setString("a_lat", data['latitude'].toString());
    pref.setString("a_long", data['longitude'].toString());
    pref.setString("a_city", data['city'].toString());
    Address.a_id = pref.getString("a_id")!;
    Address.a_name = pref.getString("a_name")!;
    Address.a_text = pref.getString("a_text")!;
    Address.a_street = pref.getString("a_street")!;
    Address.a_building = pref.getString("a_building")!;
    Address.a_floor = pref.getString("a_floor")!;
    Address.a_flat = pref.getString("a_flat")!;
    Address.a_lat = pref.getString("a_lat")!;
    Address.a_long = pref.getString("a_long")!;
    Address.a_city = pref.getString("a_city")!;
  }
   
  getAddressData() async {
    getAddresId();
    getAddresname();
    getAddrestext();
    getAddresstreet();
    getAddresbuilding();
    getAddresflat();
    getAddresfloor();
    getAddreslat();
    getAddreslong();
    getAddrescity();
  }
}
