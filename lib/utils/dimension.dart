import 'package:flutter/material.dart';

const double size20 = 20;
const double size22 = 22;
const double size25 = 25;
const double size27 = 25;
const double size30 = 30;
const double size34 = 34;
const double size45 = 45;
const double size50 = 50;
const double size55 = 55;
const double size70 = 70;

class Dimensions {
  late MediaQueryData _mediaQuery;
  static double? screenHeight;
  static double? screenWidth;

  // Font size
  static double font10 = 10;
  static double font12 = 12;
  static double font13 = 13;
  static double font14 = 14;
  static double font15 = 15;
  static double font16 = 16;
  static double font18 = 18;
  static double font20 = 20;
  static double font24 = 24;
  static double font26 = 26;

  //dynamic height padding and margin
  static double height5 = 5;
  static double height10 = 10;
  static double height15 = 15;
  static double height20 = 20;
  static double height30 = 30;
  static double height45 = 45;
  static double height50 = 50;
  static double height60 = 60;
  static double height80 = 80;
  static double height100 = 100;
  static double height120 = 120;
  static double height130 = 130;
  static double height140 = 140;

  //dynamic height padding and margin
  static double width5 = 5;
  static double width10 = 10;
  static double width15 = 15;
  static double width20 = 20;
  static double width30 = 30;
  static double width45 = 45;
  static double width60 = 60;
  static double width80 = 80;
  static double width100 = 100;
  static double width120 = 120;
  static double width130 = 130;
  static double width140 = 140;

  static double radius10 = 10;
  static double radius15 = 15;

  //Icon Size
  static double iconSize16 = 16;
  static double iconSize20 = 20;
  static double iconSize24 = 24;
  static double iconSize25 = 25;
  static double iconSize30 = 30;

  void init(BuildContext context) {
    _mediaQuery = MediaQuery.of(context);

    screenHeight = _mediaQuery.size.height;
    screenWidth = _mediaQuery.size.width;

    // Font size
    font10 = (screenHeight! / 78);
    font12 = (screenHeight! / 65);
    font13 = (screenHeight! / 60);
    font14 = (screenHeight! / 55.72);
    font15 = (screenHeight! / 52);
    font16 = (screenHeight! / 48.75);
    font18 = (screenHeight! / 43.33);
    font20 = (screenHeight! / 39);
    font24 = (screenHeight! / 32.5);
    font26 = (screenHeight! / 30);

    //dynamic height padding and margin
    height5 = (screenHeight! / 156);
    height10 = (screenHeight! / 78);
    height15 = (screenHeight! / 52);
    height20 = (screenHeight! / 39);
    height30 = (screenHeight! / 26);
    height45 = (screenHeight! / 17.33);
    height50 = (screenHeight! / 15.6);
    height60 = (screenHeight! / 13);
    height80 = (screenHeight! / 9.75);
    height100 = (screenHeight! / 7.8);
    height120 = (screenHeight! / 6.5);
    height130 = (screenHeight! / 6);
    height140 = (screenHeight! / 5.57);

    //dynamic height padding and margin
    width5 = (screenHeight! / 156);
    width10 = (screenHeight! / 78);
    width15 = (screenHeight! / 52);
    width20 = (screenHeight! / 39);
    width30 = (screenHeight! / 26);
    width45 = (screenHeight! / 17.33);
    width60 = (screenHeight! / 13);
    width80 = (screenHeight! / 9.75);
    width100 = (screenHeight! / 7.8);
    width120 = (screenHeight! / 6.5);
    width130 = (screenHeight! / 6);
    width140 = (screenHeight! / 5.57);

    radius10 = (screenHeight! / 78);
    radius15 = (screenHeight! / 52);

    //Icon Size
    iconSize16 = (screenHeight! / 48.75);
    iconSize20 = (screenHeight! / 39);
    iconSize24 = (screenHeight! / 32.5);
    iconSize25 = (screenHeight! / 31.2);
    iconSize30 = (screenHeight! / 26);
  }
}
