import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class SimpleButton extends StatelessWidget {
  SimpleButton(
      {super.key,
      required this.bgColor,
      required this.textColor,
      required this.text,
      this.hasShadow = true,
      required this.onTap,
      this.height,
      this.width});

  final Color textColor;
  final Color bgColor;
  final String text;
  final double? width;
  final double? height;
  final VoidCallback onTap;
  bool hasShadow;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        child: Center(
            child: Text(
          text,
          style: TextStyle(
              color: textColor, fontWeight: FontWeight.w600, fontSize: 18),
        )),
        decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 0,
                blurRadius: 10,
                offset: Offset(0, 4),
              )
            ]),
      ),
    );
  }
}
