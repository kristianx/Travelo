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
  final formKey = GlobalKey<FormState>();

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
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 30),
                child: GestureDetector(
                  onTap: () {
                    context.go("/welcome");
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_rounded,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: SvgPicture.asset("assets/images/Logo.svg")),
              ],
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: 500,
              child: Form(
                key: formKey,
                child: Column(children: [
                  InputField(
                    controller: _nameController,
                    hintText: 'Name',
                    iconPath: 'assets/icons/User.svg',
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r'^[A-Z][A-Za-z ]{4,}$').hasMatch(value)) {
                        return 'Agency name should be at least 5 characters long\n Agency name should start with a capital letter';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  InputField(
                    controller: _emailController,
                    hintText: 'Email',
                    iconPath: 'assets/icons/User.svg',
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                        return 'Please use a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  InputField(
                    controller: _phoneController,
                    hintText: 'Phone',
                    iconPath: 'assets/icons/Email.svg',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a phone number.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  InputField(
                    controller: _websiteController,
                    hintText: 'Website URL',
                    iconPath: 'assets/icons/User.svg',
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r"^(https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9]+\.[^\s]{2,}|www\.[a-zA-Z0-9]+\.[^\s]{2,})")
                              .hasMatch(value)) {
                        return 'Please use a valid website URL.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  InputField(
                    controller: _aboutController,
                    hintText: 'About',
                    iconPath: 'assets/icons/User.svg',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter agency description.';
                      }
                      return null;
                    },
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
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r'^(?=.*?[!@#\$\-&*~]).{5,}$')
                              .hasMatch(value)) {
                        return 'Password should be longer then 5 characters.\nPassword should contain at least one special character';
                      }
                      return null;
                    },
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
                ]),
              ),
            ),
            const SizedBox(height: 30),
            SimpleButton(
              onTap: () async {
                if (formKey.currentState!.validate() &&
                    cityId != -1 &&
                    cityId != -2) {
                  try {
                    var registerFlag = await _agencyProvider.register(
                      _nameController.text,
                      _emailController.text,
                      _phoneController.text,
                      _websiteController.text,
                      _aboutController.text,
                      _addressController.text,
                      _postCodeController.text,
                      _passwordController.text,
                      _passwordController.text,
                      cityId,
                    );

                    if (registerFlag != null) {
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
