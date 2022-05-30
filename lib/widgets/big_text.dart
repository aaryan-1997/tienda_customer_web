import 'package:flutter/material.dart';
import 'package:tiendaweb/utils/dimension.dart';

class BigText extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final int maxline;
  final TextDecoration textDecoration;
  final TextAlign textAlign;
  final TextOverflow overFlow;
  final FontWeight weight;
  const BigText(
      {Key? key,
      this.color = const Color(0xFF332d2b),
      required this.text,
      this.size = 0,
      this.textDecoration = TextDecoration.none,
      this.maxline = 1,
      this.weight = FontWeight.normal,
      this.textAlign = TextAlign.start,
      this.overFlow = TextOverflow.ellipsis})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxline,
      textAlign: textAlign,
      style: TextStyle(
        decoration: textDecoration,
        color: color,
        fontSize: size == 0 ? Dimensions.font20 : size,
        fontFamily: 'Roboto',
        fontWeight: weight,
      ),
      overflow: overFlow,
    );
  }
}
