import 'dart:developer';
import 'dart:html';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tiendaweb/provider/authPro/auth_provider.dart';
import 'package:tiendaweb/screens/auth/otp_screen.dart';
import 'package:tiendaweb/screens/auth/signup_screen.dart';
import 'package:tiendaweb/utils/colors.dart';
import 'package:tiendaweb/utils/custom_loader.dart';
import 'package:tiendaweb/utils/dimension.dart';

import '../../model/authModel/auth_model.dart';
import '../../utils/custom_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isShow = false;
  bool isLoad = false;
  String fcmToken = '';

  String? _token;
  Stream<String>? _tokenStream;
  int notificationCount = 0;

  void setToken(String token) {
    setState(() {
      _token = token;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _initFun();
    });
    super.initState();
  }

  _initFun() async {
    fcmToken = (await FirebaseMessaging.instance.getToken())!;

    await FirebaseMessaging.instance.getToken().then((value) {
      _tokenStream = FirebaseMessaging.instance.onTokenRefresh;
      _tokenStream!.listen(setToken);
    });
    log('Token==--->>  $_token');
    FirebaseMessaging.onMessage.listen((event) {
      log('Token==--->>  ${event.notification}');
    });
  }

  @override
  void dispose() {
    super.dispose();
    _mobileController.dispose();
    _passController.dispose();
  }

  double height = 0;
  double width = 0;

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
                color: white,
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
                SizedBox(width: 10),
                (width > 850) ? Expanded(child: imageSection) : Container(),
              ],
            ),
          ),
        );
      });

  Widget get formSection => Container(
        padding: EdgeInsets.only(left: 20),
        width: (width > 850) ? width * 0.3 : width * 0.6,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Container(
                alignment: Alignment.center,
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: size45),
                ),
              ),
              SizedBox(height: 20),
              textFieldMobile,
              // textFieldPass,
              // forgotPass,
              signButton,
              signupText,
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
                image: AssetImage('assets/image/loginIcon.png'),
                fit: BoxFit.fill),
          ),
        ),
      );

  Widget get textFieldMobile => Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: TextFormField(
          controller: _mobileController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
            LengthLimitingTextInputFormatter(10)
          ],
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.phone_android),
            labelText: 'Mobile number',
            border: border,
            enabledBorder: border,
            focusedBorder: enableBorder,
            errorBorder: errorBorder,
            focusedErrorBorder: errorBorder,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your mobile number';
            } else if (_mobileController.text.length < 10) {
              return "Please enter a valid Mobile number";
            }
            /*else if (!isValidMobile) {
          return 'Mobile number doesn\'t exist';
        }*/
            return null;
          },
        ),
      );

  Widget get textFieldPass => Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: TextFormField(
          controller: _passController,
          obscureText: !isShow,
          obscuringCharacter: '*',
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock),
            labelText: 'Password',
            suffixIcon: InkWell(
                onTap: () {
                  setState(() {
                    isShow = !isShow;
                  });
                },
                child: Icon(isShow ? Icons.visibility : Icons.visibility_off)),
            border: border,
            enabledBorder: border,
            focusedBorder: enableBorder,
            errorBorder: errorBorder,
            focusedErrorBorder: errorBorder,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter password';
            } else if (_passController.text.length < 6) {
              return 'Please enter 6 digit password';
            }
            return null;
          },
        ),
      );

  Widget get forgotPass => Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Forgot password?',
              style: TextStyle(
                  color: buttonColor,
                  fontSize: size20,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      );

  Widget get signButton => Align(
        alignment: Alignment.center,
        child: InkWell(
          onTap: () async {
            /* await FirebaseMessaging.instance.getToken().then((value) {
            });*/
            setState(() {
              isLoad = true;
            });
            if (_formKey.currentState!.validate()) {
              Provider.of<AuthProvider>(context, listen: false).login(
                  context: context,
                  data: {
                    "username": _mobileController.text.trim(),
                    "device_token": fcmToken.toString()
                  }).then((value) async {
                setState(() {
                  isLoad = false;
                  CheckAuthModel data =
                      Provider.of<AuthProvider>(context, listen: false)
                          .checkAuthModel!;
                  if (data.isExist == false) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignupScreen(
                          mobile: _mobileController.text,
                        ),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OTPScreen(
                          mobile: _mobileController.text,
                        ),
                      ),
                    );
                  }
                });
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
                    color: appColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: white,
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
              style: TextStyle(color: black, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: 'Signup',
                  style: TextStyle(
                      color: appColor,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignupScreen(mobile: ''),
                          ),
                        ),
                ),
              ]),
        ),
      );
}
