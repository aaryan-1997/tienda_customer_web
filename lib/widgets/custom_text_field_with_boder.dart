import 'package:flutter/material.dart';


import '../utils/colors.dart';
import '../utils/dimension.dart';

class CustomTextFieldWithBorder extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final Color iconColor;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final TextAlign inputTextAlign;
  final bool obscureText;
  final bool readOnly;
  final int minLines;
  final int? maxLines;
  final double borderWidth;
  final double borderRadius;
  final TextCapitalization textCapital;
  final void Function(String?)? onSaved;
  final void Function()? onTap;
  // ignore: use_key_in_widget_constructors
  const CustomTextFieldWithBorder(
      {Key? key,
      required this.controller,
      required this.labelText,
      required this.validator,
      this.keyboardType = TextInputType.text,
      this.inputTextAlign = TextAlign.start,
      this.obscureText = false,
      this.readOnly = false,
      this.minLines = 1,
      this.maxLines,
      this.borderWidth = 2.0,
      this.borderRadius = 5.0,
      this.textCapital = TextCapitalization.none,
      this.iconColor = AppColor.grey,
      this.onTap,
      required this.onSaved});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: inputTextAlign,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        contentPadding: EdgeInsets.only(
            top: Dimensions.height5,
            bottom: Dimensions.height5,
            left: Dimensions.width15),
        hintText: labelText,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          borderSide: BorderSide(
            color: Colors.grey,
            width: borderWidth,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          borderSide: BorderSide(
            color: Colors.grey,
            width: borderWidth,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          borderSide: BorderSide(
            color: Colors.grey,
            width: borderWidth,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          borderSide: BorderSide(
            color: Colors.grey,
            width: borderWidth,
          ),
        ),
        errorStyle: TextStyle(
          fontWeight: FontWeight.normal,
          color: AppColor.error,
          fontSize: Dimensions.font12,
        ),
        border: const OutlineInputBorder(),
        hintStyle: TextStyle(
          fontWeight: FontWeight.normal,
          color: Colors.grey,
          fontSize: Dimensions.font12,
        ),
      ),
      controller: controller,
      onSaved: onSaved,
      onTap: onTap,
      keyboardType: keyboardType,
      obscureText: obscureText,
      readOnly: readOnly,
      maxLines: maxLines,
      minLines: minLines,
      validator: validator,
      textCapitalization: textCapital,
    );
  }
}

