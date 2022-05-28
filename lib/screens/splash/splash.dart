import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import '/utils/colors.dart';

import '../home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double height = 0;
  double width = 0;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _navigation();
    });

    super.initState();
  }

  void _navigation() {
    Future.delayed(Duration(seconds: 10), () {
      log('Logged In');
      // userType=='user'?
      /*Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(

          ),
        ),
            (route) => false,
      );*/
    });
    // if (widget.isLogin == true) {

    // }
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      //// Wrap your body in a stack
      backgroundColor: AppColor.appColor,
      body: Center(
        child: Container(
          height: height * 0.3,
          width: width * 0.3,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/image/splash.png'),
            ),
          ),
        ),
      ),
    );
  }
}
