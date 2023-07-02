import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelo_mobile/widgets/TripCard.dart';

import '../../main.dart';
import '../../model/trip.dart';
import '../../providers/trip_provider.dart';
import '../../widgets/PageHeader.dart';

class BookmarksPage extends StatefulWidget {
  const BookmarksPage({super.key});

  @override
  State<BookmarksPage> createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage> {
  late TripProvider _tripProvider;
  List<Trip> trips = [];

  @override
  void initState() {
    super.initState();
    _tripProvider = context.read<TripProvider>();
    loadData();
  }

  Future loadData() async {
    var tmpData =
        await _tripProvider.getBookmarks(localStorage.getItem("userId"));
    setState(() {
      trips = tmpData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          PageHeader(
            pageName: "Bookmarks",
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _buildTripCardList(),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }

  List<Widget> _buildTripCardList() {
    if (trips.isEmpty) {
      //Add loading for few seconds and if no data then text.
      return [const Center(child: Text("There are no saved trips."))];
    }
    List<Widget> list = [];
    // list.add(const SizedBox(
    //   height: 10,
    // ));
    list += trips
        .map((trip) => TripCard(
              trip: trip,
              bookmarked: true,
              bookmarkCallBack: loadData,
            ))
        .cast<Widget>()
        .toList();
    list.add(const SizedBox(
      height: 20,
    ));
    return list;
  }
}
