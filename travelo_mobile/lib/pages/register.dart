import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:travelo_mobile/pages/login.dart';
import 'package:travelo_mobile/widgets/InputField.dart';
import 'package:travelo_mobile/widgets/SimpleButton.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  var _value = "-1";
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.fromLTRB(0, 120, 0, 80),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/Background.png"),
            fit: BoxFit.cover),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                ),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                    ),
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: SvgPicture.asset("assets/images/Logo.svg")),
            ],
          ),
          SizedBox(height: 50),
          Expanded(
            flex: 1,
            child: Column(children: [
              InputField(
                hintText: 'Full name',
                iconPath: 'assets/icons/User.svg',
              ),
              InputField(
                hintText: 'Email',
                iconPath: 'assets/icons/Email.svg',
              ),
              InputField(
                hintText: 'Password',
                iconPath: 'assets/icons/Password.svg',
                obscure: true,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  child: Container(
                    height: 60,
                    alignment: Alignment.center,
                    child: Material(
                      elevation: 5,
                      shadowColor: Colors.grey.shade300,
                      borderRadius:
                          const BorderRadius.all(const Radius.circular(15)),
                      child: DropdownButtonFormField(
                        value: _value,
                        items: [
                          DropdownMenuItem(child: Text("Text"), value: "-1"),
                          DropdownMenuItem(
                              child: Text("Something"), value: "1"),
                          DropdownMenuItem(child: Text("Else"), value: "2"),
                          DropdownMenuItem(child: Text("naa"), value: "3"),
                        ],
                        onChanged: (v) {},
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            // width: 0.0 produces a thin "hairline" border
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 15, 0),
                            child: SvgPicture.asset(
                              "assets/icons/Planet.svg",
                              width: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )),
            ]),
          ),
          SimpleButton(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
            bgColor: Color(0xffEAAD5F),
            textColor: Colors.white,
            text: "Create account",
            width: 300,
            height: 70,
          ),
        ],
      ),
    ));
  }
}
