import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:travelo_mobile/providers/agency_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';
import '../model/agency.dart';
import '../model/trip.dart';
import '../providers/trip_provider.dart';
import '../utils/util.dart';
import '../widgets/TripCard.dart';

class AgencyPage extends StatefulWidget {
  final int agencyId;
  const AgencyPage({super.key, required this.agencyId});

  @override
  State<AgencyPage> createState() => _AgencyPageState();
}

class _AgencyPageState extends State<AgencyPage> {
  late Agency? _agency;
  late AgencyProvider _agencyProvider;
  late TripProvider _tripProvider;
  List<Trip> trips = [];
  List<Trip> bookmarkedTrips = [];

  @override
  void initState() {
    super.initState();
    _agency = Agency();
    _agencyProvider = context.read<AgencyProvider>();
    _tripProvider = context.read<TripProvider>();
    loadData();
  }

  Future loadData() async {
    var agency = await _agencyProvider.getById(widget.agencyId);
    var tmpData = await _tripProvider.get({'AgencyId': widget.agencyId});
    var bookmarks =
        await _tripProvider.getBookmarks(localStorage.getItem("userId"));
    setState(() {
      _agency = agency;
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
                image: const DecorationImage(
                    image: AssetImage("assets/images/spain.png"),
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.topCenter),
                borderRadius: const BorderRadius.only(
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
                        color: const Color(0xffE5F0F5),
                        image: DecorationImage(
                            image: _agency?.image == ""
                                ? const AssetImage(
                                    "assets/images/user-image.png")
                                : imageFromBase64String(_agency?.image ?? "")
                                    .image,
                            fit: BoxFit.cover),
                        boxShadow: const [
                          BoxShadow(color: Color(0xffFFE9CC), spreadRadius: 20),
                          BoxShadow(color: Color(0xffffffff), spreadRadius: 7),
                        ]),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    _agency?.name ?? "",
                    style: const TextStyle(
                        color: Color(0xff454F63),
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/icons/location.svg"),
                      const SizedBox(
                        width: 7,
                      ),
                      Text(
                        _agency?.location ?? "",
                        style: const TextStyle(
                            color: Color(0xff454F63),
                            fontWeight: FontWeight.w400,
                            fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text(
                    _agency?.about ?? "",
                    style: const TextStyle(
                      color: Color(0xff5E5E5E),
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          final Uri launchUri = Uri(
                            scheme: 'tel',
                            path: "${_agency?.phone}",
                          );
                          if (await canLaunchUrl(launchUri)) {
                            await launchUrl(launchUri);
                          } else {
                            throw 'Could not launch phone';
                          }
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 65,
                              width: 65,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color(0xffCDF0E1),
                              ),
                              child: Center(
                                  child: SvgPicture.asset(
                                      "assets/icons/phone.svg")),
                            ),
                            const SizedBox(height: 10),
                            const Text(
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
                        onTap: () async {
                          final Uri launchUri = Uri(
                              scheme: 'sms', path: _agency!.phone.toString());
                          if (await canLaunchUrl(launchUri)) {
                            await launchUrl(launchUri);
                          } else {
                            throw 'Could not launch message';
                          }
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 65,
                              width: 65,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color(0xffFFD9A9),
                              ),
                              child: Center(
                                  child: SvgPicture.asset(
                                      "assets/icons/messages.svg")),
                            ),
                            const SizedBox(height: 10),
                            const Text(
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
                        onTap: () async {
                          final Uri launchUri = Uri(
                              scheme: 'http', path: _agency!.websiteUrl ?? "");
                          if (await canLaunchUrl(launchUri)) {
                            await launchUrl(launchUri);
                          } else {
                            throw 'Could not launch url';
                          }
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 65,
                              width: 65,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color(0xffE5F0F5),
                              ),
                              child: Center(
                                  child: SvgPicture.asset(
                                      "assets/icons/website.svg")),
                            ),
                            const SizedBox(height: 10),
                            const Text(
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
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${trips.length} TRIPS",
                        style: const TextStyle(
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
                          const SizedBox(
                            width: 5,
                          ),
                          Text("${_agency?.rating ?? 0}",
                              style: const TextStyle(
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
