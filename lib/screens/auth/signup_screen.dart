import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tiendaweb/controllers/auth_controller.dart';
import 'package:tiendaweb/routes/routes.dart';
import 'package:tiendaweb/utils/colors.dart';
import 'package:tiendaweb/utils/dimension.dart';
import 'package:tiendaweb/widgets/big_text.dart';

import '../../utils/custom_loader.dart';
import '../../utils/custom_widgets.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String fcmToken = '';

  double height = 0;
  double width = 0;

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _initFun();
    });
    super.initState();
  }

  _initFun() async {
    fcmToken = (await FirebaseMessaging.instance.getToken())!;

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
                (width > 850) ? Expanded(child: imageSection) : Container(),
              ],
            ),
          ),
        );
      });

  Widget get formSection => SizedBox(
        width: (width > 850) ? width * 0.3 : width * 0.6,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Dimensions.height20),
              BigText(
                text: "Signup",
                size: Dimensions.font15 * 3,
              ),
              SizedBox(height: Dimensions.height20),
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

  Widget get textFieldMobile =>
      GetBuilder<AuthController>(builder: (authController) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: TextFormField(
            controller: authController.mobileNumberController,
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
              if ((GetUtils.isNullOrBlank(value)!) ||
                  GetUtils.isNumericOnly(value.toString()) &&
                      !GetUtils.isLengthEqualTo(value, 10)) {
                return 'Please enter your mobile number';
              }
              return null;
            },
          ),
        );
      });

  Widget get textFieldName =>
      GetBuilder<AuthController>(builder: (authController) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: TextFormField(
            controller: authController.nameController,
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
              if ((GetUtils.isNullOrBlank(value)!)) {
                return 'Please enter your name';
              } else {
                return null;
              }
            },
          ),
        );
      });

  Widget get signButton =>
      GetBuilder<AuthController>(builder: (authController) {
        return Align(
          alignment: Alignment.center,
          child: (authController.isLoading == true)
              ? CustomLoader()
              : InkWell(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      authController.signUp();
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.all(15),
                    padding: EdgeInsets.symmetric(horizontal: 60, vertical: 8),
                    decoration: BoxDecoration(
                        color: AppColor.appColor,
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius15 * 2)),
                    child: BigText(
                      text: 'Signup',
                      color: AppColor.white,
                      size: Dimensions.font18,
                    ),
                  ),
                ),
        );
      });

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
                    ..onTap = () => Get.toNamed(Routes.getLoginRoute()),
                )
              ]),
        ),
      );
}
