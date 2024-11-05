import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SendNotfyTestController extends GetxController {

  final String serverToken = 'AAAAq2IzrU4:APA91bHDU7ryijrS1edYpAsWayK3luL4e-8aIcurXElALAgWn7UN2DtefUgRr_DVZar4rQfqwq2eYn-eg2vJ-tte6A8BVuvLgUVHWmskPnc6Xa6TU5XGcbupmIdTqytLTCYI2cr6LICs';
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  sendAndRetrieveMessage() async {
    firebaseMessaging.getToken().then((String? token) {
      assert(token != null);
    });
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
      <String, dynamic>{
        'notification': <String, dynamic>{
          'body': 'this is a body',
          'title': 'this is a title'
        },
        'priority': 'high',
        'data': <String, dynamic>{
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'id': '1',
          'status': 'done'
        },
        'to': await firebaseMessaging.getToken(),
      },
      ),
    );
  }
}
