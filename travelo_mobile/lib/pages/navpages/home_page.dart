import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:travelo_mobile/widgets/BlogCard.dart';
import 'package:travelo_mobile/widgets/DestinationCard.dart';
import 'package:travelo_mobile/widgets/InputField.dart';

import '../../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> items = [
    "Hot",
    "Summer",
    "Surfing",
    "Day-trips",
  ];

  /// List of body icon
  List<String> icons = [
    "assets/icons/hot.svg",
    "assets/icons/summer.svg",
    "assets/icons/surfing.svg",
    "assets/icons/backpack.svg",
  ];
  // List<String> activeIcons = [
  //   "assets/icons/hot-active.svg",
  //   "assets/icons/summer-active.svg",
  //   "assets/icons/surfing-active.svg",
  //   "assets/icons/backpack-active.svg",
  // ];
  int current = 0;
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables

          children: [
            InputField(
              controller: _searchController,
              hintText: 'Search trips',
              iconPath: 'assets/icons/Search.svg',
            ),
            SizedBox(height: 20),
            Container(
              // change your height based on preference
              height: 170,
              width: double.infinity,

              child: ListView(
                // set the scroll direction to horizontal
                scrollDirection: Axis.horizontal,
                children: [
                  BlogCard(
                    date: '18. Maj',
                    image: 'assets/images/slika.png',
                    location: 'Mostar, Bosnia and Herzegovina',
                    name: 'Take a rafting trip on Neretva with 20% off',
                  ),
                  BlogCard(
                    date: '18. Maj',
                    image: 'assets/images/slika.png',
                    location: 'Zivinice, Bosnia and Herzegovina',
                    name: 'Something awesome',
                  ),
                  BlogCard(
                    date: '18. Maj',
                    image: 'assets/images/slika.png',
                    location: 'Sarajevo, Bosnia and Herzegovina',
                    name: 'Take me to the moon.',
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 0),
              child: SizedBox(
                width: double.infinity,
                height: 45,
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
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    icons[index],
                                    height: 25,
                                    width: 25,
                                    color: current == index
                                        ? Color(0xffEAAD5F)
                                        : Color(0xffA8A8A8),
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Text(
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
                                ],
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
              indent: 20,
              endIndent: 20,
            ),

            /// MAIN BODY
            Container(
              margin: const EdgeInsets.only(top: 20),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Text(
                  //   items[current],
                  //   // style:,
                  // )
                  DestinationCard(),
                  SizedBox(height: 20),
                  DestinationCard(),
                  SizedBox(height: 20),
                  DestinationCard(),
                  SizedBox(height: 20),
                  DestinationCard(),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
