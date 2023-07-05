import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:travelo_mobile/main.dart';
import 'package:travelo_mobile/pages/trip.dart';
import 'package:travelo_mobile/widgets/ReviewStars.dart';
import 'package:travelo_mobile/model/trip.dart' as trip_model;
import '../providers/trip_provider.dart';
import '../utils/util.dart';

class TripCard extends StatefulWidget {
  final trip_model.Trip trip;
  late bool bookmarked;
  late Function? bookmarkCallBack;

  TripCard(
      {super.key,
      required this.trip,
      this.bookmarked = false,
      this.bookmarkCallBack});

  @override
  State<TripCard> createState() => _TripCardState();
}

class _TripCardState extends State<TripCard> {
  late TripProvider _tripProvider;

  @override
  void initState() {
    super.initState();
    _tripProvider = context.read<TripProvider>();
  }

  Future addBookmark() async {
    var tmp = await _tripProvider.toggleBookmark(
        widget.trip.id ?? -1, localStorage.getItem("userId"));
    setState(() {
      widget.bookmarked = tmp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        // context.goNamed(
        //   'Trip',
        //   queryParameters: {"bookmarked": widget.bookmarked ? 'true' : 'false'},
        //   extra: widget.trip,
        // )
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => Trip(
                  bookmarked: widget.bookmarked ? true : false,
                  trip: widget.trip,
                )))

        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => Trip(
        //             bookmarked: widget.bookmarked ? true : false,
        //             trip: widget.trip,
        //           )),
        // )
      },
      child: Padding(
        // padding: const EdgeInsets.only(left: 15),
        padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
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
                  offset: const Offset(0, 4),
                ),
              ]),
          child: Row(children: [
            Container(
              width: 150,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  image: DecorationImage(
                      image: widget.trip.accomodationImage == ""
                          ? const AssetImage("assets/images/imageHolder.png")
                          : imageFromBase64String(
                                  widget.trip.accomodationImage!)
                              .image,
                      fit: BoxFit.cover)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.goNamed("Agency", extra: widget.trip.agencyId);
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (_) => AgencyPage(
                      //           agencyId: widget.trip.agencyId ?? -1,
                      //         )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(200)),
                                  image: DecorationImage(
                                      image: widget.trip.agencyImage == ""
                                          ? const AssetImage(
                                              "assets/images/imageHolder.png")
                                          : imageFromBase64String(
                                                  widget.trip.agencyImage!)
                                              .image,
                                      fit: BoxFit.cover))),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            widget.trip.agencyName ?? "",
                            style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xffffffff),
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
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
                              Text(widget.trip.accomodationName ?? "",
                                  style: const TextStyle(
                                      fontSize: 17, color: Color(0xff292929)),
                                  softWrap: true,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis),
                              Text(widget.trip.countryName ?? "",
                                  style: const TextStyle(
                                      fontSize: 13, color: Color(0xffA9A9A9)),
                                  softWrap: false,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              addBookmark().then((value) => {
                                    if (widget.bookmarkCallBack != null)
                                      {widget.bookmarkCallBack!()}
                                  });
                            },
                            child: SvgPicture.asset(
                              "assets/icons/Bookmarks.svg",
                              color: widget.bookmarked
                                  ? const Color(0xffEAAD5F)
                                  : const Color(0xffD6D6D6),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 5),
                      ReviewStars(rating: widget.trip.rating!),
                      const SizedBox(height: 5),
                      Text(widget.trip.dates ?? "",
                          style: const TextStyle(
                              fontSize: 15, color: Color(0xffA9A9A9)),
                          softWrap: false,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                      const Divider(
                        height: 20,
                      ),
                      Expanded(
                        child: Text(
                          widget.trip.accomodationDescription ?? "",
                          style: const TextStyle(
                              fontSize: 11, color: Color(0xff000000)),
                          softWrap: true,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("\$${widget.trip.lowestPrice.toString()}/night",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xff747474),
                                  fontWeight: FontWeight.w500),
                              softWrap: false,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 25),
                            decoration: BoxDecoration(
                                color: const Color(0xffEAAD5F),
                                borderRadius: BorderRadius.circular(10)),
                            child: const Text("Book trip",
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
