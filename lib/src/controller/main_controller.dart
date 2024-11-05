import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../../utility/General.dart';
import '../view/Notification/controllers/notification_controller.dart';
import '../view/Orders/controllers/orders_controller.dart';

class MainController extends SuperController {
  // FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
  @override
  void onDetached() {
  }

  @override
  void onInactive() {
  }

  @override
  void onPaused() {
  }

  @override
  void onResumed() {
  }

  Future<void> _isAndroidPermissionGranted() async {
    if (Platform.isAndroid) {
      final bool granted = await flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.areNotificationsEnabled() ??
          false;
        
        _notificationsEnabled.value = granted;
    }
  }
  

  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  void sendTokenToServer(String fcmToken) {}
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final _notificationsEnabled = false.obs;

  Future<void> _requestPermissions() async {
    if (Platform.isIOS || Platform.isMacOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
            critical: true
          );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
            critical: true
          );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      final bool? granted = await androidImplementation?.requestPermission();
        _notificationsEnabled.value = granted ?? false;
    }
  }
  @override
  void onInit() {
    _isAndroidPermissionGranted();
    _requestPermissions();
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
        General.token != "" 
        ? Get.toNamed('/notifications')
        : Get.toNamed('/loginView');
    });

    FirebaseMessaging.instance.getInitialMessage().then(
      (value) async {
        if (value != null) showNotification2(value);
      },
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showNotification2(message);
    });
    
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      if (event.data.isNotEmpty) {
        General.token != "" 
        ? Get.toNamed('/notifications')
        : Get.toNamed('/loginView');
      }
    });

    
    super.onInit();
  }

  void showNotification2(RemoteMessage message) {
    if (General.token != "") {
      final OrdersController ordersController = Get.put(OrdersController());
      final NotificationsController notifications = Get.put(NotificationsController());
      ordersController.getOrders();
      notifications.getNotifications();
    }
    const NotificationDetails notiDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'com.example.push_notification',
        'push_notification',
        importance: Importance.max,
        priority: Priority.high,
      ),
    );
    notificationsPlugin.show(
      DateTime.now().microsecond,
      message.notification!.title,
      message.notification!.body,
      notiDetails,
      payload: message.data.toString(),
    );
  }

  @override
  void onHidden() {
    // TODO: implement onHidden
  }

  
}
