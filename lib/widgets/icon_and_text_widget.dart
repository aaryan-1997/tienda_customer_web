import 'package:flutter/material.dart';
import 'package:tiendaweb/widgets/big_text.dart';

class IconAndBigTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  final Color textColor;
  final double textSize;
  final double iconSize;
  final double space;
  final FontWeight weight;
  final MainAxisAlignment mainAxisAlignment;
  const IconAndBigTextWidget(
      {Key? key,
      required this.icon,
      required this.text,
      this.textSize = 12,
      this.iconSize = 20,
      this.space = 1,
      this.weight = FontWeight.normal,
      this.mainAxisAlignment = MainAxisAlignment.start,
      this.textColor = const Color(0xFFccc7c5),
      required this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Icon(icon, color: iconColor, size: iconSize),
        SizedBox(width: space),
        BigText(text: text, color: textColor, size: textSize, weight: weight),
      ],
    );
  }
}
