import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:travelo_mobile/main.dart';
import 'package:travelo_mobile/pages/profile/change_password.dart';
import 'package:travelo_mobile/pages/profile/edit_profile.dart';
import 'package:travelo_mobile/pages/payment_settings.dart';
import 'package:travelo_mobile/pages/profile/settings.dart';
import 'package:travelo_mobile/pages/profile/trip_invoices.dart';
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
  User? _user;

  Future loadData() async {
    User user =
        await _userProvider.getById(localStorage.getItem("userId") as int);
    setState(() {
      _user = user;
    });
  }

  @override
  void initState() {
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
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/spain.png"),
                    fit: BoxFit.cover)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PageHeader(
                  pageName: "Profile",
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
                          image: _user!.image == ""
                              ? const AssetImage("assets/images/user-image.png")
                              : imageFromBase64String(_user!.image ?? "").image,
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
                  "${_user!.firstName ?? ''} ${_user!.lastName ?? ''}",
                  style: TextStyle(
                      color: Color(0xff454F63),
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
              ],
            )),
        Transform.translate(
          offset: Offset(0, -80),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditProfile(user: _user)),
                  );
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
                          color: Color(0xffE5F0F5),
                        ),
                        child: Center(
                            child: SvgPicture.asset(
                          "assets/icons/User.svg",
                          color: Color(0xff94B4C4),
                          width: 18,
                        )),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
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
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TripInvoices()),
                  );
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
                          color: Color(0xffFFE5F5),
                        ),
                        child: Center(
                            child:
                                SvgPicture.asset("assets/icons/invoice.svg")),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                          child: Text(
                        'Trip invoices',
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
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PaymentSettings()),
                  );
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
                          color: Color(0xffFFE9CC),
                        ),
                        child: Center(
                            child:
                                SvgPicture.asset("assets/icons/payments.svg")),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                          child: Text(
                        'Payment settings',
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
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChangePassword(user: _user)),
                  );
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
                          color: Color(0xffE6F5F0),
                        ),
                        child: Center(
                            child: SvgPicture.asset(
                          "assets/icons/Password.svg",
                          width: 16,
                          color: Color(0xff989EA7),
                        )),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
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
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Settings()),
                  );
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
                          color: Color(0xffECF0F6),
                        ),
                        child: Center(
                            child:
                                SvgPicture.asset("assets/icons/settings.svg")),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                          child: Text(
                        'Settings',
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
