import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../providers/agency_provider.dart';
import '../widgets/InputField.dart';
import '../widgets/SimpleButton.dart';

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
  var cityId = "-1";

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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: SvgPicture.asset("assets/images/Logo.svg")),
            ],
          ),
          const SizedBox(height: 50),
          Expanded(
            flex: 1,
            child: SizedBox(
              width: 500,
              child: Column(children: [
                InputField(
                  controller: _firstNameController,
                  hintText: 'First name',
                  iconPath: 'assets/icons/User.svg',
                ),
                const SizedBox(height: 15),
                InputField(
                  controller: _lastNameController,
                  hintText: 'Lase name',
                  iconPath: 'assets/icons/User.svg',
                ),
                const SizedBox(height: 15),
                InputField(
                  controller: _emailController,
                  hintText: 'Email',
                  iconPath: 'assets/icons/Email.svg',
                ),
                const SizedBox(height: 15),
                InputField(
                  controller: _userNameController,
                  hintText: 'Username',
                  iconPath: 'assets/icons/User.svg',
                ),
                const SizedBox(height: 15),
                InputField(
                  controller: _passwordController,
                  hintText: 'Password',
                  iconPath: 'assets/icons/Password.svg',
                  obscure: true,
                ),
                const SizedBox(height: 15),
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                    child: Container(
                      height: 53,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 0,
                          blurRadius: 5,
                          offset:
                              const Offset(0, 4), // changes position of shadow
                        ),
                      ]),
                      child: Material(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        child: DropdownButtonFormField(
                          value: cityId,
                          items: const [
                            DropdownMenuItem(
                                value: "-1", child: Text("Choose city")),
                            DropdownMenuItem(
                                value: "1",
                                child: Text("Bosnia and Herzegovina")),
                            DropdownMenuItem(
                                value: "2", child: Text("Croatia")),
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
          ),
          SimpleButton(
            onTap: () async {
              // try {
              //   var registerFlag = await _userProvider.registerUser(
              //       _firstNameController.text,
              //       _lastNameController.text,
              //       _emailController.text,
              //       _passwordController.text,
              //       _userNameController.text,
              //       cityId);

              //   if (registerFlag) {
              //     // Navigator.push(
              //     //   context,
              //     //   MaterialPageRoute(builder: (context) => const HomePage()),
              //     // );
              //     context.go('/home');
              //   }
              // } catch (e) {
              //   showDialog(
              //       context: context,
              //       builder: (BuildContext context) => AlertDialog(
              //             title: const Text("Error"),
              //             content: Text(e.toString()),
              //             actions: [
              //               TextButton(
              //                 child: const Text("Ok"),
              //                 onPressed: () => Navigator.pop(context),
              //               )
              //             ],
              //           ));
              // }
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
