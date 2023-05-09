import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelo_mobile/main.dart';
import 'package:travelo_mobile/pages/SearchBarPageTemplate.dart';
import 'package:travelo_mobile/providers/trip_provider.dart';
import 'package:travelo_mobile/utils/util.dart';
import 'package:travelo_mobile/widgets/TripCard.dart';
import '../model/trip.dart';

class DestinationPage extends StatefulWidget {
  final String city;
  final String cityImage;
  final String numberOfTrips;
  final String countryName;

  const DestinationPage(
      {super.key,
      required this.city,
      required this.cityImage,
      required this.numberOfTrips,
      required this.countryName});

  @override
  State<DestinationPage> createState() => _DestinationPageState();
}

class _DestinationPageState extends State<DestinationPage> {
  late TripProvider _tripProvider;

  List<Trip> trips = [];
  List<Trip> bookmarkedTrips = [];

  @override
  void initState() {
    super.initState();
    _tripProvider = context.read<TripProvider>();
    loadData();
  }

  Future loadData() async {
    var tmpData = await _tripProvider.get({'City': widget.city});
    var bookmarks =
        await _tripProvider.getBookmarks(localStorage.getItem("userId"));
    setState(() {
      trips = tmpData;
      bookmarkedTrips = bookmarks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SearchBarPageTemplate(
      child: Scaffold(
          body: Column(
        children: [
          Container(
            height: 240,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: widget.cityImage == ""
                        ? const AssetImage("assets/images/tulum-bg.png")
                        : imageFromBase64String(widget.cityImage).image,
                    fit: BoxFit.cover),
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30))),
            child: SafeArea(
              bottom: false,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: 70),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.city,
                              style: const TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(widget.countryName,
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: Color(0xffE7EAEA),
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                        Text("${widget.numberOfTrips.toString()} TRIPS",
                            style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: _buildTripCardList(),
              ),
            ),
          )
        ],
      )),
    );
  }

  List<Widget> _buildTripCardList() {
    if (trips.isEmpty) {
      //Add loading for few seconds and if no data then text.
      return [
        const Padding(
          padding: EdgeInsets.only(top: 20),
          child: Text("There are no trips."),
        )
      ];
    }
    List<Widget> list = [];
    list.add(const SizedBox(
      height: 10,
    ));

    list += trips
        .map((trip) => TripCard(
              trip: trip,
              bookmarked:
                  bookmarkedTrips.where(((e) => e.id == trip.id)).isNotEmpty,
            ))
        .cast<Widget>()
        .toList();

    list.add(const SizedBox(
      height: 20,
    ));
    return list;
  }
}
