import 'package:flutter/material.dart';

import '../../Constants/ui_constants.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  final double height;
  final bool isFilled;
  final IconData prefixIconData;
  final Color iconColor;
  final Color filledColor;
  final String hintText;
  String? initValue;
  int? maxLines;
  final bool isEnable;
  final Color focusesBorderColor;
  final Color enableBorderColor;
  final double borderRadius;
  final bool obscureText;
  final Function(String)? onChange;
  final TextInputType keyboardType;
  final AutovalidateMode autovalidateMode;
  String? Function(String?)? validate;
  TextEditingController? controller;

  CustomTextField(
      {super.key,
      this.initValue,
      this.maxLines = 1,
      required this.prefixIconData,
      this.iconColor =  Colors.grey,
      required this.hintText,
      this.onChange,
      this.height = 15,
      this.isFilled = true,
      this.focusesBorderColor = UiConstant.kCosmoCareCustomColors1,
      this.enableBorderColor = UiConstant.kCosmoCareCustomColors1,
      this.borderRadius = 10,
      this.obscureText = false,
      this.filledColor = Colors.white70,
      this.keyboardType = TextInputType.emailAddress,
      this.validate,
      this.autovalidateMode = AutovalidateMode.disabled,
      this.isEnable = true,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: const Color(0xff1B2357),
      maxLines: maxLines,
      enabled: isEnable,
      initialValue: initValue,
      autovalidateMode: autovalidateMode,
      keyboardType: keyboardType,
      obscureText: obscureText,
      onChanged: onChange,
      validator: validate,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(height),
        hintText: hintText,
        fillColor: filledColor,
        filled: isFilled,
        prefixIcon: Icon(
          prefixIconData,
          color: iconColor,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide:  BorderSide(
            color: enableBorderColor,
            style: BorderStyle.solid,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide:  BorderSide(
            color: focusesBorderColor,
            style: BorderStyle.solid,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide:  BorderSide(
            color: enableBorderColor,
            style: BorderStyle.solid,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(
            color: Colors.red,
            style: BorderStyle.solid,
          ),
        ),
      ),
    );
  }
}
