import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:travelo_mobile/main.dart';
import 'package:travelo_mobile/model/trip.dart' as trip_model;
import 'package:travelo_mobile/providers/reservation_provider.dart';
import 'package:travelo_mobile/services/payment_service.dart';
import '../model/tripitem.dart';
import '../providers/trip_provider.dart';
import '../providers/tripitem_provider.dart';
import '../utils/util.dart';
import '../widgets/CustomSnackBar.dart';
import '../widgets/GalleryWidget.dart';

class Trip extends StatefulWidget {
  final trip_model.Trip trip;
  late bool bookmarked;
  Trip({super.key, required this.trip, this.bookmarked = false});

  @override
  State<Trip> createState() => _TripState();
}

class _TripState extends State<Trip> {
  late TripProvider _tripProvider;
  late TripItemProvider _tripItemProvider;
  late ReservationProvider _reservationProvider;

  List<TripItem> tripItems = [];
  int numberOfChildren = 0;
  int numberOfAdults = 1;

  @override
  void initState() {
    super.initState();
    _tripItemProvider = context.read<TripItemProvider>();
    _reservationProvider = context.read<ReservationProvider>();
    _tripProvider = context.read<TripProvider>();
    loadData();
  }

  Future loadData() async {
    var tmpData = await _tripItemProvider.get({'TripId': widget.trip.id});
    setState(() {
      tripItems = tmpData;
    });
  }

  void selectedTrip() {
    setState(() {
      _price = tripItems.firstWhere((e) => e.id == _value).totalPrice ?? 0;
      // TripItem tr =
      //     tripItems.where((element) => element.id == _value) as TripItem;
      // _price = tr.totalPrice!;
    });
  }

  Future addBookmark() async {
    var tmp = await _tripProvider.toggleBookmark(
        widget.trip.id ?? -1, localStorage.getItem("userId"));
    setState(() {
      widget.bookmarked = tmp;
    });
  }

  int _price = 0;
  int _value = -1;
  @override
  Widget build(BuildContext context) {
    final paymentController = PaymentController();
    void openGallery() {
      List<String> imagez = [];
      imagez.add(widget.trip.accomodationImage ?? "");
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => GalleryWidget(
                images: imagez,
              )));
    }

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(children: [
          GestureDetector(
            onTap: openGallery,
            child: Container(
              height: 380,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: widget.trip.accomodationImage == ""
                          ? const AssetImage("assets/images/imageHolder.png")
                          : imageFromBase64String(
                                  widget.trip.accomodationImage!)
                              .image,
                      fit: BoxFit.cover),
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30))),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 40),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              widget.trip.accomodationName ?? "Accomodation",
                              style: const TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(widget.trip.cityName ?? "Destination",
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: Color(0xffE7EAEA),
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/star.svg",
                                  width: 20,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text("${widget.trip.rating}.0",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text("${widget.trip.ratingCount} reviews",
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white.withOpacity(0.9),
                                    fontWeight: FontWeight.w500)),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: const Offset(0, -20),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 0,
                                blurRadius: 5,
                                offset: const Offset(0, 4))
                          ]),
                      child: DropdownButtonFormField(
                        value: _value,
                        items: _buildTripItemDropDownList(),
                        // items: [
                        //   DropdownMenuItem(child: Text("Loading..."), value: -1),
                        //   DropdownMenuItem(child: Text("Something"), value: 1),
                        //   DropdownMenuItem(child: Text("Else"), value: 2),
                        //   DropdownMenuItem(child: Text("naa"), value: 3),
                        // ],
                        onChanged: (v) {
                          _value = v;
                          selectedTrip();
                        },
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            // width: 0.0 produces a thin "hairline" border
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      addBookmark();
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 0,
                                blurRadius: 5,
                                offset: const Offset(0, 4))
                          ]),
                      child: SvgPicture.asset(
                        "assets/icons/Bookmarks.svg",
                        color: widget.bookmarked
                            ? const Color(0xffEAAD5F)
                            : const Color(0xffD6D6D6),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    height: 120,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 0,
                              blurRadius: 5,
                              offset: const Offset(0, 4))
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(children: [
                        const Text(
                          "Children",
                          style: TextStyle(
                            color: Color(0xff787878),
                            fontSize: 18,
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (numberOfChildren != 0) {
                                        numberOfChildren = numberOfChildren - 1;
                                      }
                                    });
                                  },
                                  child: SvgPicture.asset(
                                      "assets/icons/minus.svg")),
                              Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffF8F8F8),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                      child: Text(
                                    numberOfChildren.toString(),
                                    style: const TextStyle(
                                        fontSize: 24,
                                        color: Color(0xff747474),
                                        fontWeight: FontWeight.w500),
                                  ))),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      //Check for left places
                                      numberOfChildren = numberOfChildren + 1;
                                    });
                                  },
                                  child: SvgPicture.asset(
                                      "assets/icons/plus-grey.svg")),
                            ],
                          ),
                        )
                      ]),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    height: 120,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 0,
                              blurRadius: 5,
                              offset: const Offset(0, 4))
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(children: [
                        const Text(
                          "Adults",
                          style: TextStyle(
                            color: Color(0xff787878),
                            fontSize: 18,
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (numberOfAdults > 1) {
                                        numberOfAdults = numberOfAdults - 1;
                                      }
                                    });
                                  },
                                  child: SvgPicture.asset(
                                      "assets/icons/minus.svg")),
                              Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffF8F8F8),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                      child: Text(
                                    numberOfAdults.toString(),
                                    style: const TextStyle(
                                        fontSize: 24,
                                        color: Color(0xff747474),
                                        fontWeight: FontWeight.w500),
                                  ))),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      //Check for left places
                                      numberOfAdults = numberOfAdults + 1;
                                    });
                                  },
                                  child: SvgPicture.asset(
                                      "assets/icons/plus-grey.svg")),
                            ],
                          ),
                        )
                      ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(children: [
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: Divider(
                indent: 15,
                endIndent: 15,
                height: 1,
              ),
            ),
            SizedBox(height: 75, child: _buildFacilitiesList()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text(
                  widget.trip.accomodationDescription ??
                      "Accomodation desctiption",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 17,
                    color: Color(0xff5E5E5E),
                    fontWeight: FontWeight.w400,
                  )),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 200,
              width: double.infinity,
              child: const GoogleMap(
                initialCameraPosition:
                    CameraPosition(target: LatLng(43.341584, 17.801163)),
                myLocationButtonEnabled: false,
              ),
            )
          ]),
          if (_price != 0)
            GestureDetector(
              onTap: () async {
                var payment = await paymentController.makePayment(
                    amount: (_price * (numberOfAdults + numberOfChildren))
                        .toString(),
                    currency: 'USD');

                // print("Payment Processing Done");
                // var response = "";
                // if (payment == "dfogdfklgjdflkgjfd") {
                //   response = await _reservationProvider.processReservation(
                //       numberOfAdults,
                //       numberOfChildren,
                //       localStorage.getItem("userId"),
                //       _price,
                //       _value,
                //       widget.trip.id ?? -1,
                //       DateTime.now());
                // }
                // if (response == "") {
                //   context.go('/trips');
                //   ScaffoldMessenger.of(context).showSnackBar(
                //       CustomSnackBar.showSuccessSnackBar(
                //           "You have successfuly booked a trip to Holistika Resort with Travelo Agency."));
                // } else {
                //   ScaffoldMessenger.of(context)
                //       .showSnackBar(CustomSnackBar.showErrorSnackBar(response));
                // }
              },
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
                  child: Container(
                    height: 70,
                    decoration: BoxDecoration(
                        color: const Color(0xffEAAD5F),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 0,
                              blurRadius: 5,
                              offset: const Offset(0, 4))
                        ]),
                    child: Center(
                        child: Text(
                      "Book now for \$${_price * (numberOfAdults + numberOfChildren)}",
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 20),
                    )),
                  ),
                ),
              ),
            )
        ]),
      ),
    );
  }

  List<DropdownMenuItem> _buildTripItemDropDownList() {
    List<DropdownMenuItem> list = [];
    if (tripItems.isEmpty) {
      list.add(const DropdownMenuItem(
        value: -1,
        enabled: false,
        child: Text("Loading..."),
      ));
      return list;
    }

    list.add(const DropdownMenuItem(
      value: -1,
      enabled: false,
      child: Text("Choose date"),
    ));
    list += tripItems
        .map((trip) => DropdownMenuItem(
              value: trip.id,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "${DateFormat('dd. MMMM yyyy').format(trip.checkIn!)} - ${DateFormat('dd. MMMM yyyy').format(trip.checkOut!)}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ))
        .cast<DropdownMenuItem>()
        .toList();
    return list;
  }

  Widget _buildFacilitiesList() {
    if (widget.trip.facilities!.isEmpty) {
      return Center(child: Text("There are no facilities registered."));
    }
    return ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 20, right: 20),
        children: widget.trip.facilities!
            .map(
              (fac) => Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Container(
                  height: 75,
                  width: 75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xffF8F8F8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/icons/${fac.toLowerCase()}.svg"),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        fac,
                        style: const TextStyle(
                          color: Color(0xff6B6B6B),
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
            )
            .cast<Widget>()
            .toList());
  }
}
