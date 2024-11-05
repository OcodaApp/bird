// ignore_for_file: file_names

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class General {
  static String token = "";
  static String id = "";
  //new
  static String type = "";
  static String sex = "";
  static String sexName = "";
  static String carType = "";
  static String carColor = "";
  static String carNum = "";
  static String addressDefalt = "";
  static double rate = 0.0;

  //
  static String ipuser = "";
  static String username = "";
  static String fullname = "";
  static String mobile = "";
  static String address = "";
  static String imgurl = "";
  static String image = "";
  static String email = "";
  static String birth = "";
  static String notficationsCount = "";
  static String ordersCount = "";
  static String loginType = "";
  static double walletCount = 0.0;
  static String cartCount = '0';
  static bool isIntro = false;
  static bool isOrder = false;
  static double latitude=21.389082;
  static double longitude=39.857910;

  void setlatitude(double latitude) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setDouble("latitude", latitude);
    General.latitude = pref.getDouble("latitude")?? 21.389082;
  }

  void setlongitude(double longitude) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setDouble("longitude", longitude);
    General.longitude = pref.getDouble("longitude")?? 39.857910;
  }

  getlatitude() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    latitude = pref.getDouble("latitude")?? 21.389082;
    return latitude;
  }

  getlongitude() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    longitude = pref.getDouble("longitude")?? 39.857910;
    return longitude;
  }


  void setIntro() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("intro", true);
  }

  getIntro() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    isIntro = pref.getBool("intro") ?? false;
    return isIntro;
  }

  void setOrder(isorder) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("isOrder", isorder);
    General.isOrder = pref.getBool("isOrder")!;
  }

  getOrder() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    isOrder = pref.getBool("isOrder") ?? false;
    return isOrder;
  }

  void setTokenData(String token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("token", token.toString());
    General.token = pref.getString("token")!;
  }

  void setnotficationsCount(String count) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("notficationsCount", count);
    General.notficationsCount = pref.getString("notficationsCount")!;
  }

  void setloginType(String count) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("loginType", count);
    General.loginType = pref.getString("loginType")!;
  }

  void setwalletCount(double count) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setDouble("walletCount", count);
    General.walletCount = pref.getDouble("walletCount")!;
  }

  void setCartCount(double count) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setDouble("cartCount", count);
    General.cartCount = pref.getString("cartCount")!;
  }

  void setUserPhone(String phone) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("mobile", phone.toString());
    General.mobile = pref.getString("mobile")!;
  }

  void setUserEmail(String email) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("email", email.toString());
    General.email = pref.getString("email")!;
  }

  void setUserName(String username) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("username", username.toString());
    General.username = pref.getString("username")!;
  }

  void setipData(String ip) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("ipuser", ip.toString());
    General.ipuser = pref.getString("ipuser")!;
  }

   getIpData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    ipuser = pref.getString("ipuser") ?? "";
    return ipuser;
  }

   getUserName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    username = pref.getString("username") ?? "";
    return username;
  }

  void setfullname(String fullname) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("fullname", fullname.toString());
    General.fullname = pref.getString("fullname")!;
  }

   getfullname() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    fullname = pref.getString("fullname") ?? "";
    return fullname;
  }

  void setaddress(String address) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("address", address.toString());
    General.address = pref.getString("address")!;
  }

   getaddress() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    address = pref.getString("address") ?? "";
    return address;
  }

  void setimgurl(String image) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("image", image.toString());
    General.imgurl = pref.getString("image")!;
  }

   getUserToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    token = pref.getString("token") ?? "";
    return token;
  }

  void setUserData(var data) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("id", data['id'].toString());
    pref.setString("mobile", data['phone'].toString());
    pref.setString("type", data['type'].toString());
    pref.setString("sex", data['sex'].toString());
    pref.setString("sexName", data['sex_name'].toString());
    pref.setString("birth", data['birth'].toString());
    pref.setString("addressDefalt", data['address_default'].toString());
    pref.setString("username", data['name'].toString());
    pref.setString("email", data['email'].toString());
    pref.setString("image", data['img'].toString());
    pref.setString("imageUrl", data['image_url'].toString());
    pref.setString("ordersCount", data['orders_notfy'].toString());
    pref.setString("cartCount", data['basket_count'].toString());
    General.ordersCount = pref.getString("ordersCount")!;
    pref.setString("notficationsCount", data['count_notfy'].toString());
    General.notficationsCount = pref.getString("notficationsCount")!;
    General.cartCount = pref.getString("cartCount")!;
    General.id = pref.getString("id")!;
    General.mobile = pref.getString("mobile")!;
    General.username = pref.getString("username")!;
    General.imgurl = pref.getString("imageUrl")!;
    General.image = pref.getString("image")!;
    General.email = pref.getString("email")!;
    General.walletCount = pref.getDouble("walletCount")??0.0;
    General.type = pref.getString("type")!;
    General.sex = pref.getString("sex")!;
    General.sexName = pref.getString("sexName")!;
    General.addressDefalt = pref.getString("addressDefalt")!;
  }

   getUserId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    id = pref.getString("id") ?? "";
    return id;
  }

   getUserEmail() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    email = pref.getString("email") ?? "";
    return email;
  }

   getUserPhone() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    mobile = pref.getString("mobile") ?? "";
    return mobile;
  }

   getUserImage() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    image = pref.getString("image") ?? "";
    return image;
  }

   getUserImageUrl() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    imgurl = pref.getString("imageUrl") ?? "";
    return imgurl;
  }

   getNotficationsCount() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    notficationsCount = pref.getString("notficationsCount") ?? "";
    return notficationsCount;
  }

  getCartCount() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    cartCount = pref.getString("cartCount") ?? "0";
    return cartCount;
  }

   getLoginType() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    loginType = pref.getString("loginType") ?? "";
    return loginType;
  }

   getWalletCount() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    walletCount = pref.getDouble("walletCount") ?? 0.0;
    return walletCount;
  }

   getUserData() async {
    getOrder();
    getIpData();
    getUserToken();
    getLoginType();
    getIntro();
    getNotficationsCount();
    getCartCount();
    getWalletCount();
    getUserImage();
    getUserImageUrl();
    getUserPhone();
    getUserEmail();
    getUserName();
    getaddress();
    getfullname();
    getUserId();
    getlatitude();
    getlongitude();
  }

   logOut() async {
    await FirebaseAuth.instance.signOut();
    SharedPreferences pref = await SharedPreferences.getInstance();
    // pref.clear();
    pref.setString("token", "");
    pref.setString("id", "");
    pref.setString("type", "");
    pref.setString("sex", "");
    pref.setString("sexName", "");
    pref.setString("username", "");
    pref.setString("email", "");
    pref.setString("image", "");
    pref.setString("imageUrl", "");
    pref.setString("notficationsCount", "");
    pref.setString("address", "");
    pref.setString("carType", "");
    pref.setString("carColor", "");
    pref.setString("carNum", "");
    pref.setString("addressDefalt", "");
    pref.setDouble("rate", 0.0);
    pref.setString("ipuser", "");
    pref.setString("fullname", "");
    pref.setString("mobile", "");
    pref.setString("address", "");
    pref.setString("imgurl", "");
    pref.setString("image", "");
    pref.setString("birth", "");
    pref.setString("notficationsCount", "");
    pref.setString("ordersCount", "");
    pref.setString("loginType", "");
    pref.setDouble("walletCount", 0.0);
    pref.setString("cartCount", '0');

  
    General.notficationsCount = "";
    General.token = "";
    General.address = "";
    General.id = "";
    General.username = "";
    General.email = "";
    General.image = "";
    General.imgurl = "";

    General.token = "";
    General.id = "";
    General.type = "";
    General.sex = "";
    General.sexName = "";
    General.carType = "";
    General.carColor = "";
    General.carNum = "";
    General.addressDefalt = "";
    General.rate = 0.0;
    General.ipuser = "";
    General.username = "";
    General.fullname = "";
    General.mobile = "";
    General.address = "";
    General.imgurl = "";
    General.image = "";
    General.email = "";
    General.birth = "";
    General.notficationsCount = "";
    General.ordersCount = "";
    General.loginType = "";
    General.walletCount = 0.0;
    General.cartCount = '0';
    General.latitude=21.389082;
    General.longitude=39.857910;
    getUserData();
  }
}
