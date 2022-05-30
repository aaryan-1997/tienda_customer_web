import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tiendaweb/controllers/auth_controller.dart';
import 'package:tiendaweb/routes/routes.dart';
import 'package:tiendaweb/utils/colors.dart';
import 'package:tiendaweb/utils/custom_loader.dart';
import 'package:tiendaweb/utils/dimension.dart';
import 'package:tiendaweb/widgets/big_text.dart';

import '../../utils/custom_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
    );
  }

  Widget get body => Align(
        alignment: Alignment.center,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius15),
              color: AppColor.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 8.0,
                  spreadRadius: 2.0,
                ),
              ]),
          height: Dimensions.screenHeight * 0.7,
          width: Dimensions.screenWidth * 0.7,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              formSection,
              SizedBox(width: Dimensions.width10),
              (Dimensions.screenWidth > 850)
                  ? Expanded(child: imageSection)
                  : Container(),
            ],
          ),
        ),
      );

  Widget get formSection => Container(
        padding: EdgeInsets.only(left: Dimensions.width20),
        width: (Dimensions.screenWidth > 850)
            ? Dimensions.screenWidth * 0.3
            : Dimensions.screenWidth * 0.6,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Container(
                alignment: Alignment.center,
                child: BigText(
                  text: 'Login',
                  size: Dimensions.font24 * 2,
                ),
              ),
              SizedBox(height: Dimensions.height20),
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
        aspectRatio: (Dimensions.screenWidth > 1200) ? 1 : 0.9,
        child: Container(
          height: Dimensions.screenHeight * 0.5,
          width: (Dimensions.screenWidth > 1200)
              ? Dimensions.screenWidth * 0.3
              : Dimensions.screenWidth * 0.2,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/image/loginIcon.png'),
                fit: BoxFit.fill),
          ),
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

  Widget get forgotPass => Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            BigText(
              text: 'Forgot password?',
              size: Dimensions.font20,
              weight: FontWeight.bold,
              color: AppColor.buttonColor,
            ),
          ],
        ),
      );

  Widget get signButton =>
      GetBuilder<AuthController>(builder: (authController) {
        return Align(
          alignment: Alignment.center,
          child: (authController.isLoading == true)
              ? CustomLoader()
              : InkWell(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      await authController.login();
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.all(15),
                    padding: EdgeInsets.symmetric(horizontal: 60, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColor.appColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: BigText(
                      text: 'Login',
                      size: Dimensions.font20,
                      weight: FontWeight.bold,
                      color: AppColor.white,
                    ),
                  ),
                ),
        );
      });

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
                      color: AppColor.appColor,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => Get.toNamed(Routes.getSignupRoute()),
                ),
              ]),
        ),
      );
}
