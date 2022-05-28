import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:tiendaweb/provider/authPro/auth_provider.dart';
import 'package:tiendaweb/utils/colors.dart';
import 'package:tiendaweb/utils/dimension.dart';

import '../../utils/custom_loader.dart';
import '../stores/store_screen.dart';

class OTPScreen extends StatefulWidget {
  final String mobile;
  const OTPScreen({Key? key, required this.mobile}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController _pinController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isShow = false;
  bool isLoad = false;
  String fcmToken = '';

  double height = 0;
  double width = 0;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _initFun();
    });
    super.initState();
  }

  _initFun() async {
    fcmToken = (await FirebaseMessaging.instance.getToken())!;
    print('Token==--->>  $fcmToken');
    FirebaseMessaging.onMessage.listen((event) {
      print('Token==--->>  ${event.notification}');
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pinController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: body,
    );
  }

  Widget get body => LayoutBuilder(builder: (context, size) {
        log('Size  ${size.maxWidth}');
        return Align(
          alignment: Alignment.center,
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColor.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 8.0,
                    spreadRadius: 2.0,
                  ),
                ]),
            height: size.maxHeight * 0.7,
            width: size.maxWidth * 0.7,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                formSection,
                SizedBox(
                  width: 10,
                ),
                (width > 850) ? imageSection : Container(),
              ],
            ),
          ),
        );
      });

  Widget get formSection => Container(
        width: (width > 850) ? width * 0.3 : width * 0.6,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'Verify OTP',
                style: TextStyle(fontSize: size34),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Please enter the OTP sent to your Phone Number +91 ${widget.mobile}',
                style: TextStyle(fontSize: size20),
              ),
              SizedBox(
                height: 20,
              ),
              otpField,

              otpButton,
              // signupText,
            ],
          ),
        ),
      );

  Widget get imageSection => AspectRatio(
        aspectRatio: (width > 1200) ? 1 : 0.9,
        child: Container(
          height: height * 0.5,
          width: (width > 1200) ? width * 0.3 : width * 0.2,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/image/otp.png'), fit: BoxFit.fill)),
        ),
      );

  Widget get otpField => Container(
        child: Pinput(
          controller: _pinController,
          pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
          keyboardType: TextInputType.number,
          length: 6,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your OTP';
            } else if (_pinController.text.trim() == '') {
              return 'Please enter your OTP';
            } else {
              return null;
            }
          },
        ),
      );

  Widget get otpButton => Align(
        alignment: Alignment.center,
        child: InkWell(
          onTap: () async {
            /* await FirebaseMessaging.instance.getToken().then((value) {
              setState(() {
                fcmToken = value!;
              });
            });*/
            setState(() {
              isLoad = true;
            });
            if (_formKey.currentState!.validate()) {
              Provider.of<AuthProvider>(context, listen: false).otp(
                  context: context,
                  data: {"otp_text": _pinController.text}).then((value) {
                setState(() {
                  isLoad = false;
                });
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StoreScreen(),
                    ),
                    (route) => false);
              });
            } else {
              log('message');
              setState(() {
                isLoad = false;
              });
            }
          },
          child: (isLoad == true)
              ? CustomLoader()
              : Container(
                  margin: EdgeInsets.all(15),
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 8),
                  decoration: BoxDecoration(
                      color: AppColor.appColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30))),
                  child: Text(
                    'Verify',
                    style: TextStyle(
                      color: AppColor.white,
                      fontSize: size20 - 2,
                    ),
                  ),
                ),
        ),
      );

  Widget get signupText => Container(
        alignment: Alignment.center,
        child: RichText(
          text: TextSpan(
              text: 'Don\'t have an account? ',
              style:
                  TextStyle(color: AppColor.black, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: 'Signup',
                  style: TextStyle(
                      color: AppColor.appColor, fontWeight: FontWeight.bold),
                )
              ]),
        ),
      );
}
