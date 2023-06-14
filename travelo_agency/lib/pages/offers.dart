import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:travelo_agency/providers/trip_provider.dart';

import '../main.dart';
import '../models/trip.dart';
import '../utils/util.dart';

class OffersPage extends StatefulWidget {
  const OffersPage({super.key});

  @override
  State<OffersPage> createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  late TripProvider _tripProvider;
  List<Trip> trips = [];

  Future loadData() async {
    var tmpData = await _tripProvider
        .get({'AgencyId': localStorage.getItem('agencyId'), 'hasItems': false});
    setState(() {
      trips = tmpData;
      print(trips.length);
    });
  }

  @override
  void initState() {
    super.initState();
    _tripProvider = Provider.of<TripProvider>(context, listen: false);
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey.withOpacity(0.2),
                    width: 1,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Offers",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff747474),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.go('/offers/add');
                      },
                      child: Container(
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
                                vertical: 10, horizontal: 20),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/plus.svg',
                                  color: Color(0xff454F63),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  "Add new offer",
                                  style: TextStyle(
                                      color: Color(0xff747474),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                              ],
                            )),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                mainAxisExtent: 250,
              ),
              shrinkWrap: true,
              itemCount: trips.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => {
                    context.goNamed(
                      'Single Offer Page',
                      extra: trips[index],
                    )
                  },
                  child: Container(
                    height: 250,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 0,
                            blurRadius: 5,
                            offset: const Offset(0, 4),
                          ),
                        ]),
                    child: Row(children: [
                      Container(
                        width: 150,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            image: DecorationImage(
                                image: trips[index].accomodationImage == ""
                                    ? const AssetImage(
                                        "assets/images/imageHolder.png")
                                    : imageFromBase64String(
                                            trips[index].accomodationImage!)
                                        .image,
                                fit: BoxFit.cover)),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 15, 20, 10),
                          child: Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            trips[index].accomodationName ?? "",
                                            style: const TextStyle(
                                                fontSize: 17,
                                                color: Color(0xff292929)),
                                            softWrap: true,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis),
                                        Text(
                                            "${trips[index].cityName} ,${trips[index].countryName}",
                                            style: const TextStyle(
                                                fontSize: 13,
                                                color: Color(0xffA9A9A9)),
                                            softWrap: false,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                const Divider(
                                  height: 20,
                                ),
                                Text(
                                  trips[index].allDates!.join(", \n"),
                                  style: const TextStyle(
                                      fontSize: 13, color: Color(0xff000000)),
                                  softWrap: true,
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const Divider(
                                  height: 20,
                                ),
                                Text(trips[index].accomodationDescription ?? "",
                                    style: const TextStyle(
                                        fontSize: 11, color: Color(0xff292929)),
                                    softWrap: true,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis),
                                const Divider(
                                  height: 20,
                                ),
                                Text(
                                    trips[index].lowestPrice ==
                                            trips[index].highestPrice
                                        ? "\$${trips[index].lowestPrice.toString()} per night"
                                        : "\$${trips[index].lowestPrice.toString()} - \$${trips[index].highestPrice.toString()} per night",
                                    style: const TextStyle(
                                        fontSize: 17, color: Color(0xff292929)),
                                    softWrap: true,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis),
                              ],
                            ),
                          ),
                        ),
                      )
                    ]),
                  ),
                );
              },
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
