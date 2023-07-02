import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:travelo_mobile/pages/navpages/home_page.dart';
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
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late UserProvider _userProvider;

  Future<void> tryLogin() async {
    await localStorage.ready;
    print(localStorage.getItem("email"));
    print(localStorage.getItem("password"));
    var loginFlag = await _userProvider.loginUser(
      localStorage.getItem("email"),
      localStorage.getItem("password"),
    );
    if (loginFlag && context.mounted) {
      context.go("/home");
      // Navigator.of(context)
      // .push(MaterialPageRoute(builder: (_) => const HomePage()));
    }
  }

  @override
  void initState() {
    super.initState();
    _userProvider = Provider.of<UserProvider>(context, listen: false);
    tryLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(0, 120, 0, 80),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/Background.png"),
                fit: BoxFit.cover),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 100),
          child: Align(
            alignment: Alignment.topLeft,
            child: GestureDetector(
              onTap: () {
                context.go("/welcome");
              },
              child: const Icon(
                Icons.arrow_back_ios_rounded,
              ),
            ),
          ),
        ),
        SafeArea(
          child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: _buildLoginPage()),
        )
      ],
    ));
  }

  List<Widget> _buildLoginPage() {
    return [
      const SizedBox(height: 50),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: SvgPicture.asset("assets/images/Logo.svg")),
        ],
      ),
      const SizedBox(height: 50),
      Column(children: [
        InputField(
          controller: _usernameController,
          hintText: 'Email',
          iconPath: 'assets/icons/Email.svg',
        ),
        const SizedBox(height: 15),
        InputField(
          controller: _passwordController,
          hintText: 'Password',
          iconPath: 'assets/icons/Password.svg',
          obscure: true,
        ),
      ]),
      const SizedBox(height: 50),
      SimpleButton(
        onTap: () async {
          try {
            var loginFlag = await _userProvider.loginUser(
                _usernameController.text, _passwordController.text);
            if (loginFlag) {
              // Navigator.of(context)
              //     .push(MaterialPageRoute(builder: (_) => const HomePage()));
              context.go("/home");
            }
          } catch (e) {
            showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                      title: const Text("Error"),
                      content: Text(e.toString()),
                      actions: [
                        TextButton(
                          child: const Text("Ok"),
                          onPressed: () => Navigator.pop(context),
                        )
                      ],
                    ));
          }
        },
        bgColor: const Color(0xffEAAD5F),
        textColor: Colors.white,
        text: "Log in",
        width: 300,
        height: 70,
      ),
      const SizedBox(height: 20),
    ];
  }
}
