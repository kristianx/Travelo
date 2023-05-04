import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelo_mobile/pages/login.dart';
import 'package:travelo_mobile/pages/welcome.dart';

import '../../main.dart';
import '../../model/user.dart';
import '../../providers/user_provider.dart';
import '../../widgets/InputField.dart';
import '../../widgets/PageHeader.dart';
import '../../widgets/SimpleButton.dart';
import '../navpages/profile_page.dart';

class ChangePassword extends StatefulWidget {
  ChangePassword({super.key, required this.user});

  User? user;

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  late UserProvider _userProvider;
  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmNewPasswordController = TextEditingController();

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
    return Scaffold(
      body: SafeArea(
          child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/spain.png"),
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    PageHeader(
                      pageName: "Change password",
                    ),
                  ],
                )),
            Transform.translate(
              offset: Offset(0, -100),
              child: Column(
                children: [
                  InputField(
                    controller: _oldPasswordController,
                    hintText: "Current password",
                    iconPath: 'assets/icons/Password.svg',
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  InputField(
                    controller: _newPasswordController,
                    hintText: "New password",
                    iconPath: 'assets/icons/Password.svg',
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  InputField(
                    controller: _confirmNewPasswordController,
                    hintText: 'Confirm new password',
                    iconPath: 'assets/icons/Password.svg',
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SimpleButton(
              onTap: () async {
                if (_oldPasswordController.text != "" &&
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
              bgColor: Color(0xffEAAD5F),
              textColor: Colors.white,
              text: "Change password",
              width: 300,
              height: 70,
            ),
          ],
        ),
      )),
    );
  }
}
