import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EditProfileCustomFiled extends StatelessWidget {
  String labelName;
  String hintText;
  bool obscureText;
  bool enabled;
  String initValue;
  String? Function(String?)? validator;
  void Function(String)? onChange;
  void Function()? onTap;

  EditProfileCustomFiled({
    super.key,
    required this.hintText,
    required this.labelName,
    required this.obscureText,
    required this.validator,
    required this.onChange,
    this.enabled = true,
    this.initValue = '',
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          validator: validator,
          enabled: enabled,
          initialValue: initValue,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: onChange,
          obscureText: obscureText,
          cursorColor: Theme.of(context).primaryColor,
          decoration: InputDecoration(
            label:
                Text(labelName, style: Theme.of(context).textTheme.labelLarge),
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.labelSmall,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
              ),
            ),
          ),
          onTap: onTap,
        ),
      ],
    );
  }
}
