import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../model/trip.dart';
import '../providers/trip_provider.dart';
import '../widgets/TripCard.dart';

class AgencyPage extends StatefulWidget {
  const AgencyPage({super.key});

  @override
  State<AgencyPage> createState() => _AgencyPageState();
}

class _AgencyPageState extends State<AgencyPage> {
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
    var tmpData = await _tripProvider.get({'AgencyId': 2});
    var bookmarks =
        await _tripProvider.getBookmarks(localStorage.getItem("userId"));
    setState(() {
      trips = tmpData;
      bookmarkedTrips = bookmarks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/spain.png"),
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.topCenter),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 0,
                    blurRadius: 5,
                    offset: const Offset(0, 4),
                  ),
                ]),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(50, 100, 50, 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 110,
                    width: 110,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Color(0xffE5F0F5),
                        image: DecorationImage(
                            image: const AssetImage(
                                "assets/images/user-image.png"),
                            fit: BoxFit.cover),
                        boxShadow: [
                          BoxShadow(color: Color(0xffFFE9CC), spreadRadius: 20),
                          BoxShadow(color: Color(0xffffffff), spreadRadius: 7),
                        ]),
                  ),
                  SizedBox(height: 25),
                  Text(
                    "Travelo Agency",
                    style: TextStyle(
                        color: Color(0xff454F63),
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/icons/location.svg"),
                      SizedBox(
                        width: 7,
                      ),
                      Text(
                        "Ibiza, Spain",
                        style: TextStyle(
                            color: Color(0xff454F63),
                            fontWeight: FontWeight.w400,
                            fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  Text(
                    "Travelo Agency is an agency located in Ibiza, Spain offering their customers best experience and thrill seeking trips. See more",
                    style: TextStyle(
                      color: Color(0xff5E5E5E),
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 65,
                              width: 65,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xffCDF0E1),
                              ),
                              child: Center(
                                  child: SvgPicture.asset(
                                      "assets/icons/phone.svg")),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Call us",
                              style: TextStyle(
                                color: Color(0xff797979),
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 65,
                              width: 65,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xffFFD9A9),
                              ),
                              child: Center(
                                  child: SvgPicture.asset(
                                      "assets/icons/messages.svg")),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Message",
                              style: TextStyle(
                                color: Color(0xff797979),
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 65,
                              width: 65,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xffE5F0F5),
                              ),
                              child: Center(
                                  child: SvgPicture.asset(
                                      "assets/icons/website.svg")),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Website",
                              style: TextStyle(
                                color: Color(0xff797979),
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "21 TRIPS",
                        style: TextStyle(
                            color: Color(0xff8C8C8C),
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/icons/star.svg",
                            width: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text("5.0",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xff8C8C8C),
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Column(
            children: _buildTripCardList(),
          )
        ]),
      ),
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
      height: 20,
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
