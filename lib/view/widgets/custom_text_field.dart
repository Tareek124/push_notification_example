import 'package:flutter/material.dart';
import 'package:push_notification_example/colors.dart';

class CustomTextFieldOutline extends StatelessWidget {
  const CustomTextFieldOutline(
      {Key? key,
      this.controller,
      this.label,
      required this.maxLines,
      required this.textInputType})
      : super(key: key);

  final TextEditingController? controller;
  final int maxLines;
  final TextInputType textInputType;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
        borderSide: Divider.createBorderSide(context, width: 3, color: purple),
        borderRadius: BorderRadius.circular(25));

    return TextFormField(
      maxLines: maxLines,
      obscureText: false,
      keyboardType: textInputType,
      controller: controller,
      decoration: InputDecoration(
        hintText: label ?? "",
        focusedBorder: inputBorder,
        errorBorder: inputBorder,
        enabledBorder: inputBorder,
        disabledBorder: inputBorder,
        focusedErrorBorder: inputBorder,
      ),
    );
  }
}
