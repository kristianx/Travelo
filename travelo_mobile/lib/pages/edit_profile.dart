import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:travelo_mobile/pages/navpages/profile_page.dart';

import '../widgets/InputField.dart';
import '../widgets/PageHeader.dart';
import '../widgets/SimpleButton.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController _dummyController = TextEditingController();

  @override
  var _value = "-1";
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/spain.png"),
                      fit: BoxFit.cover)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  PageHeader(
                    pageName: "Edit profile",
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    height: 110,
                    width: 110,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Color(0xffE5F0F5),
                        image: DecorationImage(
                            image: AssetImage("assets/images/userimage.png"),
                            fit: BoxFit.cover),
                        boxShadow: [
                          BoxShadow(color: Color(0xffFFE9CC), spreadRadius: 20),
                          BoxShadow(color: Color(0xffffffff), spreadRadius: 7),
                        ]),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Marco Jacobs",
                    style: TextStyle(
                        color: Color(0xff454F63),
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                ],
              )),
          InputField(
            controller: _dummyController,
            hintText: 'Full name',
            iconPath: 'assets/icons/User.svg',
          ),
          SizedBox(
            height: 15,
          ),
          InputField(
            controller: _dummyController,
            hintText: 'Email',
            iconPath: 'assets/icons/Email.svg',
          ),
          SizedBox(
            height: 15,
          ),
          InputField(
            controller: _dummyController,
            hintText: 'Password',
            iconPath: 'assets/icons/Password.svg',
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                height: 60,
                alignment: Alignment.center,
                child: Material(
                  elevation: 3,
                  shadowColor: Colors.grey.shade300,
                  borderRadius:
                      const BorderRadius.all(const Radius.circular(20)),
                  child: DropdownButtonFormField(
                    value: _value,
                    items: [
                      DropdownMenuItem(child: Text("Text"), value: "-1"),
                      DropdownMenuItem(child: Text("Something"), value: "1"),
                      DropdownMenuItem(child: Text("Else"), value: "2"),
                      DropdownMenuItem(child: Text("naa"), value: "3"),
                    ],
                    onChanged: (v) {},
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        // width: 0.0 produces a thin "hairline" border
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
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
          SizedBox(
            height: 30,
          ),
          SimpleButton(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
            bgColor: Color(0xffEAAD5F),
            textColor: Colors.white,
            text: "Save",
            width: 300,
            height: 70,
          )
        ],
      )),
    );
  }
}
