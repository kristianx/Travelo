import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:travelo_mobile/pages/SearchBarPageTemplate.dart';
import 'package:travelo_mobile/providers/destination_provider.dart';
import 'package:travelo_mobile/utils/util.dart';
import 'package:travelo_mobile/widgets/BlogCard.dart';
import '../../model/destination.dart';
import '../../model/tag.dart';
import '../../providers/tag_provider.dart';
import '../../widgets/CustomSnackBar.dart';
import '../destination.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DestinationProvider _destinationProvider;
  late TagProvider _tagProvider;

  List<String> icons = [
    "assets/icons/hot.svg",
    "assets/icons/summer.svg",
    "assets/icons/surfing.svg",
    "assets/icons/backpack.svg",
  ];

  List<Destination> destinations = [];
  List<Tag> tags = [];
  int current = 0;

  @override
  void initState() {
    super.initState();
    _destinationProvider = context.read<DestinationProvider>();
    _tagProvider = context.read<TagProvider>();
    loadData();
  }

  Future loadData() async {
    var tmpTags = await _tagProvider.get();
    setState(() {
      tags = tmpTags;
    });
    loadTrips();
  }

  Future loadTrips() async {
    var tmpData = await _destinationProvider.get({'tag': tags[current].name});
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
                const SizedBox(height: 70),
                SizedBox(
                  height: 170,
                  width: double.infinity,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: const [
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
                        itemCount: tags.length,
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(right: 20, bottom: 20),
                        itemBuilder: (ctx, index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    current = index;
                                  });
                                  loadData();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Row(
                                    children: [
                                      icons.firstWhere(
                                                  (string) => string.contains(
                                                      tags[index]
                                                          .name!
                                                          .toLowerCase()),
                                                  orElse: () => "") !=
                                              ""
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 7),
                                              child: SvgPicture.asset(
                                                icons.firstWhere(
                                                    (string) => string.contains(
                                                        tags[index]
                                                            .name!
                                                            .toLowerCase()),
                                                    orElse: () => ""),
                                                height: 25,
                                                width: 25,
                                                color: current == index
                                                    ? const Color(0xffEAAD5F)
                                                    : const Color(0xffA8A8A8),
                                              ),
                                            )
                                          : Container(),
                                      Text(
                                        tags[index].name ?? "-",
                                        style: TextStyle(
                                            color: current == index
                                                ? const Color(0xffEAAD5F)
                                                : const Color(0xffA8A8A8),
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
                const Divider(
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
    if (destinations.isEmpty) {
      //Add loading for few seconds and if no data then text.
      return [const Text("There are no trips.")];
    }
    List<Widget> list = destinations
        .map((x) => Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: GestureDetector(
                onTap: () => {
                  // context.goNamed('Destination', queryParameters: {
                  //   'city': x.name ?? "City name",
                  //   'cityImage': x.image ?? "",
                  //   'countryName': x.countryName ?? "Country Name",
                  //   'numberOfTrips': x.numberOfTrips.toString() == ""
                  //       ? "0"
                  //       : x.numberOfTrips.toString(),
                  // })
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DestinationPage(
                            city: x.name ?? "City name",
                            cityImage: x.image ?? "",
                            countryName: x.countryName ?? "Country Name",
                            numberOfTrips: x.numberOfTrips.toString() == ""
                                ? "0"
                                : x.numberOfTrips.toString())),
                  )
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
                            offset: const Offset(0, 4),
                          ),
                        ]),
                    child: Row(children: [
                      Container(
                        width: 130,
                        height: 190,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(15)),
                            image: DecorationImage(
                                // image: AssetImage("assets/images/tulum.png"),
                                image: x.image == ""
                                    ? const AssetImage(
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
                                        style: const TextStyle(
                                            fontSize: 17,
                                            color: Color(0xff292929)),
                                        softWrap: true,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis),
                                    Text(x.countryName ?? "",
                                        style: const TextStyle(
                                            fontSize: 15,
                                            color: Color(0xff989898)),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis)
                                  ],
                                ),
                                Text("From \$${x.lowestTripPrice}per person",
                                    style: const TextStyle(
                                        fontSize: 15,
                                        color: Color(0xffEAAD5F),
                                        fontWeight: FontWeight.w500),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis),
                                Text(
                                    x.numberOfTrips.toString() +
                                        " trips".toUpperCase(),
                                    style: const TextStyle(
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
                                          color: const Color(0xffE5F0F5),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 7, horizontal: 10),
                                          child: Text(tag ?? "",
                                              style: const TextStyle(
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
