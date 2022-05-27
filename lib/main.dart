import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiendaweb/provider/authPro/auth_provider.dart';
import 'package:tiendaweb/provider/homePro/home_provider.dart';
import 'package:tiendaweb/provider/shopPro/shop_provider.dart';
import 'package:tiendaweb/screens/stores/store_screen.dart';
import 'package:tiendaweb/utils/constant.dart';
import 'package:url_strategy/url_strategy.dart';
import 'screens/auth/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
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
  runApp(const MyApp());
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
    setPathUrlStrategy();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ShopProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tienda Web',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: StoreScreen(),
        home: (isLogin == true) ? StoreScreen() : LoginScreen(),
      ),
    );
  }

  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getBool(isUserLoginKey) == true) {
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
