import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:travelo_agency/models/agency.dart';
import 'package:travelo_agency/providers/agency_provider.dart';
import '../main.dart';
import '../widgets/CustomSnackBar.dart';
import '../widgets/InputField.dart';
import '../widgets/SimpleButton.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  late AgencyProvider _agencyProvider;

  final TextEditingController _oldPassword = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmNewPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    _agencyProvider = context.read<AgencyProvider>();
    loadData();
  }

  Future loadData() async {}

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: SizedBox(
                width: 1000,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Change password",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff747474),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 1000,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InputField(
                    controller: _oldPassword,
                    hintText: 'Old password',
                    iconPath: 'assets/icons/Password.svg',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  InputField(
                    controller: _newPassword,
                    hintText: 'New password',
                    iconPath: 'assets/icons/Password.svg',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  InputField(
                    controller: _confirmNewPassword,
                    hintText: 'Confirm new password',
                    iconPath: 'assets/icons/Password.svg',
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: SimpleButton(
                      onTap: () async {
                        if (localStorage.getItem("agencyId") != null &&
                            _newPassword.text == _confirmNewPassword.text &&
                            _newPassword.text.isNotEmpty &&
                            _oldPassword.text.isNotEmpty &&
                            _confirmNewPassword.text.isNotEmpty) {
                          Agency? ag = await _agencyProvider
                              .update(localStorage.getItem("agencyId") as int, {
                            "email": localStorage.getItem("email"),
                            "oldPassword": _oldPassword.text,
                            "newPassword": _newPassword.text,
                          });
                          if (ag != null) {
                            _agencyProvider.logOut();
                            context.go('/login');
                            ScaffoldMessenger.of(context).showSnackBar(
                                CustomSnackBar.showSuccessSnackBar(
                                    "You have successfuly changed your password."));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                CustomSnackBar.showErrorSnackBar(
                                    "There was an error changing your password."));
                          }
                        }
                      },
                      bgColor: const Color(0xffEAAD5F),
                      textColor: Colors.white,
                      text: "Change password",
                      width: 300,
                      height: 70,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }
}
