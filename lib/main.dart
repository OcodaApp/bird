// ignore_for_file: library_private_types_in_public_api
import 'package:birdandroid/utility/General.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:ui' show PointerDeviceKind;
import 'package:get_storage/get_storage.dart';
import 'firebase_options.dart';
import 'src/controller/lang_controller.dart';
import 'src/controller/main_controller.dart';
import 'translation.dart';
import 'package:flutter/material.dart' hide Router;
import 'utility/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await General().getUserData();
  await GetStorage.init();
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  final LangController langController = Get.put(LangController());
  final MainController mainController = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
    return GetMaterialApp(
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
        },
      ),
      theme: ThemeData(
        fontFamily: langController.appLocale == 'ar' ? 'Almarai' : 'SF',
      ),
      title: 'Bird',
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.rightToLeft,
      // home:  SplashView(),
      getPages: Router.route,
      initialRoute: '/Splash',
      translations: Translation(),
      locale: Locale(langController.appLocale),
      fallbackLocale: Locale(langController.appLocale),
    );
  }
}
