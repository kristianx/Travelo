import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../providers/user_provider.dart';
import '../widgets/InputField.dart';
import '../widgets/SimpleButton.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool progress = false;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  late UserProvider _userProvider;
  Future<void> tryLogin() async {
    await localStorage.ready;
    print(localStorage.getItem("email"));
    print(localStorage.getItem("password"));
    var loginFlag = await _userProvider.loginUser(
        localStorage.getItem("email"), localStorage.getItem("password"));
    if (loginFlag && context.mounted) {
      setState(() {
        progress = false;
      });
      context.go("/home");
    } else {
      setState(() {
        progress = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _userProvider = Provider.of<UserProvider>(context, listen: false);
    setState(() {
      progress = true;
    });
    tryLogin();
  }

  @override
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: _buildLoginPage()),
    ));
  }

  List<Widget> _buildLoginPage() {
    if (progress) {
      return [
        const Expanded(
            child: Center(
                child: Text(
          "LOADING...",
          style: TextStyle(
              color: Color(0xffA8A8A8),
              fontWeight: FontWeight.w400,
              fontSize: 18),
        )))
      ];
    } else {
      return [
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
                    context.go("/welcome");
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
            SizedBox(height: 15),
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
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const MainPage()),
                // );
                context.go("/home");
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
      ];
    }
  }
}
