import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:travelo_agency/models/tripItem.dart';
import 'package:travelo_agency/widgets/DatePicker.dart';
import '../models/accomodation.dart';
import '../models/city.dart';
import '../models/trip.dart';
import '../providers/accomodation_provider.dart';
import '../providers/city_provider.dart';
import '../providers/tripItemProvider.dart';
import '../providers/trip_provider.dart';
import '../utils/util.dart';
import '../widgets/CustomSnackBar.dart';
import '../widgets/InputField.dart';
import '../widgets/SimpleButton.dart';

class OfferPage extends StatefulWidget {
  OfferPage({super.key, required this.trip});

  Trip? trip;

  @override
  State<OfferPage> createState() => _OfferPageState();
}

class _OfferPageState extends State<OfferPage> {
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
  late File? _file;
  List<City> cities = [];
  int cityId = -2;
  List<TripItem> tripItems = [];
  late Accomodation accomodation = Accomodation();
  // bool showPicker = false;
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
    var tmpAccomodation =
        await _accomodationProvider.getById(widget.trip!.accomodationId as int);
    var tmpTripItems = await _tripItemProvider.get({"tripId": widget.trip!.id});
    setState(() {
      cities = tmpCities;
      accomodation = tmpAccomodation;
      tripItems = tmpTripItems;
      _accomodationNameController.text = accomodation.name!;
      _accomodationDescription.text = accomodation.description!;
      _accomodationLocation.text = accomodation.locationMap!;
      _accomodationAddressController.text = accomodation.address!;
      _accomodationPostalCodeController.text = accomodation.postalCode!;
      cityId = accomodation.cityId!;
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
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Accomodation information",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff747474),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            bool flag = await _tripProvider
                                .delete(widget.trip!.id as int);
                            await _accomodationProvider
                                .delete(widget.trip!.accomodationId as int);
                            if (flag) {
                              context.go('/offers');
                              ScaffoldMessenger.of(context).showSnackBar(
                                  CustomSnackBar.showSuccessSnackBar(
                                      "Offer deleted."));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  CustomSnackBar.showErrorSnackBar(
                                      "There was an error ."));
                            }
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset('assets/icons/Trash.svg'),
                              const SizedBox(width: 5),
                              Text("Delete offer",
                                  style: TextStyle(
                                    color: Color(0xffE28888),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  )),
                            ],
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
                      _file = await pickImage();

                      if (_file != null) {
                        bool flag = await _accomodationProvider.uploadImage(
                            accomodation.id as int, _file as File);
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
                    child: Center(
                      child: Container(
                        height: 400,
                        width: 600,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image: accomodation.images == null ||
                                        accomodation.images == ""
                                    ? const AssetImage(
                                        'assets/images/imageHolder.png')
                                    : imageFromBase64String(
                                            accomodation.images ?? "")
                                        .image,
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
                            .update(accomodation.id as int, {
                          'name': _accomodationNameController.text,
                          'description': _accomodationDescription.text,
                          'locationMap': _accomodationLocation.text,
                          'address': _accomodationAddressController.text,
                          'postalCode': _accomodationPostalCodeController.text,
                          'cityId': cityId,
                        });
                        if (acc != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              CustomSnackBar.showSuccessSnackBar(
                                  "You have successfuly changed accomodation information."));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              CustomSnackBar.showErrorSnackBar(
                                  "There was an error changing your information."));
                        }
                      },
                      bgColor: const Color(0xffEAAD5F),
                      textColor: Colors.white,
                      text: "Save Changes",
                      width: 300,
                      height: 70,
                    ),
                  ),
                ],
              ),
            ),
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
                          "Trip Items",
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
                  Column(
                    children: _buildTripItems(),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                _nightsStayController.text = '';
                _priceController.text = '';
                showDialog(
                    context: context,
                    builder: (context) => Dialog(
                          insetPadding: EdgeInsets.symmetric(
                              vertical: 50, horizontal: 30),
                          child: Container(
                            width: 1000,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 0,
                                    blurRadius: 5,
                                    offset: const Offset(
                                        0, 4), // changeon of shadow
                                  )
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 50),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Add Trip Item',
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(height: 60),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                          child: CustomDatePicker(
                                              controller:
                                                  _datePickerController)),
                                      const SizedBox(width: 20),
                                      SizedBox(
                                        width: 250,
                                        child: InputField(
                                          controller: _nightsStayController,
                                          hintText: 'Nights stay',
                                          iconPath: 'assets/icons/night.svg',
                                        ),
                                      ),
                                      SizedBox(
                                        width: 250,
                                        child: InputField(
                                          controller: _priceController,
                                          hintText: 'Price per person',
                                          iconPath: 'assets/icons/dollar.svg',
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 40),
                                  Center(
                                    child: SimpleButton(
                                      onTap: () async {
                                        TripItem? ti =
                                            await _tripItemProvider.insert({
                                          "checkIn": _datePickerController
                                              .selectedRange!.startDate
                                              .toString(),
                                          "checkOut": _datePickerController
                                              .selectedRange!.endDate
                                              .toString(),
                                          "pricePerPerson":
                                              _priceController.text,
                                          "nightsStay":
                                              _nightsStayController.text,
                                          "tripId": widget.trip!.id,
                                        });
                                        if (ti != null) {
                                          loadData();
                                          context.pop();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(CustomSnackBar
                                                  .showSuccessSnackBar(
                                                      "You have successfuly created a new trip item."));
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(CustomSnackBar
                                                  .showErrorSnackBar(
                                                      "There was an error creating new trip item."));
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
                          ),
                        ));
              },
              child: Center(
                child: Container(
                  width: 220,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 0,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        )
                      ]),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/plus.svg',
                            color: Color(0xffEAAD5F),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "Add new Trip item",
                            style: TextStyle(
                                color: Color(0xff747474),
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          ),
                        ],
                      )),
                ),
              ),
            ),
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

  List<Widget> _buildTripItems() {
    List<Widget> list = [];
    if (tripItems.isEmpty) {
      list.add(Row(
        children: [Center(child: Text("There are no Trip Items."))],
      ));
    } else {
      list = tripItems
          .map((e) => Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 0,
                                blurRadius: 5,
                                offset:
                                    const Offset(0, 4), // changeon of shadow
                              )
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 30),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/calendar.svg',
                                height: 25,
                              ),
                              const SizedBox(width: 15),
                              Text(
                                '${e.dates}',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    SizedBox(
                      width: 250,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 0,
                                blurRadius: 5,
                                offset:
                                    const Offset(0, 4), // changeon of shadow
                              )
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 30),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/night.svg',
                                height: 25,
                              ),
                              const SizedBox(width: 15),
                              Text(
                                '${e.nightsStay.toString()} nights',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 250,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 0,
                                blurRadius: 5,
                                offset:
                                    const Offset(0, 4), // changeon of shadow
                              )
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 30),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/dollar.svg',
                                height: 25,
                              ),
                              const SizedBox(width: 15),
                              Text(
                                '${e.pricePerPerson.toString()} per person',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {
                        _nightsStayController.text = e.nightsStay.toString();
                        _priceController.text = e.pricePerPerson.toString();
                        showDialog(
                            context: context,
                            builder: (context) => Dialog(
                                  insetPadding: EdgeInsets.symmetric(
                                      vertical: 50, horizontal: 30),
                                  child: Container(
                                    width: 1000,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            spreadRadius: 0,
                                            blurRadius: 5,
                                            offset: const Offset(
                                                0, 4), // changeon of shadow
                                          )
                                        ]),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 50, vertical: 50),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Edit Trip Item',
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const SizedBox(height: 60),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                  child: CustomDatePicker(
                                                      controller:
                                                          _datePickerController)),
                                              const SizedBox(width: 20),
                                              SizedBox(
                                                width: 250,
                                                child: InputField(
                                                  controller:
                                                      _nightsStayController,
                                                  hintText: 'Nights stay',
                                                  iconPath:
                                                      'assets/icons/night.svg',
                                                ),
                                              ),
                                              SizedBox(
                                                width: 250,
                                                child: InputField(
                                                  controller: _priceController,
                                                  hintText: 'Price per person',
                                                  iconPath:
                                                      'assets/icons/dollar.svg',
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 40),
                                          Center(
                                            child: SimpleButton(
                                              onTap: () async {
                                                TripItem? ti =
                                                    await _tripItemProvider
                                                        .update(e.id as int, {
                                                  "checkIn":
                                                      _datePickerController
                                                          .selectedRange!
                                                          .startDate
                                                          .toString(),
                                                  "checkOut":
                                                      _datePickerController
                                                          .selectedRange!
                                                          .endDate
                                                          .toString(),
                                                  "pricePerPerson":
                                                      _priceController.text,
                                                  "nightsStay":
                                                      _nightsStayController
                                                          .text,
                                                  "tripId": widget.trip!.id,
                                                });
                                                if (ti != null) {
                                                  loadData();
                                                  context.pop();
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(CustomSnackBar
                                                          .showSuccessSnackBar(
                                                              "You have successfuly changed trip item information."));
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(CustomSnackBar
                                                          .showErrorSnackBar(
                                                              "There was an error changing your information."));
                                                }
                                              },
                                              bgColor: const Color(0xffEAAD5F),
                                              textColor: Colors.white,
                                              text: "Update",
                                              width: 300,
                                              height: 70,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ));
                      },
                      child: Center(
                          child: SvgPicture.asset(
                        'assets/icons/edit.svg',
                        height: 25,
                      )),
                    ),
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: () async {
                        bool flag = await _tripItemProvider.delete(e.id as int);
                        if (flag) {
                          loadData();
                          ScaffoldMessenger.of(context).showSnackBar(
                              CustomSnackBar.showSuccessSnackBar(
                                  "You have deleted a trip item."));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              CustomSnackBar.showErrorSnackBar(
                                  "There was an error."));
                        }
                      },
                      child: Center(
                          child: SvgPicture.asset(
                        'assets/icons/trash.svg',
                        height: 25,
                      )),
                    )
                  ],
                ),
              ))
          .cast<Widget>()
          .toList();
    }
    return list;
  }
}
