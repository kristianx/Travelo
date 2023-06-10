import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class InputField extends StatefulWidget {
  final String hintText;
  final String? iconPath;
  final bool obscure;
  final TextEditingController controller;
  final int height;
  const InputField(
      {super.key,
      required this.hintText,
      this.iconPath,
      required this.controller,
      this.height = -1,
      this.obscure = false});

  @override
  // ignore: no_logic_in_create_state
  State<InputField> createState() => _InputFieldState(
      hintText: hintText,
      iconPath: iconPath,
      obscure: obscure,
      controller: controller);
}

class _InputFieldState extends State<InputField> {
  String hintText;
  String? iconPath;
  bool obscure;
  TextEditingController controller;

  _InputFieldState(
      {required this.hintText,
      required this.iconPath,
      this.obscure = false,
      required this.controller});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 5,
              offset: const Offset(0, 4), // changes position of shadow
            ),
          ]),
          child: TextField(
              maxLines: 1,
              obscureText: obscure,
              textAlignVertical: TextAlignVertical.center,
              controller: controller,
              decoration: InputDecoration(
                hoverColor: Colors.white54,
                filled: true,
                hintText: hintText,
                fillColor: Colors.white,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 15, 0),
                  child: SvgPicture.asset(
                    iconPath ?? "",
                    width: 20,
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
