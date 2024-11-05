// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';

import '../src/view/Notification/notifications_view.dart';
import '../src/view/Settings/contact_view.dart';
import '../src/view/Settings/thank_view.dart';
import '../src/view/home_view.dart';
import '../src/view/intro/intro_view.dart';
import '../src/view/splash.dart';
import '../src/view/user/login_or_signapp.dart';

class Router {
  static final route = [
    GetPage(
      name: '/homeView',
      page: () => HomeView(),
    ),
    GetPage(
      name: '/Splash',
      page: () => SplashView(),
    ),
    GetPage(
      name: '/intro',
      page: () =>  IntroViews(),
    ),
    GetPage(
      name: '/loginView',
      page: () => LoginOrSignUpView(),
    ),
    
    GetPage(
      name: '/notifications',
      page: () => NotificationsView(),
    ),
    GetPage(
      name: '/contactView',
      page: () => ContactView(),
    ),
    GetPage(
      name: '/thank',
      page: () => ThankView(),
    ),
  ];
}
