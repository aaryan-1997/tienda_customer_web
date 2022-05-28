import 'package:flutter/material.dart';
import 'package:tiendaweb/utils/dimension.dart';
import 'package:tiendaweb/widgets/big_text.dart';

class IconAndBigTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  final Color textColor;
  final double textSize;
  final double iconSize;
  final FontWeight weight;
  final MainAxisAlignment mainAxisAlignment;
  const IconAndBigTextWidget(
      {Key? key,
      required this.icon,
      required this.text,
      this.textSize = 12,
      this.iconSize = 20,
      this.weight = FontWeight.normal,
      this.mainAxisAlignment = MainAxisAlignment.start,
      this.textColor = const Color(0xFFccc7c5),
      required this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Dimensions().init(context);
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Icon(icon, color: iconColor, size: iconSize),
        const SizedBox(width: 1),
        BigText(text: text, color: textColor, size: textSize, weight: weight),
      ],
    );
  }
}
