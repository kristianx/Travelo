import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:travelo_mobile/main.dart';
import 'package:travelo_mobile/providers/user_provider.dart';
import 'package:travelo_mobile/widgets/PageHeader.dart';

import '../../model/user.dart';
import '../../utils/util.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late UserProvider _userProvider;
  late User? _user;
  ImageProvider<Object>? userImage;

  Future loadData() async {
    User user =
        await _userProvider.getById(localStorage.getItem("userId") as int);
    setState(() {
      _user = user;
      if (_user!.image.toString() != "") {
        userImage = imageFromBase64String(_user?.image ?? "").image;
      } else {
        userImage = null;
      }
    });
  }

  @override
  void initState() {
    _user = User();
    super.initState();
    _userProvider = context.read<UserProvider>();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        Container(
            height: 400,
            width: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/spain.png"),
                    fit: BoxFit.cover)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PageHeader(
                  pageName: "Profile",
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  height: 110,
                  width: 110,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: const Color(0xffE5F0F5),
                      image: DecorationImage(
                          image: userImage == null
                              ? const AssetImage("assets/images/user-image.png")
                              : userImage!,
                          fit: BoxFit.cover),
                      boxShadow: const [
                        BoxShadow(color: Color(0xffFFE9CC), spreadRadius: 20),
                        BoxShadow(color: Color(0xffffffff), spreadRadius: 7),
                      ]),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "${_user?.firstName ?? ''} ${_user?.lastName ?? ''}",
                  style: const TextStyle(
                      color: Color(0xff454F63),
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
              ],
            )),
        Transform.translate(
          offset: const Offset(0, -80),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (_) => EditProfile(user: _user)));
                  context.goNamed("EditProfile", extra: _user);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    children: [
                      Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xffE5F0F5),
                        ),
                        child: Center(
                            child: SvgPicture.asset(
                          "assets/icons/User.svg",
                          color: const Color(0xff94B4C4),
                          width: 18,
                        )),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Expanded(
                          child: Text(
                        'Edit profile',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff585858),
                        ),
                        softWrap: true,
                      )),
                      SvgPicture.asset("assets/icons/arrow.svg")
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  context.goNamed("ChangePassword", extra: _user);
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (_) => ChangePassword(user: _user)));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    children: [
                      Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xffE6F5F0),
                        ),
                        child: Center(
                            child: SvgPicture.asset(
                          "assets/icons/Password.svg",
                          width: 16,
                          color: const Color(0xff989EA7),
                        )),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Expanded(
                          child: Text(
                        'Change password',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff585858),
                        ),
                        softWrap: true,
                      )),
                      SvgPicture.asset("assets/icons/arrow.svg")
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  _userProvider.logOut();
                  context.go('/welcome');
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    children: [
                      Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xffECF0F6),
                        ),
                        child: Center(
                            child: SvgPicture.asset("assets/icons/logout.svg")),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Expanded(
                          child: Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff585858),
                        ),
                        softWrap: true,
                      )),
                      SvgPicture.asset("assets/icons/arrow.svg")
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    )));
  }
}
