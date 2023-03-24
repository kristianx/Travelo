import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:travelo_mobile/widgets/ReviewStars.dart';

import '../pages/trip.dart';

class TripCard extends StatelessWidget {
  final String resort;
  final String destination;
  final String datesString;
  final int rating;
  final String description;
  final int price;
  final String agency;
  final bool bookmarked;

  const TripCard(
      {super.key,
      required this.resort,
      required this.destination,
      required this.rating,
      required this.description,
      required this.price,
      required this.agency,
      required this.bookmarked,
      required this.datesString});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Trip()),
        )
      },
      child: Padding(
        // padding: const EdgeInsets.only(left: 15),
        padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
        child: Container(
          height: 250,
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
              width: 150,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  image: DecorationImage(
                      image: AssetImage("assets/images/tulum.png"),
                      fit: BoxFit.cover)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(200)),
                                image: DecorationImage(
                                    image:
                                        AssetImage("assets/images/tulum.png"),
                                    fit: BoxFit.cover))),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          agency,
                          style: TextStyle(
                              fontSize: 12,
                              color: Color(0xffffffff),
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 20, 10),
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(resort,
                                  style: TextStyle(
                                      fontSize: 17, color: Color(0xff292929)),
                                  softWrap: true,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis),
                              Text(destination,
                                  style: TextStyle(
                                      fontSize: 13, color: Color(0xffA9A9A9)),
                                  softWrap: false,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis),
                            ],
                          ),
                          SvgPicture.asset(
                            "assets/icons/Bookmarks.svg",
                            color: bookmarked
                                ? Color(0xffEAAD5F)
                                : Color(0xffD6D6D6),
                          )
                        ],
                      ),
                      SizedBox(height: 5),
                      ReviewStars(rating: 1),
                      SizedBox(height: 5),
                      Text(datesString,
                          style:
                              TextStyle(fontSize: 15, color: Color(0xffA9A9A9)),
                          softWrap: false,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                      Divider(
                        height: 20,
                      ),
                      Expanded(
                        child: Text(
                          description,
                          style:
                              TextStyle(fontSize: 11, color: Color(0xff000000)),
                          softWrap: true,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("\$" + price.toString(),
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xff747474),
                                  fontWeight: FontWeight.w500),
                              softWrap: false,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 25),
                            decoration: BoxDecoration(
                                color: Color(0xffEAAD5F),
                                borderRadius: BorderRadius.circular(10)),
                            child: Text("Book trip",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color(0xffffffff),
                                    fontWeight: FontWeight.w500),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis),
                          ),
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
    );
  }
}
