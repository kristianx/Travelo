import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';

class InputField extends StatefulWidget {
  final String hintText;
  final String iconPath;
  final bool obscure;

  const InputField(
      {super.key,
      required this.hintText,
      required this.iconPath,
      this.obscure = false});

  @override
  State<InputField> createState() => _InputFieldState(
      hintText: this.hintText, iconPath: this.iconPath, obscure: this.obscure);
}

class _InputFieldState extends State<InputField> {
  String hintText;
  String iconPath;
  bool obscure;

  _InputFieldState(
      {required this.hintText, required this.iconPath, this.obscure = false});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: Material(
        elevation: 5,
        shadowColor: Colors.grey.shade300,
        borderRadius: const BorderRadius.all(const Radius.circular(15)),
        child: TextField(
            obscureText: obscure,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                // width: 0.0 produces a thin "hairline" border
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide.none,
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 15, 0),
                child: SvgPicture.asset(
                  iconPath,
                  width: 20,
                ),
              ),
              fillColor: Colors.white,
              hintText: hintText,
              filled: true,
            )),
      ),
    );
  }
}
