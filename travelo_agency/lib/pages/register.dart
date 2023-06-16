import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../models/city.dart';
import '../providers/agency_provider.dart';
import '../providers/city_provider.dart';
import '../widgets/CustomSnackBar.dart';
import '../widgets/InputField.dart';
import '../widgets/SimpleButton.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _postCodeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late CityProvider _cityProvider;
  late AgencyProvider _agencyProvider;
  List<City> cities = [];
  int cityId = -2;
  List<DropdownMenuItem> citiesDropdown = [
    const DropdownMenuItem(
      value: -2,
      enabled: false,
      child: Text("Loading..."),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _cityProvider = context.read<CityProvider>();
    _agencyProvider = context.read<AgencyProvider>();
    loadData();
  }

  Future loadData() async {
    var tmpCities = await _cityProvider.get({"hasTrips": false});
    setState(() {
      cities = tmpCities;
    });
    _updateCitiesDropdown();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 120, 0, 80),
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage("assets/images/Background.png"),
              fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: SvgPicture.asset("assets/images/Logo.svg")),
              ],
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: 500,
              child: Column(children: [
                InputField(
                  controller: _nameController,
                  hintText: 'Name',
                  iconPath: 'assets/icons/User.svg',
                ),
                const SizedBox(height: 15),
                InputField(
                  controller: _emailController,
                  hintText: 'Email',
                  iconPath: 'assets/icons/User.svg',
                ),
                const SizedBox(height: 15),
                InputField(
                  controller: _phoneController,
                  hintText: 'Phone',
                  iconPath: 'assets/icons/Email.svg',
                ),
                const SizedBox(height: 15),
                InputField(
                  controller: _websiteController,
                  hintText: 'Website URL',
                  iconPath: 'assets/icons/User.svg',
                ),
                const SizedBox(height: 15),
                InputField(
                  controller: _aboutController,
                  hintText: 'About',
                  iconPath: 'assets/icons/User.svg',
                ),
                const SizedBox(height: 15),
                InputField(
                  controller: _addressController,
                  hintText: 'Address',
                  iconPath: 'assets/icons/User.svg',
                ),
                const SizedBox(height: 15),
                InputField(
                  controller: _postCodeController,
                  hintText: 'Postal Code',
                  iconPath: 'assets/icons/User.svg',
                ),
                const SizedBox(height: 15),
                InputField(
                  controller: _passwordController,
                  hintText: 'Password',
                  iconPath: 'assets/icons/Password.svg',
                  obscure: true,
                ),
                const SizedBox(height: 15),
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
              ]),
            ),
            const SizedBox(height: 30),
            SimpleButton(
              onTap: () async {
                try {
                  var registerFlag = await _agencyProvider.insert({
                    "name": _nameController.text,
                    "email": _emailController.text,
                    "phone": _phoneController.text,
                    "websiteUrl": _websiteController.text,
                    "about": _aboutController.text,
                    "address": _addressController.text,
                    "postalCode": _postCodeController.text,
                    "password": _passwordController.text,
                    "confirmPassword": _passwordController.text,
                    "cityId": cityId,
                  });

                  if (registerFlag != null) {
                    _agencyProvider.newAuth(
                        _emailController.text, _passwordController.text);
                    context.go('/dashboard');
                    ScaffoldMessenger.of(context).showSnackBar(
                        CustomSnackBar.showSuccessSnackBar(
                            "You have created a new account."));
                  }
                } catch (e) {
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
              text: "Create account",
              width: 300,
              height: 70,
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
      });
    }
  }
}