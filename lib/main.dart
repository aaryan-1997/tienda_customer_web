import 'dart:developer';
import 'dart:html';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiendaweb/controllers/auth_controller.dart';
import 'package:tiendaweb/controllers/home_controller.dart';
import 'package:tiendaweb/controllers/local_db_controller.dart';
import 'package:tiendaweb/controllers/location_controller.dart';
import 'package:tiendaweb/controllers/order_controller.dart';
import 'package:tiendaweb/controllers/store_controller.dart';
import 'package:tiendaweb/routes/routes.dart';
import 'package:tiendaweb/utils/constant.dart';
import 'package:url_strategy/url_strategy.dart';
import './helper/dependencies.dart' as dep;

void main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();

  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyALDyH9CEtHUe3zfMu6Bbx6t6Lsgbo8sS4",
          authDomain: "tiendaweb-218ec.firebaseapp.com",
          projectId: "tiendaweb-218ec",
          storageBucket: "tiendaweb-218ec.appspot.com",
          messagingSenderId: "1009718506764",
          appId: "1:1009718506764:web:4f62a83e29c94c0c344529",
          measurementId: "G-ZMZQS98Q8E"));

  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  goFullScreen();
  runApp(const MyApp());
}

void goFullScreen() {
  document.documentElement!.requestFullscreen();
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLogin = false;
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      getPref();
    });
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<AuthController>().getFcmToken();
    Get.find<LocalDbController>().userIdContains();
    Get.find<LocalDbController>().getuserId();
    Get.find<LocalDbController>().getAccessToken();
    Get.find<LocationController>().getGeoLocationPosition();
    Get.find<StoreController>().getshopList();
    Get.find<StoreController>().getNearByShop();
    Get.find<HomeController>();
    Get.find<OrderController>();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tienda',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute:
          (isLogin == true) ? Routes.getStoreRoute() : Routes.getLoginRoute(),
      getPages: Routes.routes,
    );
  }

  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getBool(ConstantKey.isUserLoginKey) == true) {
      setState(() {
        isLogin = true;
      });
    } else {
      setState(() {
        isLogin = false;
      });
    }
  }
}

Future<void> _messageHandler(RemoteMessage remoteMessage) async {
  log("onBackgroundMessage-->" + remoteMessage.notification!.title.toString());
}
