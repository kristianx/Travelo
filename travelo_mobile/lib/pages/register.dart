import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:travelo_mobile/widgets/InputField.dart';
import 'package:travelo_mobile/widgets/SimpleButton.dart';

import '../providers/user_provider.dart';
// import 'navpages/home_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late UserProvider _userProvider;
  var cityId = "-1";

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context, listen: false);
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
                      context.go('/welcome');
                    },
                    child: const Icon(
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
          const SizedBox(height: 50),
          Expanded(
            flex: 1,
            child: Column(children: [
              InputField(
                controller: _firstNameController,
                hintText: 'First name',
                iconPath: 'assets/icons/User.svg',
              ),
              InputField(
                controller: _lastNameController,
                hintText: 'Lase name',
                iconPath: 'assets/icons/User.svg',
              ),
              InputField(
                controller: _emailController,
                hintText: 'Email',
                iconPath: 'assets/icons/Email.svg',
              ),
              InputField(
                controller: _userNameController,
                hintText: 'Username',
                iconPath: 'assets/icons/User.svg',
              ),
              InputField(
                controller: _passwordController,
                hintText: 'Password',
                iconPath: 'assets/icons/Password.svg',
                obscure: true,
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  child: Container(
                    height: 60,
                    alignment: Alignment.center,
                    child: Material(
                      elevation: 5,
                      shadowColor: Colors.grey.shade300,
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      child: DropdownButtonFormField(
                        value: cityId,
                        items: const [
                          DropdownMenuItem(value: "-1", child: Text("Text")),
                          DropdownMenuItem(
                              value: "1",
                              child: Text("Bosnia and Herzegovina")),
                          DropdownMenuItem(value: "2", child: Text("Croatia")),
                        ],
                        onChanged: (v) {
                          cityId = v.toString();
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: const OutlineInputBorder(
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
            onTap: () async {
              try {
                var registerFlag = await _userProvider.registerUser(
                    _firstNameController.text,
                    _lastNameController.text,
                    _emailController.text,
                    _passwordController.text,
                    _userNameController.text,
                    cityId);

                if (registerFlag) {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const HomePage()),
                  // );
                  context.go('/home');
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
            text: "Create account",
            width: 300,
            height: 70,
          ),
        ],
      ),
    ));
  }
}
