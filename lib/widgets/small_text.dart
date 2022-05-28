import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final double height;
  final int maxLine;
  final TextOverflow overFlow;
  final TextDecoration textDecoration;
  const SmallText({
    Key? key,
    this.color = const Color(0xFFccc7c5),
    required this.text,
    this.size = 12,
    this.maxLine = 1,
    this.height = 1.2,
    this.textDecoration = TextDecoration.none,
    this.overFlow = TextOverflow.ellipsis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLine,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontFamily: 'Roboto',
        height: height,
        decoration: textDecoration,
      ),
      overflow: overFlow,
    );
  }
}
