
import 'package:flutter/material.dart';

import 'colors.dart';


Widget cacheImage({
  required String image,
  required double radius,
  required double height,
  required double width,
}) {
  return Container(
      alignment: Alignment.center,
      height: height,
      width: width,
      // padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        // color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(
            radius,
          ),
        ),
      ),
      child: FadeInImage.assetNetwork( placeholder:
      "assets/image/placeholder.png",
        image: image,
      fit: BoxFit.fill,
      ));
}

OutlineInputBorder get errorBorder => OutlineInputBorder(
  borderSide: BorderSide(
    color: error,
    width: 1.0,
    style: BorderStyle.solid,
  ),
  borderRadius: BorderRadius.circular(10.0),
);

OutlineInputBorder get border => OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
  borderSide: BorderSide(
    width: 1,
    color: black.withOpacity(0.4),
  ),
);
OutlineInputBorder get enableBorder => OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
  borderSide: BorderSide(
    width: 1,
    color: appColor.withOpacity(0.4),
  ),
);