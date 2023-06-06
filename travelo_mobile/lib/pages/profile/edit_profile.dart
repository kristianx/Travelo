import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:travelo_mobile/main.dart';
import 'package:travelo_mobile/pages/navpages/profile_page.dart';

import '../../model/destination.dart';
import '../../model/user.dart';
import '../../providers/destination_provider.dart';
import '../../providers/user_provider.dart';
import '../../utils/util.dart';
import '../../widgets/InputField.dart';
import '../../widgets/PageHeader.dart';
import '../../widgets/SimpleButton.dart';

class EditProfile extends StatefulWidget {
  EditProfile({super.key, required this.user});

  User? user;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late File? _file;

  late UserProvider _userProvider;
  List<Destination> cities = [];
  List<DropdownMenuItem> citiesDropdown = [
    const DropdownMenuItem(
      value: -2,
      enabled: false,
      child: Text("Loading..."),
    ),
  ];
  int cityId = -2;

  late DestinationProvider _destinationProvider;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _destinationProvider = context.read<DestinationProvider>();
    _userProvider = context.read<UserProvider>();
    setState(() {
      _firstNameController.text = (widget.user!.firstName ?? "");
      _lastNameController.text = (widget.user!.lastName ?? "");
      _addressController.text = (widget.user!.address ?? "");
      _postalCodeController.text = (widget.user!.postalCode ?? "");
      // cityId = widget.user!.cityId ?? -1;
    });
    loadData();
  }

  Future loadData() async {
    var tmpCities = await _destinationProvider.get({"hasTrips": false});
    setState(() {
      cities = tmpCities;
      _updateCitiesDropdown();
    });
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
                height: 175,
                width: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/spain.png"),
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const PageHeader(
                      pageName: "Edit profile",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        _file = await pickImage();
                        if (_file != null) {
                          User tmpUser = await _userProvider.uploadImage(
                              localStorage.getItem("userId") as int,
                              _file as File);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ProfilePage()),
                          );
                          setState(() {
                            widget.user = tmpUser;
                          });
                        }
                      },
                      child: Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: const Color(0xffE5F0F5),
                            image: DecorationImage(
                                image: widget.user!.image == ""
                                    ? const AssetImage(
                                        "assets/images/user-image.png")
                                    : imageFromBase64String(
                                            widget.user!.image ?? "")
                                        .image,
                                fit: BoxFit.cover),
                            boxShadow: const [
                              BoxShadow(
                                  color: Color(0xffFFE9CC), spreadRadius: 20),
                              BoxShadow(
                                  color: Color(0xffffffff), spreadRadius: 7),
                            ]),
                      ),
                    ),
                  ],
                )),
            InputField(
              controller: _firstNameController,
              hintText: widget.user!.firstName ?? 'First name',
              iconPath: 'assets/icons/User.svg',
            ),
            const SizedBox(
              height: 15,
            ),
            InputField(
              controller: _lastNameController,
              hintText: widget.user!.lastName ?? 'Last name',
              iconPath: 'assets/icons/User.svg',
            ),
            const SizedBox(
              height: 15,
            ),

            InputField(
              controller: _addressController,
              hintText: 'Address',
              iconPath: 'assets/icons/Planet.svg',
            ),
            const SizedBox(
              height: 15,
            ),
            InputField(
              controller: _postalCodeController,
              hintText: 'Postal code',
              iconPath: 'assets/icons/Planet.svg',
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  height: 60,
                  alignment: Alignment.center,
                  child: Material(
                    elevation: 3,
                    shadowColor: Colors.grey.shade300,
                    borderRadius:
                        const BorderRadius.all(Radius.circular(20)),
                    child: DropdownButtonFormField(
                      value: cityId,
                      items: citiesDropdown,
                      onChanged: (v) {
                        cityId = v;
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: const OutlineInputBorder(
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
            const SizedBox(
              height: 30,
            ),
            // InputField(
            //   controller: _dummyController,
            //   hintText: 'Email',
            //   iconPath: 'assets/icons/Email.svg',
            // ),
            // SizedBox(
            //   height: 15,
            // ),
            // InputField(
            //   controller: _dummyController,
            //   hintText: 'Password',
            //   iconPath: 'assets/icons/Password.svg',
            // ),
            // SizedBox(
            //   height: 15,
            // ),
            SimpleButton(
              onTap: () async {
                print(localStorage.getItem("userId"));
                if (localStorage.getItem("userId") != null) {
                  User? usr = await _userProvider
                      .update(localStorage.getItem("userId") as int, {
                    "email": localStorage.getItem("email"),
                    "oldPassword": localStorage.getItem("password"),
                    "firstName": _firstNameController.text,
                    "lastName": _lastNameController.text,
                    "address": _addressController.text,
                    "postalCode": _postalCodeController.text,
                    "cityId": cityId
                  });
                  if (usr != null) {
                    setState(() {
                      widget.user = usr;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfilePage()),
                    );
                  }
                }
              },
              bgColor: const Color(0xffEAAD5F),
              textColor: Colors.white,
              text: "Save",
              width: 300,
              height: 70,
            ),
          ],
        ),
      )),
    );
  }

  void _updateCitiesDropdown() {
    // if (cityId == -2) {
    //   list.add(DropdownMenuItem(
    //     child: Text("Loading..."),
    //     value: -2,
    //     enabled: false,
    //   ));
    //   return list;
    // }

    if (cities.isNotEmpty) {
      List<DropdownMenuItem> list = [];
      list.add(const DropdownMenuItem(
        value: -2,
        enabled: false,
        child: Text(
          "Choose city",
          style: TextStyle(color: Color(0xff999999)),
        ),
      ));
      list += cities
          .map((e) {
            return DropdownMenuItem(
              value: e.id,
              child: Text(e.name ?? ""),
            );
          })
          .cast<DropdownMenuItem>()
          .toList();
      setState(() {
        citiesDropdown = list;
        cityId = widget.user!.cityId ?? -1;
      });
    }
  }
}
