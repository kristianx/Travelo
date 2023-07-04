import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:travelo_mobile/pages/login.dart';

import '../../main.dart';
import '../../model/user.dart';
import '../../providers/user_provider.dart';
import '../../widgets/InputField.dart';
import '../../widgets/PageHeader.dart';
import '../../widgets/SimpleButton.dart';

class ChangePassword extends StatefulWidget {
  ChangePassword({super.key, required this.user});

  User? user;

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  late UserProvider _userProvider;
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _userProvider = context.read<UserProvider>();
    setState(() {
      // _firstNameController.text = (widget.user!.firstName ?? "");
      // _lastNameController.text = (widget.user!.lastName ?? "");
    });
    loadData();
  }

  Future loadData() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
              height: 200,
              width: double.infinity,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/spain.png"),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.go("/profile");
                          },
                          child: const Icon(
                            Icons.arrow_back_ios_rounded,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          "Change Password",
                          style: TextStyle(
                              color: Color(0xff000000),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        // SvgPicture.asset("assets/icons/Search.svg")
                      ],
                    ),
                  ),
                ],
              )),
          Transform.translate(
            offset: const Offset(0, -100),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  InputField(
                    controller: _oldPasswordController,
                    hintText: "Current password",
                    iconPath: 'assets/icons/Password.svg',
                    obscure: true,
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r'^(?=.*?[!@#\$\-&*~]).{5,}$')
                              .hasMatch(value)) {
                        return 'Password should be longer then 5 characters.\nPassword should contain at least one special character';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  InputField(
                    controller: _newPasswordController,
                    hintText: "New password",
                    iconPath: 'assets/icons/Password.svg',
                    obscure: true,
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r'^(?=.*?[!@#\$\-&*~]).{5,}$')
                              .hasMatch(value)) {
                        return 'Password should be longer then 5 characters.\nPassword should contain at least one special character';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  InputField(
                    controller: _confirmNewPasswordController,
                    hintText: 'Confirm new password',
                    iconPath: 'assets/icons/Password.svg',
                    obscure: true,
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r'^(?=.*?[!@#\$\-&*~]).{5,}$')
                              .hasMatch(value)) {
                        return 'Password should be longer then 5 characters.\nPassword should contain at least one special character';
                      }
                      if (value!.isEmpty ||
                          _confirmNewPasswordController.text !=
                              _newPasswordController.text) {
                        return 'Passwords should match.';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          SimpleButton(
            onTap: () async {
              if (formKey.currentState!.validate() &&
                  _oldPasswordController.text != "" &&
                  _newPasswordController.text != "" &&
                  _confirmNewPasswordController.text != "" &&
                  _newPasswordController.text ==
                      _confirmNewPasswordController.text) {
                if (localStorage.getItem("userId") != null) {
                  User? usr = await _userProvider
                      .update(localStorage.getItem("userId") as int, {
                    "email": localStorage.getItem("email"),
                    "oldPassword": _oldPasswordController.text,
                    "newPassword": _newPasswordController.text,
                    "cityId": widget.user?.cityId
                  });
                  if (usr != null) {
                    setState(() {
                      widget.user = usr;
                      _userProvider.newAuth();
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  }
                }
              }
            },
            bgColor: const Color(0xffEAAD5F),
            textColor: Colors.white,
            text: "Change password",
            width: 300,
            height: 70,
          ),
        ],
      )),
    );
  }
}
