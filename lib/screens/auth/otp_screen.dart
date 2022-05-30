import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:tiendaweb/controllers/auth_controller.dart';
import 'package:tiendaweb/utils/colors.dart';
import 'package:tiendaweb/utils/constant.dart';
import 'package:tiendaweb/utils/dimension.dart';
import 'package:tiendaweb/widgets/small_text.dart';

import '../../utils/custom_loader.dart';

class OTPScreen extends StatefulWidget {
  final String mobile;
  const OTPScreen({Key? key, required this.mobile}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  double height = 0;
  double width = 0;

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {});
    super.initState();
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
              SmallText(
                text: 'Verify OTP',
                size: Dimensions.font18 * 2,
                color: AppColor.black,
              ),
              SizedBox(height: Dimensions.height10),
              SmallText(
                text: '${ConstantKey.otpScreenText} ${widget.mobile}',
                size: Dimensions.font24,
                color: AppColor.black,
                maxLine: 2,
              ),

              SizedBox(height: Dimensions.height20),
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

  Widget get otpField => GetBuilder<AuthController>(builder: (authController) {
        return Pinput(
          controller: authController.otpController,
          pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
          keyboardType: TextInputType.number,
          length: 6,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your OTP';
            } else if (authController.otpController.text.trim() == '') {
              return 'Please enter your OTP';
            } else {
              return null;
            }
          },
        );
      });

  Widget get otpButton => GetBuilder<AuthController>(builder: (authController) {
        return Align(
          alignment: Alignment.center,
          child: (authController.isLoading == true)
              ? CustomLoader()
              : InkWell(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      await authController.otp();
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.all(Dimensions.height15),
                    padding: EdgeInsets.symmetric(horizontal: 60, vertical: 8),
                    decoration: BoxDecoration(
                        color: AppColor.appColor,
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius15 * 2)),
                    child: SmallText(
                      text: 'Verify',
                      color: AppColor.white,
                      size: Dimensions.font18,
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
                      color: AppColor.appColor, fontWeight: FontWeight.bold),
                )
              ]),
        ),
      );
}
