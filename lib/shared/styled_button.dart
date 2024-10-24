import 'package:flutter/material.dart';
import 'package:messaging_app/shared/theme.dart';

// ignore: must_be_immutable
class StyledButton extends StatelessWidget {

  String text;
  Function onPressed;
  StyledButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.primaryColor,
      ),
      onPressed: () => onPressed,
       child: Text(text.toUpperCase(), style: const TextStyle(color: Colors.white,)));
  }
}