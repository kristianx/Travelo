import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:travelo_mobile/pages/navpages/main_page.dart';
import 'package:travelo_mobile/widgets/SimpleButton.dart';
import '../providers/user_provider.dart';
import '../utils/util.dart';

class RegisterPageStep2 extends StatefulWidget {
  const RegisterPageStep2({super.key});

  @override
  State<RegisterPageStep2> createState() => _RegisterPageStep2State();
}

File? _file;

class _RegisterPageStep2State extends State<RegisterPageStep2> {
  late UserProvider _userProvider;

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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          Center(
            child: GestureDetector(
              onTap: () async {
                //Get image from the gallery
                pickImage();
              },
              child: _file != null
                  ? Container(
                      height: 220,
                      width: 280,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: _file != null
                              ? DecorationImage(
                                  image: Image.file(_file!, fit: BoxFit.cover)
                                      as ImageProvider)
                              : null,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 0,
                              blurRadius: 5,
                              offset: const Offset(0, 4),
                            ),
                          ]),
                    )
                  : Container(
                      height: 220,
                      width: 280,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 0,
                              blurRadius: 5,
                              offset: const Offset(0, 4),
                            ),
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset("assets/icons/dummy_image.svg"),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Choose your image",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff747474)),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
          Column(
            children: [
              SimpleButton(
                onTap: () async {
                  try {} catch (e) {
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
                text: "Save",
                width: 300,
                height: 70,
              ),
              const SizedBox(
                height: 20,
              ),
              SimpleButton(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MainPage()),
                  );
                },
                bgColor: Colors.white,
                textColor: const Color(0xff747474),
                text: "Skip",
                width: 300,
                height: 70,
              ),
            ],
          )
        ],
      ),
    ));
  }
}
