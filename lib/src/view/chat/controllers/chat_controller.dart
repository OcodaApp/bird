// ignore_for_file: deprecated_member_use, invalid_use_of_protected_member, avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../constance.dart';
import '../../../../http/request.dart';
import '../../../../http/url.dart';
import '../../../../model/chating_model.dart';
import 'package:http/http.dart' as http;

import '../../../../utility/General.dart';
import '../../../controller/lang_controller.dart';
import '../../../controller/main_controller.dart';

class ChatController extends GetxController {
  TextEditingController msgTextController = TextEditingController();
  var chatsListData = <Chats>[].obs;
  var orderId = "".obs;
  var bodyType = 'text'.obs;
  var image = ''.obs;
  var imageUrl = ''.obs;
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  void sendTokenToServer(String fcmToken) {}
  


  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {
              print('initialize');
            });
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max),
        iOS: DarwinNotificationDetails());
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payLoad}) async {
        print('ssss');
    return notificationsPlugin.show(
        id, title, body, await notificationDetails());
  }

  Future<void> _firebaseMessagingBackgroundHandler(message) async {
    await Firebase.initializeApp();
    print('Handling a background message ${message.messageId}');
    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }
  @override
  void onInit() {
    print("orderId.value");
    print(orderId.value);
    orderId.value = Get.arguments[0].toString();
    msgTextController = TextEditingController();
    

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    const InitializationSettings initialSettings = InitializationSettings(
      android: AndroidInitializationSettings(
        '@mipmap/ic_launcher',
      ),
      iOS: DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        ),
      );
    notificationsPlugin.initialize(initialSettings,
        onDidReceiveNotificationResponse: (NotificationResponse details) {
      print('onDidReceiveNotificationResponse Function');
      print(details.payload);
      print(details.payload != null);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      apiCahtData();
      
    });
    apiCahtData();
    
    super.onInit();
  }

  

  void apiCahtData() async {
    var data = {
      'order_id': orderId.value,
    };
    Request request = Request(url: urlChatsList, body: data);
    request.postAuth().then((value) {
      if (value['status']) {
        ChatListModel chatsListModel = ChatListModel.fromJson(value);
        chatsListData.value = chatsListModel.chats!;
      }
    }).catchError((onError) {
      print(onError);
    });
  }

  void addMsg() async {
    Get.dialog(
      const Center(
        child: CircularProgressIndicator(
          backgroundColor: primaryColor,
        ),
      ),
      barrierDismissible: false,
    );
    var data = {
      'body': bodyType.value == 'text' ?msgTextController.text:image.value,
      'order_id': orderId.value,
      'body_type' : bodyType.value,
    };
    print(data);
    Request request = Request(url: urlAddMsg, body: data);
    request.postAuth().then((value) {
      Get.back();
      if (value['status']) {
        msgTextController.clear();
        apiCahtData();
      } else {
        Fluttertoast.showToast(
          msg: value['msg'],
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    }).catchError((onError) {
      Fluttertoast.showToast(
        msg: 'agien'.tr,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    });
  }

  void getImageCaht(ImageSource imageSource) async {
    final ImagePicker picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: imageSource, maxHeight: 600, maxWidth: 480);
    if (file != null) {
      apiuploadListChat(file);
    } else {
      Fluttertoast.showToast(
        msg: 'no image selected'.tr,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: sizeW15,
      );
    }
  }

  void apiuploadListChat(XFile image) async {
    uploadChat(image);
  }

  uploadChat(XFile file) async {
    Future.delayed(
      Duration.zero,
      () => Get.dialog(
       const Center(
            child: CircularProgressIndicator(
          backgroundColor: primaryColor,
        )),
        barrierDismissible: false,
      ),
    );
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
        urlBase + uploadImageUser,
      ),
    );
    final LangController langController = Get.put(LangController());
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept-Language": langController.appLocale,
      "app-id": 'romwayAtharOmarKamel',
      "Authorization": General.token,
    };
    request.headers.addAll(headers);
    request.files.add(
      http.MultipartFile(
        'image',
        File(file.path).readAsBytes().asStream(),
        File(file.path).lengthSync(),
        filename: file.path.split("/").last,
      ),
    );

    await request.send().then(
      (response) async {
        if (response.statusCode < 200 ||
            response.statusCode > 400 ) {
          Fluttertoast.showToast(
            msg: 'error_api'.tr,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.redAccent,
            textColor: Colors.white,
            fontSize: sizeW15,
          );
          Get.back();
        } else {
          var responseData = await response.stream.toBytes();
          var responseString = String.fromCharCodes(responseData);
          var data = jsonDecode(responseString);
          if (data['status']) {
            print(data['data']);
            print(data['image']);
            imageUrl.value = data['data'];
            image.value = data['image'];
            Get.back();
            await Get.dialog(
              Scaffold(
                backgroundColor: greycolor.withOpacity(0.1),
                body: Center(
                  child: Container(
                    height: Get.height / 1.5,
                    margin: EdgeInsets.all(sizeW20),
                    padding: EdgeInsets.all(sizeW20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(sizeW15),
                      color: whitecolor
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('send'.tr,style: TextStyle(color: primaryColor,fontSize: sizeW16,fontWeight: FontWeight.w700),),
                        SizedBox(height: sizeH30,),
                        SizedBox(
                          width: Get.width / 1.5,
                          height: Get.height / 2.5,
                          child: Image.network(imageUrl.value)
                        ),
                        SizedBox(height: sizeH20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MaterialButton(
                              elevation: 0,
                              color: primaryColor,
                              minWidth: Get.width / 2.7,
                              height: sizeH40,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(sizeW15),
                              ),
                              onPressed: (){
                                bodyType.value = 'image';
                                addMsg();
                                Get.back();
                              },
                              child: Text(
                                'send'.tr,
                                style:  TextStyle(
                                  fontSize: sizeW16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            MaterialButton(
                              elevation: 0,
                              color: whitecolor,
                              minWidth: Get.width / 2.7,
                              height: sizeH40,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(sizeW15),
                                side: const BorderSide(color: primaryColor)
                              ),
                              onPressed: (){
                                Get.back();
                              },
                              child: Text(
                                'cancel'.tr,
                                style:  TextStyle(
                                  fontSize: sizeW16,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              barrierDismissible: false,
            );
            
          } else {
            Fluttertoast.showToast(
              msg: data['msg'].toString(),
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.redAccent,
              textColor: Colors.white,
              fontSize: sizeW15,
            );
            
          }
          return responseString;
        }
      },
    );
  }

  @override
  void onClose() {
    msgTextController.dispose(); 
    final MainController mainController = Get.put(MainController());
    mainController.onInit();
    super.onClose();
  }
}
