import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:travelo_mobile/pages/welcome.dart';
import 'package:travelo_mobile/providers/user_provider.dart';

import '../../widgets/PageHeader.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  UserProvider? _userProvider;

  @override
  void initState() {
    super.initState();
    _userProvider = context.read<UserProvider>();
  }

  bool set1 = false;
  bool set2 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                  "Settings",
                  style: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                // SvgPicture.asset("assets/icons/Search.svg")
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        children: [
                          Container(
                            width: 15,
                            height: 30,
                            decoration: const BoxDecoration(
                                color: Color(0xffEAAD5F),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10))),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            "Notifications",
                            style: TextStyle(color: Color(0xff8E8E8E)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 7, 20, 7),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Email notifications",
                            style: TextStyle(
                                fontSize: 15,
                                color: Color(0xff797979),
                                fontWeight: FontWeight.w500),
                          ),
                          CupertinoSwitch(
                            value: set1,
                            onChanged: (onChanged) {
                              setState(() {
                                set1 = !set1;
                              });
                            },
                            activeColor: const Color(0xffEAAD5F),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 7, 20, 7),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Push notifications",
                            style: TextStyle(
                                fontSize: 15,
                                color: Color(0xff797979),
                                fontWeight: FontWeight.w500),
                          ),
                          CupertinoSwitch(
                            value: set2,
                            onChanged: (onChanged) {
                              setState(() {
                                set2 = !set2;
                              });
                            },
                            activeColor: const Color(0xffEAAD5F),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Container(
                            width: 15,
                            height: 30,
                            decoration: const BoxDecoration(
                                color: Color(0xffEAAD5F),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10))),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            "Security",
                            style: TextStyle(color: Color(0xff8E8E8E)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 7, 20, 7),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Use FaceID to unlock",
                            style: TextStyle(
                                fontSize: 15,
                                color: Color(0xff797979),
                                fontWeight: FontWeight.w500),
                          ),
                          CupertinoSwitch(
                            value: true,
                            onChanged: (onChanged) {
                              setState(() {});
                            },
                            activeColor: const Color(0xffEAAD5F),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _userProvider!.logOut();
                        // Navigator.pushNamed(context, "/welcome");
                        context.go('/welcome');
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (_) => const WelcomePage()));
                      },
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(25, 7, 20, 7),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Log out from all devices",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xff797979),
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
