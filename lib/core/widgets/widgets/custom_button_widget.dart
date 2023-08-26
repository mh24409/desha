import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double buttonWidth;
  final double buttonHeight;
  final double buttonMargin;
  final double buttonTextFontSize;
  final String buttonText;
  final FontWeight buttonFontWight;
  final double buttonBorderRadius;
  final VoidCallback buttonAction;
  final Color buttonColor;

  const CustomButton({
    super.key,
    required this.buttonWidth,
    required this.buttonHeight,
    required this.buttonMargin,
    required this.buttonTextFontSize,
    required this.buttonText,
    this.buttonFontWight = FontWeight.w400,
    required this.buttonAction,
    this.buttonBorderRadius = 30,
    required this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonAction,
      child: Container(
        width: buttonWidth,
        margin: EdgeInsets.all(buttonMargin),
        height: buttonHeight,
        decoration: BoxDecoration(
          color: buttonColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(buttonBorderRadius),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              color: Colors.white,
              fontSize: buttonTextFontSize,
              fontWeight: buttonFontWight,
            ),
          ),
        ),
      ),
    );
  }
}
