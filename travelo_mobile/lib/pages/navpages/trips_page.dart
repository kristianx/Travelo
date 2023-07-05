import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:travelo_mobile/main.dart';
import 'package:travelo_mobile/providers/reservation_provider.dart';

import '../../model/reservation.dart';
import '../../providers/trip_provider.dart';
import '../../utils/util.dart';
import '../../widgets/CustomSnackBar.dart';
import '../../widgets/InputField.dart';
import '../../widgets/PageHeader.dart';
import '../../widgets/SimpleButton.dart';

class TripsPage extends StatefulWidget {
  const TripsPage({super.key});

  @override
  State<TripsPage> createState() => _TripsPageState();
}

class _TripsPageState extends State<TripsPage> {
  late ReservationProvider _reservationProvider;
  late TripProvider _tripProvider;
  List<String> items = [
    "Upcoming",
    "Past",
  ];
  int current = 0;
  List<Reservation> reservations = [];
  double ratingVar = 3.0;
  final formKeyReview = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _reservationProvider = context.read<ReservationProvider>();
    _tripProvider = context.read<TripProvider>();
    loadData();
  }

  Future loadData() async {
    var tmpData = await _reservationProvider
        .get({'userId': localStorage.getItem("userId")});
    setState(() {
      reservations = tmpData;
      reservations.sort((a, b) {
        var adate = a.checkIn!;
        var bdate = b.checkIn!;
        return adate.compareTo(bdate);
      });
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
                    padding: const EdgeInsets.only(right: 20),
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
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                items[index],
                                style: TextStyle(
                                    color: current == index
                                        ? const Color(0xffEAAD5F)
                                        : const Color(0xffA8A8A8),
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
            const Divider(
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
      return [const Center(child: Text("There are no trips."))];
    }
    list = tmp
        .map((r) => GestureDetector(
              onTap: () => {},
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
                child: Container(
                  height: current == 0 ? 170 : 200,
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
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15)),
                          image: DecorationImage(
                              image: r.destinationImage == ""
                                  ? const AssetImage(
                                      "assets/images/imageHolder.png")
                                  : imageFromBase64String(r.destinationImage!)
                                      .image,
                              fit: BoxFit.cover)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SizedBox(
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
                                    Text(r.accomodationName ?? "",
                                        style: const TextStyle(
                                            fontSize: 17,
                                            color: Color(0xff292929)),
                                        softWrap: true,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis),
                                    Text(
                                        "${r.destinationName}, ${r.countryName}",
                                        style: const TextStyle(
                                            fontSize: 13,
                                            color: Color(0xffA9A9A9)),
                                        softWrap: false,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis),
                                  ],
                                ),
                                Text("${r.rating.toString()}",
                                    style: const TextStyle(
                                        fontSize: 17, color: Color(0xff616161)))
                              ],
                            ),
                            Text(r.date ?? "",
                                style: const TextStyle(
                                    fontSize: 13, color: Color(0xff828282)),
                                softWrap: false,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("\$${r.price.toString()}",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        color: Color(0xff747474),
                                        fontWeight: FontWeight.w500),
                                    softWrap: false,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis),
                                if (current == 0)
                                  Row(
                                    children: [
                                      Text(r.agencyName ?? "",
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Color(0xff828282)),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis),
                                    ],
                                  )
                              ],
                            ),
                            if (current == 1 &&
                                r.reviewLeaved != null &&
                                r.reviewLeaved == -1.0)
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => Dialog(
                                          insetPadding: EdgeInsets.symmetric(
                                              vertical: 50, horizontal: 30),
                                          child: StatefulBuilder(builder:
                                              (BuildContext context,
                                                  StateSetter setState) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 30,
                                                      vertical: 60),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    "Leave a review",
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xff000000),
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const SizedBox(height: 30),
                                                  Text(
                                                    ratingVar.toString(),
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xff000000),
                                                        fontSize: 35,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  const SizedBox(height: 30),
                                                  RatingBar.builder(
                                                    initialRating: 3,
                                                    minRating: 1,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    unratedColor:
                                                        Colors.grey.shade200,
                                                    itemSize: 50.0,
                                                    itemPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 1.0),
                                                    itemBuilder: (context, _) =>
                                                        Icon(
                                                      Icons.star,
                                                      color: Color(0xffEAAD5F),
                                                    ),
                                                    onRatingUpdate: (rating) {
                                                      setState(() {
                                                        ratingVar = rating;
                                                      });
                                                    },
                                                  ),
                                                  const SizedBox(height: 60),
                                                  SimpleButton(
                                                    onTap: () async {
                                                      try {
                                                        var flag =
                                                            await _tripProvider
                                                                .AddRating(
                                                                    localStorage
                                                                        .getItem(
                                                                            "userId"),
                                                                    r.tripId!,
                                                                    ratingVar);
                                                        if (flag) {
                                                          context.pop();
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  CustomSnackBar
                                                                      .showSuccessSnackBar(
                                                                          "You have successfuly leaved a review."));
                                                          loadData();
                                                        } else {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  CustomSnackBar
                                                                      .showErrorSnackBar(
                                                                          "There was an issue with leaving a review."));
                                                        }
                                                      } catch (e) {
                                                        showDialog(
                                                            context: context,
                                                            builder: (BuildContext
                                                                    context) =>
                                                                AlertDialog(
                                                                  title: const Text(
                                                                      "Error"),
                                                                  content: Text(
                                                                      e.toString()),
                                                                  actions: [
                                                                    TextButton(
                                                                      child: const Text(
                                                                          "Ok"),
                                                                      onPressed:
                                                                          () =>
                                                                              Navigator.pop(context),
                                                                    )
                                                                  ],
                                                                ));
                                                      }
                                                    },
                                                    bgColor:
                                                        const Color(0xffEAAD5F),
                                                    textColor: Colors.white,
                                                    text: "Leave a review",
                                                    width: 300,
                                                    height: 70,
                                                  ),
                                                ],
                                              ),
                                            );
                                          })));
                                },
                                child: Center(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 25),
                                    decoration: BoxDecoration(
                                        color: const Color(0xffEAAD5F),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Text("Leave a review",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Color(0xffffffff),
                                            fontWeight: FontWeight.w500),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ),
                              ),
                            if (current == 1 && r.reviewLeaved != -1.0)
                              Text(
                                  "${r.reviewLeaved.toString()} review leaved.")
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
