import 'package:flutter/material.dart';
import 'package:push_notification_example/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function()? function;
  const CustomButton({Key? key, required this.text, required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color: purple,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
