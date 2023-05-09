import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:travelo_mobile/pages/SearchBarPageTemplate.dart';
import 'package:travelo_mobile/providers/destination_provider.dart';
import 'package:travelo_mobile/utils/util.dart';
import 'package:travelo_mobile/widgets/BlogCard.dart';
import '../../model/destination.dart';
import '../destination.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DestinationProvider _destinationProvider;

  List<String> items = [
    "Hot",
    "Summer",
    "Surfing",
    "Day-trips",
  ];
  List<String> icons = [
    "assets/icons/hot.svg",
    "assets/icons/summer.svg",
    "assets/icons/surfing.svg",
    "assets/icons/backpack.svg",
  ];
  List<Destination> destinations = [];
  int current = 0;

  @override
  void initState() {
    super.initState();
    _destinationProvider = context.read<DestinationProvider>();
    loadData();
  }

  Future loadData() async {
    var tmpData = await _destinationProvider.get({'tag': items[current]});
    setState(() {
      destinations = tmpData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SearchBarPageTemplate(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 70),
                // InputField(
                //   controller: _searchController,
                //   hintText: 'Search trips',
                //   iconPath: 'assets/icons/Search.svg',
                // ),
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
                                onTap: () async {
                                  setState(() {
                                    current = index;
                                  });
                                  loadData();
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

                /// DESTINATIONS BODY
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: _buildDestinationCardList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildDestinationCardList() {
    if (destinations.length == 0) {
      //Add loading for few seconds and if no data then text.
      return [Text("There are no trips.")];
    }
    List<Widget> list = destinations
        .map((x) => Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: GestureDetector(
                onTap: () => {
                  context.goNamed('Destination', queryParameters: {
                    'city': x.name ?? "City name",
                    'cityImage': x.image ?? "",
                    'countryName': x.countryName ?? "Country Name",
                    'numberOfTrips': x.numberOfTrips.toString() == ""
                        ? "0"
                        : x.numberOfTrips.toString(),
                  })
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => DestinationPage(
                  //           city: x.name ?? "City name",
                  //           cityImage: x.image ?? "",
                  //           countryName: x.countryName ?? "Country Name",
                  //           numberOfTrips: x.numberOfTrips.toString() == ""
                  //               ? "0"
                  //               : x.numberOfTrips.toString())),
                  // )
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    height: 190,
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
                        height: 190,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(15)),
                            image: DecorationImage(
                                // image: AssetImage("assets/images/tulum.png"),
                                image: x.image == ""
                                    ? AssetImage(
                                        "assets/images/imageHolder.png")
                                    : imageFromBase64String(x.image!).image,
                                fit: BoxFit.cover)),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(x.name ?? "",
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Color(0xff292929)),
                                        softWrap: true,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis),
                                    Text(x.countryName ?? "",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Color(0xff989898)),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis)
                                  ],
                                ),
                                Text(
                                    "From \$" +
                                        x.lowestTripPrice.toString() +
                                        "per person",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xffEAAD5F),
                                        fontWeight: FontWeight.w500),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis),
                                Text(
                                    x.numberOfTrips.toString() +
                                        " trips".toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 15, color: Color(0xff989898)),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis),
                                Wrap(
                                  spacing: 7,
                                  runSpacing: 7,
                                  children: [
                                    for (var tag in x.tags)
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Color(0xffE5F0F5),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 7, horizontal: 10),
                                          child: Text(tag ?? "",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0xff94B4C4)),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                      )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ]),
                  ),
                ),
              ),
            ))
        .cast<Widget>()
        .toList();
    return list;
  }
}
