import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:travelo_mobile/main.dart';
import 'package:travelo_mobile/pages/navpages/home_page.dart';
import 'package:travelo_mobile/pages/navpages/main_page.dart';
import 'package:travelo_mobile/pages/register.dart';

import '../providers/user_provider.dart';
import '../utils/util.dart';
import '../widgets/InputField.dart';
import '../widgets/SimpleButton.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  late UserProvider _userProvider;

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context, listen: false);
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                controller: _usernameController,
                hintText: 'Email',
                iconPath: 'assets/icons/Email.svg',
              ),
              InputField(
                controller: _passwordController,
                hintText: 'Password',
                iconPath: 'assets/icons/Password.svg',
                obscure: true,
              ),
            ]),
          ),
          SimpleButton(
            onTap: () async {
              try {
                var loginFlag = await _userProvider.loginUser(
                    _usernameController.text, _passwordController.text);
                if (loginFlag) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MainPage()),
                  );
                }
              } catch (e) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: Text("Error"),
                          content: Text(e.toString()),
                          actions: [
                            TextButton(
                              child: Text("Ok"),
                              onPressed: () => Navigator.pop(context),
                            )
                          ],
                        ));
              }
            },
            bgColor: Color(0xffEAAD5F),
            textColor: Colors.white,
            text: "Log in",
            width: 300,
            height: 70,
          ),
        ],
      ),
    ));
  }
}
