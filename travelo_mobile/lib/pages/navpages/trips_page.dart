import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:travelo_mobile/main.dart';
import 'package:travelo_mobile/providers/reservation_provider.dart';
import 'package:travelo_mobile/widgets/MyTripCard.dart';

import '../../model/reservation.dart';
import '../../utils/util.dart';
import '../../widgets/PageHeader.dart';

class TripsPage extends StatefulWidget {
  const TripsPage({super.key});

  @override
  State<TripsPage> createState() => _TripsPageState();
}

class _TripsPageState extends State<TripsPage> {
  late ReservationProvider _reservationProvider;
  List<String> items = [
    "Upcoming",
    "Past",
  ];
  int current = 0;
  List<Reservation> reservations = [];

  @override
  void initState() {
    super.initState();
    _reservationProvider = context.read<ReservationProvider>();
    loadData();
  }

  Future loadData() async {
    var tmpData = await _reservationProvider
        .get({'userId': localStorage.getItem("userId")});
    setState(() {
      reservations = tmpData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            PageHeader(
              pageName: "My Trips",
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25, bottom: 0),
              child: SizedBox(
                width: double.infinity,
                height: 40,
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: items.length,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(right: 20),
                    itemBuilder: (ctx, index) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                current = index;
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                items[index],
                                style: TextStyle(
                                    color: current == index
                                        ? Color(0xffEAAD5F)
                                        : Color(0xffA8A8A8),
                                    fontWeight: current == index
                                        ? FontWeight.w500
                                        : FontWeight.w400,
                                    fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ),
            Divider(
              color: Colors.grey,
              height: 1,
              indent: 15,
              endIndent: 15,
            ),

            /// MAIN BODY
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _buildTripsCardList(),
                    // Padding(
                    //   padding: const EdgeInsets.only(bottom: 15),
                    //   child: Row(
                    //     children: [
                    //       Container(
                    //         width: 15,
                    //         height: 30,
                    //         decoration: BoxDecoration(
                    //             color: Color(0xffEAAD5F),
                    //             borderRadius: BorderRadius.only(
                    //                 topRight: Radius.circular(10),
                    //                 bottomRight: Radius.circular(10))),
                    //       ),
                    //       SizedBox(
                    //         width: 15,
                    //       ),
                    //       Text("01. Jun - 23. Jun 2020",
                    //           style: TextStyle(color: Color(0xff8E8E8E)),
                    //           softWrap: false,
                    //           maxLines: 1,
                    //           overflow: TextOverflow.ellipsis),
                    //     ],
                    //   ),
                    // ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _buildTripsCardList() {
    List<Widget> list = [];
    Iterable<Reservation> tmp = [];
    if (current == 0) {
      tmp = reservations
          .where((element) => element.checkIn!.isAfter(DateTime.now()));
    } else if (current == 1) {
      tmp = reservations
          .where((element) => element.checkIn!.isBefore(DateTime.now()));
    }
    if (tmp.isEmpty) {
      return [Center(child: const Text("There are no trips."))];
    }
    list = tmp
        .map((r) => GestureDetector(
              onTap: () => {},
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
                child: Container(
                  height: 170,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 0,
                          blurRadius: 5,
                          offset: Offset(0, 4),
                        ),
                      ]),
                  child: Row(children: [
                    Container(
                      width: 130,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15)),
                          image: DecorationImage(
                              image: r.destinationImage == ""
                                  ? AssetImage("assets/images/imageHolder.png")
                                  : imageFromBase64String(r.destinationImage!)
                                      .image,
                              fit: BoxFit.cover)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        width: 240,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(r.destinationName ?? "",
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Color(0xff292929)),
                                        softWrap: true,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis),
                                    Text(r.countryName ?? "",
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Color(0xffA9A9A9)),
                                        softWrap: false,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis),
                                  ],
                                ),
                                Text("${r.rating.toString()}.0",
                                    style: TextStyle(
                                        fontSize: 17, color: Color(0xff616161)))
                              ],
                            ),
                            Text(r.date ?? "",
                                style: TextStyle(
                                    fontSize: 13, color: Color(0xff828282)),
                                softWrap: false,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("\$${r.price.toString()}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Color(0xff747474),
                                        fontWeight: FontWeight.w500),
                                    softWrap: false,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis),
                                Row(
                                  children: [
                                    Text(r.agencyName ?? "",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xff828282)),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ]),
                ),
              ),
            ))
        .cast<Widget>()
        .toList();
    return list;
  }
}
