import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelo_mobile/pages/SearchBarPageTemplate.dart';
import 'package:travelo_mobile/providers/trip_provider.dart';
import 'package:travelo_mobile/utils/util.dart';
import 'package:travelo_mobile/widgets/TripCard.dart';

import '../model/trip.dart';
import '../widgets/InputField.dart';

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
  TextEditingController _dummyController = TextEditingController();
  late TripProvider _tripProvider;

  List<Trip> trips = [];

  @override
  void initState() {
    super.initState();
    _tripProvider = context.read<TripProvider>();
    loadData();
  }

  Future loadData() async {
    var tmpData = await _tripProvider.get({'City': widget.city});
    setState(() {
      trips = tmpData;
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
                  // InputField(
                  //   hintText: 'Search trips',
                  //   iconPath: 'assets/icons/Search.svg',
                  //   controller: _dummyController,
                  // ),
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
                // children: [
                //   SizedBox(
                //     height: 10,
                //   ),
                //   TripCard(
                //     agency: 'Travelo Agency',
                //     bookmarked: false,
                //     datesString: '16.Jun - 23. Jun 2022',
                //     description:
                //         'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur,',
                //     destination: 'Tulum, Mexico',
                //     price: 1256,
                //     rating: 4,
                //     resort: 'Holistika resort',
                //   ),
                //   SizedBox(
                //     height: 20,
                //   ),
                // ],
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
      return [const Text("There are no trips.")];
    }
    print(trips[0].agencyName);
    List<Widget> list = [];
    list.add(const SizedBox(
      height: 10,
    ));
    list += trips
        .map((trip) => TripCard(
            // agency: trip.agencyName ?? "",
            // bookmarked: false,
            // datesString: trip.dates ?? "",
            // description: trip.accomodationDescription ?? "",
            // destination: widget.countryName,
            // price: trip.lowestPrice ?? 0,
            // rating: 4,
            // resort: trip.accomodationName ?? "",
            // image: trip.accomodationImage ?? "",
            // agencyImage: trip.agencyImage ?? "",
            trip: trip))
        .cast<Widget>()
        .toList();
    list.add(const SizedBox(
      height: 20,
    ));
    return list;
  }
}
