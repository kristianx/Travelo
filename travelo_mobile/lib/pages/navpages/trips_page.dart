import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:travelo_mobile/widgets/MyTripCard.dart';

import '../../widgets/PageHeader.dart';

class TripsPage extends StatefulWidget {
  const TripsPage({super.key});

  @override
  State<TripsPage> createState() => _TripsPageState();
}

class _TripsPageState extends State<TripsPage> {
  List<String> items = [
    "Upcoming",
    "Past",
  ];
  int current = 0;
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
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Row(
                          children: [
                            Container(
                              width: 15,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: Color(0xffEAAD5F),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      bottomRight: Radius.circular(10))),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text("01. Jun - 23. Jun 2020",
                                style: TextStyle(color: Color(0xff8E8E8E)),
                                softWrap: false,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis),
                          ],
                        ),
                      ),
                      MyTripCard(
                          name: "Holistika Resort",
                          agency: "Travelo Agency",
                          price: "\$1256",
                          image: "assets/images/tulum.png",
                          location: "Tulum, Mexico"),
                      MyTripCard(
                          name: "Holistika Resort",
                          agency: "Travelo Agency",
                          price: "\$1256",
                          image: "assets/images/tulum.png",
                          location: "Tulum, Mexico"),
                      MyTripCard(
                          name: "Holistika Resort",
                          agency: "Travelo Agency",
                          price: "\$1256",
                          image: "assets/images/tulum.png",
                          location: "Tulum, Mexico"),
                      MyTripCard(
                          name: "Holistika Resort",
                          agency: "Travelo Agency",
                          price: "\$1256",
                          image: "assets/images/tulum.png",
                          location: "Tulum, Mexico"),
                      MyTripCard(
                          name: "Holistika Resort",
                          agency: "Travelo Agency",
                          price: "\$1256",
                          image: "assets/images/tulum.png",
                          location: "Tulum, Mexico"),
                      MyTripCard(
                          name: "Holistika Resort",
                          agency: "Travelo Agency",
                          price: "\$1256",
                          image: "assets/images/tulum.png",
                          location: "Tulum, Mexico")
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
