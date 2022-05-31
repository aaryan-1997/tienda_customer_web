import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiendaweb/routes/routes.dart';
import 'package:tiendaweb/utils/colors.dart';
import 'package:tiendaweb/utils/dimension.dart';
import 'package:tiendaweb/widgets/icon_and_text_widget.dart';

AppBar get appBar => AppBar(
      centerTitle: true,
      elevation: 0.4,
      flexibleSpace: Container(color: AppColor.white),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: Dimensions.height50,
            width: Dimensions.width45,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/image/logo.png'), fit: BoxFit.fill),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                focusColor: AppColor.grey,
                onTap: () {
                  Get.toNamed(Routes.getHomeRoute());
                },
                child: IconAndBigTextWidget(
                  icon: Icons.home_rounded,
                  text: 'Home',
                  iconColor: AppColor.black,
                  textColor: AppColor.black,
                  iconSize: Dimensions.height30,
                  textSize: Dimensions.font20,
                ),
              ),
              SizedBox(width: Dimensions.height20),
              IconAndBigTextWidget(
                icon: Icons.category,
                text: 'Category',
                iconColor: AppColor.black,
                textColor: AppColor.black,
                iconSize: Dimensions.height30,
                textSize: Dimensions.font20,
              ),
              SizedBox(width: Dimensions.height20),
              IconAndBigTextWidget(
                icon: Icons.favorite_rounded,
                text: 'Wishlist',
                iconColor: AppColor.black,
                textColor: AppColor.black,
                iconSize: Dimensions.height30,
                textSize: Dimensions.font20,
              ),
              SizedBox(width: Dimensions.height20),
              IconAndBigTextWidget(
                icon: Icons.contact_page,
                text: 'About Us',
                iconColor: AppColor.black,
                textColor: AppColor.black,
                iconSize: Dimensions.height30,
                textSize: Dimensions.font20,
              ),
              SizedBox(width: Dimensions.height20),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.getStoreRoute());
                },
                child: IconAndBigTextWidget(
                  icon: Icons.add_business_sharp,
                  text: 'Your Stores',
                  iconColor: AppColor.black,
                  textColor: AppColor.black,
                  iconSize: Dimensions.height30,
                  textSize: Dimensions.font20,
                ),
              ),
              SizedBox(width: Dimensions.height20),
            ],
          )
        ],
      ),
      actions: [
        IconButton(
            onPressed: () {}, icon: Icon(Icons.search, color: AppColor.black)),
        IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_cart, color: AppColor.black)),
        IconButton(
            onPressed: () {}, icon: Icon(Icons.person, color: AppColor.black)),
        SizedBox(width: Dimensions.width10),
      ],
    );
