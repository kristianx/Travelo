import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:travelo_agency/main.dart';

import '../models/accomodation.dart';
import '../models/city.dart';
import '../models/trip.dart';
import '../models/tripItem.dart';
import '../providers/accomodation_provider.dart';
import '../providers/city_provider.dart';
import '../providers/tripItemProvider.dart';
import '../providers/trip_provider.dart';
import '../utils/util.dart';
import '../widgets/CustomSnackBar.dart';
import '../widgets/DatePicker.dart';
import '../widgets/InputField.dart';
import '../widgets/SimpleButton.dart';

class NewOfferPage extends StatefulWidget {
  const NewOfferPage({super.key});

  @override
  State<NewOfferPage> createState() => _NewOfferPageState();
}

class _NewOfferPageState extends State<NewOfferPage> {
  final TextEditingController _accomodationNameController =
      TextEditingController();
  final TextEditingController _accomodationDescription =
      TextEditingController();
  final TextEditingController _accomodationLocation = TextEditingController();
  final TextEditingController _accomodationAddressController =
      TextEditingController();
  final TextEditingController _accomodationPostalCodeController =
      TextEditingController();
  final TextEditingController _nightsStayController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final DateRangePickerController _datePickerController =
      DateRangePickerController();

  late CityProvider _cityProvider;
  late AccomodationProvider _accomodationProvider;
  late TripItemProvider _tripItemProvider;
  late TripProvider _tripProvider;
  File? _file;
  List<City> cities = [];
  int cityId = -2;
  List<TripItem> tripItems = [];
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
    _accomodationProvider = context.read<AccomodationProvider>();
    _tripItemProvider = context.read<TripItemProvider>();
    _tripProvider = context.read<TripProvider>();
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
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
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
                          "Accomodation information",
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
            SizedBox(
              width: 1000,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () async {
                      final tmp = await pickImage();
                      setState(() {
                        _file = tmp;
                      });
                    },
                    child: Center(
                      child: Container(
                        height: 400,
                        width: 600,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image: _file == null
                                    ? const AssetImage(
                                        'assets/images/imageHolder.png')
                                    : FileImage(_file!) as ImageProvider,
                                fit: BoxFit.cover,
                                alignment: Alignment.center)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  InputField(
                    controller: _accomodationNameController,
                    hintText: 'Accomodation Name',
                    iconPath: 'assets/icons/Planet.svg',
                  ),
                  const SizedBox(height: 15),
                  InputField(
                    controller: _accomodationDescription,
                    hintText: 'Accomodation Description',
                    iconPath: 'assets/icons/Planet.svg',
                  ),
                  const SizedBox(height: 15),
                  InputField(
                    controller: _accomodationLocation,
                    hintText: 'Accomodation Location',
                    iconPath: 'assets/icons/Planet.svg',
                  ),
                  const SizedBox(height: 15),
                  InputField(
                    controller: _accomodationAddressController,
                    hintText: 'Accomodation Address',
                    iconPath: 'assets/icons/Planet.svg',
                  ),
                  const SizedBox(height: 15),
                  InputField(
                    controller: _accomodationPostalCodeController,
                    hintText: 'Accomodation Postal Code',
                    iconPath: 'assets/icons/Planet.svg',
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
                  const SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: SimpleButton(
                      onTap: () async {
                        Accomodation? acc = await _accomodationProvider
                            .insert(<String, dynamic>{
                          'name': _accomodationNameController.text,
                          'description': _accomodationDescription.text,
                          'locationMap': _accomodationLocation.text,
                          'address': _accomodationAddressController.text,
                          'postalCode': _accomodationPostalCodeController.text,
                          'cityId': cityId,
                          "images": _file != null
                              ? base64Encode(_file!.readAsBytesSync())
                              : null,
                        });

                        if (acc != null) {
                          Trip? trip = await _tripProvider.insert({
                            "agencyId": localStorage.getItem('agencyId'),
                            "accommodationId": acc.id
                          });
                          if (trip != null) {
                            context.go(
                              '/offers',
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                                CustomSnackBar.showSuccessSnackBar(
                                    "You have successfuly created a new trip."));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              CustomSnackBar.showErrorSnackBar(
                                  "There was an error creating trip."));
                        }
                      },
                      bgColor: const Color(0xffEAAD5F),
                      textColor: Colors.white,
                      text: "Create",
                      width: 300,
                      height: 70,
                    ),
                  ),
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 15),
            //   child: SizedBox(
            //     width: 1000,
            //     child: Container(
            //       decoration: BoxDecoration(
            //         border: Border(
            //           bottom: BorderSide(
            //             color: Colors.grey.withOpacity(0.2),
            //             width: 1,
            //           ),
            //         ),
            //       ),
            //       child: const Padding(
            //         padding: EdgeInsets.all(30),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.start,
            //           children: [
            //             Text(
            //               "Trip Items",
            //               style: TextStyle(
            //                 fontSize: 25,
            //                 fontWeight: FontWeight.w500,
            //                 color: Color(0xff747474),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   width: 1000,
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Column(
            //         children: _buildTripItems(),
            //       ),
            //     ],
            //   ),
            // ),
            // const SizedBox(
            //   height: 40,
            // ),
            // GestureDetector(
            //   onTap: () {
            //     _nightsStayController.text = '';
            //     _priceController.text = '';
            //     showDialog(
            //         context: context,
            //         builder: (context) => Dialog(
            //               insetPadding: EdgeInsets.symmetric(
            //                   vertical: 50, horizontal: 30),
            //               child: Container(
            //                 width: 1000,
            //                 decoration: BoxDecoration(
            //                     color: Colors.white,
            //                     borderRadius: BorderRadius.circular(10),
            //                     boxShadow: [
            //                       BoxShadow(
            //                         color: Colors.grey.withOpacity(0.2),
            //                         spreadRadius: 0,
            //                         blurRadius: 5,
            //                         offset: const Offset(
            //                             0, 4), // changeon of shadow
            //                       )
            //                     ]),
            //                 child: Padding(
            //                   padding: const EdgeInsets.symmetric(
            //                       horizontal: 50, vertical: 50),
            //                   child: Column(
            //                     mainAxisAlignment: MainAxisAlignment.center,
            //                     crossAxisAlignment: CrossAxisAlignment.center,
            //                     children: [
            //                       Text(
            //                         'Add Trip Item',
            //                         style: TextStyle(
            //                             fontSize: 25,
            //                             fontWeight: FontWeight.w500),
            //                       ),
            //                       const SizedBox(height: 60),
            //                       Row(
            //                         mainAxisAlignment:
            //                             MainAxisAlignment.spaceBetween,
            //                         crossAxisAlignment:
            //                             CrossAxisAlignment.center,
            //                         children: [
            //                           Expanded(
            //                               child: CustomDatePicker(
            //                                   controller:
            //                                       _datePickerController)),
            //                           const SizedBox(width: 20),
            //                           SizedBox(
            //                             width: 250,
            //                             child: InputField(
            //                               controller: _nightsStayController,
            //                               hintText: 'Nights stay',
            //                               iconPath: 'assets/icons/night.svg',
            //                             ),
            //                           ),
            //                           SizedBox(
            //                             width: 250,
            //                             child: InputField(
            //                               controller: _priceController,
            //                               hintText: 'Price per person',
            //                               iconPath: 'assets/icons/dollar.svg',
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                       const SizedBox(height: 40),
            //                       Center(
            //                         child: SimpleButton(
            //                           onTap: () async {
            //                             TripItem? ti =
            //                                 await _tripItemProvider.insert({
            //                               "checkIn": _datePickerController
            //                                   .selectedRange!.startDate
            //                                   .toString(),
            //                               "checkOut": _datePickerController
            //                                   .selectedRange!.endDate
            //                                   .toString(),
            //                               "pricePerPerson":
            //                                   _priceController.text,
            //                               "nightsStay":
            //                                   _nightsStayController.text,
            //                               // "tripId": widget.trip!.id,
            //                             });
            //                             if (ti != null) {
            //                               loadData();
            //                               // context.pop();
            //                               ScaffoldMessenger.of(context)
            //                                   .showSnackBar(CustomSnackBar
            //                                       .showSuccessSnackBar(
            //                                           "You have successfuly created a new trip item."));
            //                             } else {
            //                               ScaffoldMessenger.of(context)
            //                                   .showSnackBar(CustomSnackBar
            //                                       .showErrorSnackBar(
            //                                           "There was an error creating new trip item."));
            //                             }
            //                           },
            //                           bgColor: const Color(0xffEAAD5F),
            //                           textColor: Colors.white,
            //                           text: "Create",
            //                           width: 300,
            //                           height: 70,
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //               ),
            //             ));
            //   },
            //   child: Center(
            //     child: Container(
            //       width: 220,
            //       decoration: BoxDecoration(
            //           color: Colors.white,
            //           borderRadius: BorderRadius.circular(20),
            //           boxShadow: [
            //             BoxShadow(
            //               color: Colors.grey.withOpacity(0.2),
            //               spreadRadius: 0,
            //               blurRadius: 10,
            //               offset: const Offset(0, 4),
            //             )
            //           ]),
            //       child: Padding(
            //           padding: const EdgeInsets.symmetric(
            //               vertical: 15, horizontal: 20),
            //           child: Row(
            //             children: [
            //               SvgPicture.asset(
            //                 'assets/icons/plus.svg',
            //                 color: Color(0xffEAAD5F),
            //               ),
            //               const SizedBox(width: 10),
            //               Text(
            //                 "Add new Trip item",
            //                 style: TextStyle(
            //                     color: Color(0xff747474),
            //                     fontWeight: FontWeight.w500,
            //                     fontSize: 16),
            //               ),
            //             ],
            //           )),
            //     ),
            //   ),
            // ),
            const SizedBox(
              height: 100,
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
