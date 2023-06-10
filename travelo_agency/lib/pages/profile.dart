import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:travelo_agency/models/agency.dart';
import 'package:travelo_agency/models/city.dart';
import 'package:travelo_agency/providers/agency_provider.dart';
import '../main.dart';
import '../providers/city_provider.dart';
import '../utils/util.dart';
import '../widgets/CustomSnackBar.dart';
import '../widgets/InputField.dart';
import '../widgets/SimpleButton.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late File? _file;
  late AgencyProvider _agencyProvider;
  late CityProvider _cityProvider;
  Agency _agency = Agency();
  List<City> cities = [];
  List<DropdownMenuItem> citiesDropdown = [
    const DropdownMenuItem(
      value: -2,
      enabled: false,
      child: Text("Loading..."),
    ),
  ];
  int cityId = -2;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _overviewController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _agencyProvider = context.read<AgencyProvider>();
    _cityProvider = context.read<CityProvider>();
    loadData();
  }

  Future loadData() async {
    var tmpAgency =
        await _agencyProvider.getById(localStorage.getItem('agencyId') as int);
    var tmpCities = await _cityProvider.get();

    setState(() {
      _agency = tmpAgency;
      cities = tmpCities;
      _nameController.text = _agency.name ?? "Name";
      _emailController.text = _agency.email ?? "Email";
      _websiteController.text = _agency.websiteUrl ?? "Website";
      _phoneNumberController.text = _agency.phone ?? "Phone number";
      _overviewController.text = _agency.about ?? "Overview";
      _addressController.text = _agency.address ?? "Address";
      _postalCodeController.text = _agency.postalCode ?? "Postal code";
    });
    _updateCitiesDropdown();
  }

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
                          "Account information",
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
            Container(
                height: 150,
                width: double.infinity,
                // decoration: const BoxDecoration(
                //     image: DecorationImage(
                //         image: AssetImage("assets/images/spain.png"),
                //         fit: BoxFit.cover,
                //         alignment: Alignment.topCenter)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        _file = await pickImage();
                        if (_file != null) {
                          bool flag = await _agencyProvider.uploadImage(
                              localStorage.getItem("agencyId") as int,
                              _file as File);
                          if (flag) {
                            loadData();
                            ScaffoldMessenger.of(context).showSnackBar(
                                CustomSnackBar.showSuccessSnackBar(
                                    "You have changed your image."));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                CustomSnackBar.showErrorSnackBar(
                                    "There was an error changing your image."));
                          }
                        }
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: const Color(0xffE5F0F5),
                            image: DecorationImage(
                                image: _agency.image == ""
                                    ? const AssetImage(
                                        "assets/images/user-image.png")
                                    : imageFromBase64String(_agency.image ?? "")
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
            SizedBox(
              width: 1000,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: InputField(
                          controller: _nameController,
                          hintText: 'Name',
                          iconPath: 'assets/icons/User.svg',
                        ),
                      ),
                      Expanded(
                        child: InputField(
                          controller: _emailController,
                          hintText: 'Email',
                          iconPath: 'assets/icons/User.svg',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InputField(
                          controller: _phoneNumberController,
                          hintText: 'Phone number',
                          iconPath: 'assets/icons/Planet.svg',
                        ),
                      ),
                      Expanded(
                        child: InputField(
                          controller: _websiteController,
                          hintText: 'Website',
                          iconPath: 'assets/icons/Planet.svg',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  InputField(
                    controller: _overviewController,
                    hintText: 'Overview',
                    iconPath: 'assets/icons/Planet.svg',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: SizedBox(
                      width: 1030,
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
                                "Location",
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
                                padding:
                                    const EdgeInsets.fromLTRB(20, 0, 15, 0),
                                child: SvgPicture.asset(
                                  "assets/icons/Planet.svg",
                                  width: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: SizedBox(
                      width: 1030,
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
                                "Security",
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      width: 350,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 0,
                              blurRadius: 5,
                              offset: const Offset(
                                  0, 4), // changes position of shadow
                            ),
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/Password.svg",
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text("**********"),
                              ],
                            ),
                            const Text(
                              "CHANGE",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  color: Color(0xffEAAD5F)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: SimpleButton(
                      onTap: () async {
                        if (localStorage.getItem("agencyId") != null) {
                          Agency? ag = await _agencyProvider
                              .update(localStorage.getItem("agencyId") as int, {
                            "email": _emailController.text,
                            "oldPassword": localStorage.getItem("password"),
                            "name": _nameController.text,
                            "about": _overviewController.text,
                            "phone": _phoneNumberController.text,
                            "websiteUrl": _websiteController.text,
                            "address": _addressController.text,
                            "postalCode": _postalCodeController.text,
                            "cityId": cityId,
                          });
                          if (ag != null) {
                            setState(() {
                              _agency = ag;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                                CustomSnackBar.showSuccessSnackBar(
                                    "You have successfuly updated your profile."));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                CustomSnackBar.showErrorSnackBar(
                                    "Your profile has not been updated."));
                          }
                        }
                      },
                      bgColor: const Color(0xffEAAD5F),
                      textColor: Colors.white,
                      text: "Save",
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

  void _updateCitiesDropdown() {
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
        cityId = _agency.cityId ?? -1;
      });
    }
  }
}
