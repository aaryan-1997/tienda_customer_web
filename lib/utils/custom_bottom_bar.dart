import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:tiendaweb/controllers/auth_controller.dart';
import 'package:tiendaweb/routes/routes.dart';
import 'package:tiendaweb/utils/colors.dart';
import 'package:tiendaweb/utils/constant.dart';
import 'package:tiendaweb/utils/dimension.dart';
import 'package:tiendaweb/widgets/big_text.dart';
import 'package:tiendaweb/widgets/icon_and_text_widget.dart';
import 'package:tiendaweb/widgets/small_text.dart';

Widget get bottomBar => SizedBox(
      height: Dimensions.screenHeight / 1.6,
      width: Dimensions.screenWidth,
      child: ClipPath(
        clipper: WaveClipperOne(flip: true, reverse: true),
        child: Container(
          color: AppColor.appColor.withOpacity(0.2),
          padding: EdgeInsets.only(
              top: Dimensions.height60,
              left: Dimensions.width45,
              right: Dimensions.width45),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GetBuilder<AuthController>(builder: (authController) {
                return Expanded(
                  child: SizedBox(
                    width: Dimensions.screenWidth / 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Dimensions.height100,
                          width: Dimensions.width100,
                          child: Image.asset("assets/image/splash.png"),
                        ),
                        SizedBox(height: Dimensions.height30),
                        SmallText(
                          text: ConstantKey.about,
                          color: AppColor.black,
                          size: Dimensions.font16,
                          maxLine: 5,
                        ),
                        SizedBox(height: Dimensions.height20),
                        Row(
                          children: [
                            SmallText(
                              text: "Address :",
                              color: AppColor.black,
                              size: Dimensions.font18,
                            ),
                            SizedBox(width: Dimensions.width10),
                            BigText(
                              text: authController.userDetail.address ?? "",
                              color: AppColor.black,
                              size: Dimensions.font16,
                              maxline: 2,
                              weight: FontWeight.bold,
                            ),
                          ],
                        ),
                        SizedBox(height: Dimensions.height20),
                        Row(
                          children: [
                            SmallText(
                              text: "Email :",
                              color: AppColor.black,
                              size: Dimensions.font18,
                            ),
                            SizedBox(width: Dimensions.width10),
                            BigText(
                              text: authController.userDetail.email ?? "",
                              color: AppColor.black,
                              size: Dimensions.font16,
                              weight: FontWeight.bold,
                            ),
                          ],
                        ),
                        SizedBox(height: Dimensions.height20),
                        Row(
                          children: [
                            SmallText(
                              text: "Call Us :",
                              color: AppColor.black,
                              size: Dimensions.font18,
                              maxLine: 2,
                            ),
                            SizedBox(width: Dimensions.width10),
                            BigText(
                              text: authController.userDetail.phone ?? "",
                              color: AppColor.black,
                              size: Dimensions.font16,
                              weight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
              Expanded(
                child: Container(
                  width: Dimensions.screenWidth / 4,
                  margin: EdgeInsets.only(left: Dimensions.width60),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Dimensions.height60),
                      BigText(
                        text: "Quick Links",
                        color: AppColor.black,
                        size: Dimensions.font26,
                        weight: FontWeight.bold,
                      ),
                      SizedBox(height: Dimensions.height20),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.getHomeRoute());
                        },
                        child: IconAndBigTextWidget(
                          icon: Icons.arrow_forward,
                          text: "Home",
                          space: Dimensions.width5,
                          iconColor: AppColor.appColor,
                          textSize: Dimensions.font20,
                          textColor: AppColor.black,
                        ),
                      ),
                      SizedBox(height: Dimensions.height20),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.getStoreRoute());
                        },
                        child: IconAndBigTextWidget(
                          icon: Icons.arrow_forward,
                          text: "Shop",
                          space: Dimensions.width5,
                          iconColor: AppColor.appColor,
                          textSize: Dimensions.font20,
                          textColor: AppColor.black,
                        ),
                      ),
                      SizedBox(height: Dimensions.height20),
                      GestureDetector(
                        onTap: () {},
                        child: IconAndBigTextWidget(
                          icon: Icons.arrow_forward,
                          text: "About",
                          space: Dimensions.width5,
                          iconColor: AppColor.appColor,
                          textSize: Dimensions.font20,
                          textColor: AppColor.black,
                        ),
                      ),
                      SizedBox(height: Dimensions.height20),
                      GestureDetector(
                        onTap: () {},
                        child: IconAndBigTextWidget(
                          icon: Icons.arrow_forward,
                          text: "Contact Us",
                          space: Dimensions.width5,
                          iconColor: AppColor.appColor,
                          textSize: Dimensions.font20,
                          textColor: AppColor.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: Dimensions.screenWidth / 4,
                  margin: EdgeInsets.only(left: Dimensions.width60),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Dimensions.height60),
                      BigText(
                        text: "Extra Links",
                        color: AppColor.black,
                        size: Dimensions.font26,
                        weight: FontWeight.bold,
                      ),
                      SizedBox(height: Dimensions.height20),
                      GestureDetector(
                        onTap: () {},
                        child: IconAndBigTextWidget(
                          icon: Icons.arrow_forward,
                          text: "My Orders",
                          space: Dimensions.width5,
                          iconColor: AppColor.appColor,
                          textSize: Dimensions.font20,
                          textColor: AppColor.black,
                        ),
                      ),
                      SizedBox(height: Dimensions.height20),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.getWishlistRoute());
                        },
                        child: IconAndBigTextWidget(
                          icon: Icons.arrow_forward,
                          text: "My Wishlist",
                          space: Dimensions.width5,
                          iconColor: AppColor.appColor,
                          textSize: Dimensions.font20,
                          textColor: AppColor.black,
                        ),
                      ),
                      SizedBox(height: Dimensions.height20),
                      GestureDetector(
                        onTap: () {},
                        child: IconAndBigTextWidget(
                          icon: Icons.arrow_forward,
                          text: "My Acount",
                          space: Dimensions.width5,
                          iconColor: AppColor.appColor,
                          textSize: Dimensions.font20,
                          textColor: AppColor.black,
                        ),
                      ),
                      SizedBox(height: Dimensions.height20),
                      GestureDetector(
                        onTap: () {},
                        child: IconAndBigTextWidget(
                          icon: Icons.arrow_forward,
                          text: "Term & Condition",
                          space: Dimensions.width5,
                          iconColor: AppColor.appColor,
                          textSize: Dimensions.font20,
                          textColor: AppColor.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: Dimensions.screenWidth / 4,
                  margin: EdgeInsets.only(left: Dimensions.width60),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: Dimensions.height60),
                      BigText(
                        text: "Download Our App",
                        color: AppColor.black,
                        size: Dimensions.font26,
                        weight: FontWeight.bold,
                      ),
                      SizedBox(height: Dimensions.height20),
                      Container(
                        height: Dimensions.height100,
                        width: Dimensions.screenWidth / 4,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/image/play_store.png'),
                              fit: BoxFit.contain),
                        ),
                      ),
                      SizedBox(height: Dimensions.height10),
                      Container(
                        height: Dimensions.height100,
                        width: Dimensions.screenWidth / 4,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/image/apple_store.png'),
                              fit: BoxFit.contain),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
