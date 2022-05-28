import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tiendaweb/provider/authPro/auth_provider.dart';
import 'package:tiendaweb/utils/colors.dart';
import 'package:tiendaweb/utils/dimension.dart';

import '../../utils/custom_loader.dart';
import '../../utils/custom_widgets.dart';
import 'otp_screen.dart';

class SignupScreen extends StatefulWidget {
  final String mobile;
  const SignupScreen({Key? key, required this.mobile}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController _mobileController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

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

    setState(() {
      _mobileController = TextEditingController(text: widget.mobile);
      log('Token==--->>  $_mobileController');
    });
    FirebaseMessaging.onMessage.listen((event) {
      log('Token==--->>  ${event.notification}');
    });
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
                'Signup',
                style: TextStyle(fontSize: size45),
              ),
              SizedBox(
                height: 20,
              ),
              textFieldMobile,
              textFieldName,
              // forgotPass,
              signButton,
              loginText,
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
                  image: AssetImage('assets/image/sign.png'),
                  fit: BoxFit.fill)),
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

  Widget get textFieldName => Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: TextFormField(
          controller: _nameController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: TextInputType.name,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
            LengthLimitingTextInputFormatter(50)
          ],
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.person),
            labelText: 'User Name',
            border: border,
            enabledBorder: border,
            focusedBorder: enableBorder,
            errorBorder: errorBorder,
            focusedErrorBorder: errorBorder,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your name';
            } else if (_nameController.text.trim() == '') {
              return 'Please enter your name';
            } else {
              return null;
            }
          },
        ),
      );

  Widget get signButton => Align(
        alignment: Alignment.center,
        child: InkWell(
          onTap: () async {
            /* await FirebaseMessaging.instance.getToken().then((value) {
              setState(() {
                fcmToken = value!;
              });
            });*/
            setState(() {
              isLoad = false;
            });
            if (_formKey.currentState!.validate()) {
              Provider.of<AuthProvider>(context, listen: false)
                  .signUp(context: context, data: {
                "user_mobile": _mobileController.text.trim(),
                "user_name": _nameController.text.trim(),
                "device_token": fcmToken.toString()
              }).then((value) {
                setState(() {
                  isLoad = false;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OTPScreen(
                      mobile: _mobileController.text,
                    ),
                  ),
                );
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
                    'Signup',
                    style: TextStyle(
                      color: AppColor.white,
                      fontSize: size20 - 2,
                    ),
                  ),
                ),
        ),
      );

  Widget get loginText => Container(
        alignment: Alignment.center,
        child: RichText(
          text: TextSpan(
              text: 'Already have an account? ',
              style:
                  TextStyle(color: AppColor.black, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: 'Login',
                  style: TextStyle(
                      color: AppColor.appColor,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => Navigator.pop(
                          context,
                        ),
                )
              ]),
        ),
      );
}
