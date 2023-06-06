import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:travelo_mobile/widgets/SimpleButton.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.fromLTRB(0, 120, 0, 80),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/Background.png"),
            fit: BoxFit.cover),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: SvgPicture.asset("assets/images/Logo.svg")),
            ],
          ),
          Column(
            children: [
              SimpleButton(
                onTap: () {
                  Future.delayed(Duration.zero, () async {
                    // var authenticate = await LocalAuth.authenticate();
                    // if (authenticate) {
                    //   context.go("/login");
                    // }
                    context.go("/login");
                  });
                },
                bgColor: const Color(0xffEAAD5F),
                textColor: Colors.white,
                text: "Login",
                width: 300,
                height: 70,
              ),
              const SizedBox(height: 20),
              SimpleButton(
                onTap: () {
                  // Navigator.pushNamed(context, "/register");

                  context.go("/register");
                },
                bgColor: Colors.white,
                textColor: const Color(0xff747474),
                text: "Register",
                width: 300,
                height: 70,
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
