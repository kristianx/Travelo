import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:travelo_mobile/main.dart';
import 'package:travelo_mobile/pages/navpages/profile_page.dart';

import '../../model/destination.dart';
import '../../model/user.dart';
import '../../providers/destination_provider.dart';
import '../../providers/user_provider.dart';
import '../../utils/util.dart';
import '../../widgets/CustomSnackBar.dart';
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
  final formKey = GlobalKey<FormState>();
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
                            "Edit profile",
                            style: TextStyle(
                                color: Color(0xff000000),
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          // SvgPicture.asset("assets/icons/Search.svg")
                        ],
                      ),
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
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => const ProfilePage()),
                          // );
                          context.go("/profile");
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
            Form(
              key: formKey,
              child: Column(children: [
                InputField(
                  controller: _firstNameController,
                  hintText: widget.user!.firstName ?? 'First name',
                  iconPath: 'assets/icons/User.svg',
                  validator: (value) {
                    if (value!.isEmpty ||
                        !RegExp(r'^[A-Z][A-Za-z]{4,}$').hasMatch(value)) {
                      return 'First name should be at least 5 characters long\n and start with a capital letter';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                InputField(
                  controller: _lastNameController,
                  hintText: widget.user!.lastName ?? 'Last name',
                  iconPath: 'assets/icons/User.svg',
                  validator: (value) {
                    if (value!.isEmpty ||
                        !RegExp(r'^[A-Z][A-Za-z]{4,}$').hasMatch(value)) {
                      return 'Last name should be at least 5 characters long\n and start with a capital letter';
                    }
                    return null;
                  },
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
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
                SimpleButton(
                  onTap: () async {
                    if (localStorage.getItem("userId") != null &&
                        cityId != null &&
                        cityId != -1 &&
                        cityId != -2 &&
                        formKey.currentState!.validate()) {
                      User? usr = await _userProvider
                          .update(localStorage.getItem("userId") as int, {
                        "email": localStorage.getItem("email"),
                        "oldPassword": localStorage.getItem("password"),
                        "firstName": _firstNameController.text,
                        "lastName": _lastNameController.text,
                        "address": _addressController.text,
                        "postalCode": _postalCodeController.text,
                        "cityId": cityId,
                      });
                      if (usr != null) {
                        setState(() {
                          widget.user = usr;
                        });
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => const ProfilePage()),
                        // );
                        context.go("/profile");
                        // Navigator.of(context).push(
                        //     MaterialPageRoute(builder: (_) => const ProfilePage()));
                        ScaffoldMessenger.of(context).showSnackBar(
                            CustomSnackBar.showSuccessSnackBar(
                                "Profile information updated."));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            CustomSnackBar.showErrorSnackBar(
                                "Please check the details."));
                      }
                    }
                  },
                  bgColor: const Color(0xffEAAD5F),
                  textColor: Colors.white,
                  text: "Save",
                  width: 300,
                  height: 70,
                ),
              ]),
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
