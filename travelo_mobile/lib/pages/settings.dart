import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelo_mobile/providers/user_provider.dart';

import '../widgets/PageHeader.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late UserProvider _userProvider;

  @override
  void initState() {
    super.initState();
    _userProvider = context.read<UserProvider>();
  }

  @override
  bool set1 = false;
  bool set2 = false;
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          PageHeader(
            pageName: "Settings",
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
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Row(
                        children: [
                          Container(
                            width: 15,
                            height: 30,
                            decoration: BoxDecoration(
                                color: Color(0xffEAAD5F),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10))),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Notifications",
                            style: TextStyle(color: Color(0xff8E8E8E)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 7, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
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
                            activeColor: Color(0xffEAAD5F),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 7, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
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
                            activeColor: Color(0xffEAAD5F),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Row(
                        children: [
                          Container(
                            width: 15,
                            height: 30,
                            decoration: BoxDecoration(
                                color: Color(0xffEAAD5F),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10))),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Security",
                            style: TextStyle(color: Color(0xff8E8E8E)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 7, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Change password",
                            style: TextStyle(
                                fontSize: 15,
                                color: Color(0xff797979),
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 7, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
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
                            activeColor: Color(0xffEAAD5F),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _userProvider.logOut();
                        Navigator.pushNamed(context, "/welcome");
                      },
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 7, horizontal: 20),
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
    ;
  }
}
