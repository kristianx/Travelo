import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:travelo_mobile/pages/login.dart';
import 'package:travelo_mobile/pages/register.dart';
import 'package:travelo_mobile/widgets/SimpleButton.dart';

import '../providers/user_provider.dart';
import '../widgets/CustomSnackBar.dart';
import 'navpages/main_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});
  void initState() {}
  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late UserProvider _userProvider;
  // void initState() {
  //   super.initState();
  //   _userProvider = Provider.of<UserProvider>(context, listen: false);
  //   if (_userProvider.checkLoginStatus()) {
  //     // Navigator.push(
  //     //   context,
  //     //   MaterialPageRoute(builder: (context) => const MainPage()),
  //     // );
  //     Future.delayed(Duration.zero, () {
  //       Navigator.pushNamed(context, "/");
  //     });
  //   } else {
  //     Future.delayed(Duration.zero, () {
  //       Navigator.pushNamed(context, "/login");
  //     });
  //   }
  // }

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
                  Future.delayed(Duration.zero, () {
                    Navigator.pushNamed(context, "/login");
                  });
                },
                bgColor: Color(0xffEAAD5F),
                textColor: Colors.white,
                text: "Login",
                width: 300,
                height: 70,
              ),
              SizedBox(height: 20),
              SimpleButton(
                onTap: () {
                  Navigator.pushNamed(context, "/register");
                },
                bgColor: Colors.white,
                textColor: Color(0xff747474),
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
