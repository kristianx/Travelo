import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';
import 'package:travelo_mobile/main.dart';
import 'package:travelo_mobile/model/agency.dart';
import 'package:travelo_mobile/model/destination.dart';
import 'package:travelo_mobile/model/trip.dart';
import 'package:travelo_mobile/providers/agency_provider.dart';
import 'package:travelo_mobile/providers/destination_provider.dart';
import 'package:travelo_mobile/utils/util.dart';

import '../providers/trip_provider.dart';
import 'destination.dart';

class SearchBarPageTemplate extends StatefulWidget {
  const SearchBarPageTemplate({super.key, required this.child});
  final Widget child;
  @override
  State<SearchBarPageTemplate> createState() => _SearchBarPageTemplateState();
}

class _SearchBarPageTemplateState extends State<SearchBarPageTemplate> {
  List<Destination> _searchHistory = [];
  static const historyLength = 5;
  late FloatingSearchBarController searchController;
  late DestinationProvider _destinationProvider;
  late TripProvider _tripProvider;
  late AgencyProvider _agencyProvider;
  bool currentlySearching = false;

  late List<Destination> searchDestinations = [];
  late List<Trip> searchTrips = [];
  late List<Agency> agencies = [];

  Future<List<Destination>> searchTripsAndDestinations(String? filter) async {
    setState(() {
      currentlySearching = true;
    });
    List<Destination> tmpDest = [];
    List<Agency> tmpAgency = [];
    if (filter != null && filter.isNotEmpty) {
      tmpDest = await _destinationProvider.get({"name": filter});
      tmpAgency = await _agencyProvider.get({'name': filter});
      setState(() {
        searchDestinations = tmpDest;
        agencies = tmpAgency;
      });
    }
    currentlySearching = false;
    return tmpDest;
  }

  void addSearchTerm(Destination destination) {
    if (_searchHistory.contains(destination)) {
      deleteSearchTerm(destination);
      addSearchTerm(destination);
      return;
    }
    _searchHistory.add(destination);
    if (_searchHistory.length > historyLength) {
      _searchHistory.removeRange(0, _searchHistory.length - historyLength);
      print("Removed by length");
    }
    localStorage.setItem("searchHistory", json.encode(_searchHistory));
    updateSearchHistory();
  }

  void deleteSearchTerm(Destination destination) {
    _searchHistory.removeWhere((element) => element.id == destination.id);
    localStorage.setItem("searchHistory", json.encode(_searchHistory));
    updateSearchHistory();
  }

  @override
  void initState() {
    super.initState();
    searchController = FloatingSearchBarController();
    updateSearchHistory();
    _destinationProvider = context.read<DestinationProvider>();
    _tripProvider = context.read<TripProvider>();
    _agencyProvider = context.read<AgencyProvider>();
  }

  void updateSearchHistory() {
    if (localStorage.getItem("searchHistory") != null) {
      setState(() {
        _searchHistory = List<Destination>.from(json
            .decode(localStorage.getItem("searchHistory"))
            .map<Destination>((dynamic i) => Destination.fromJson(i)));
        _searchHistory = _searchHistory.reversed.toList();
      });
      // json.decode(localStorage.getItem("searchHistory"));
      // json.decode(localStorage.getItem("searchHistory"));
      // print(json.decode(localStorage.getItem("searchHistory")));
      // _searchHistory = json.decode(localStorage.getItem("searchHistory"))
      //     as List<Destination>;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FloatingSearchBar(
      height: 55,
      progress: currentlySearching,
      hint: 'Search...',
      autocorrect: false,
      hintStyle: TextStyle(fontSize: 17, color: Color(0xffA8A8A8)),
      queryStyle: TextStyle(fontSize: 17, color: Color(0xff666666)),
      backdropColor: Colors.white,
      controller: searchController,
      iconColor: Color(0xff666666),
      automaticallyImplyBackButton: false,
      shadowColor: Colors.grey.withOpacity(0.25),
      padding: EdgeInsets.only(left: 20, right: 10),
      margins:
          EdgeInsets.fromLTRB(15, MediaQuery.of(context).padding.top, 15, 0),
      borderRadius: BorderRadius.all(Radius.circular(20)),
      actions: [FloatingSearchBarAction.searchToClear()],
      onQueryChanged: (query) {
        searchTripsAndDestinations(query);
      },
      onSubmitted: (query) {
        searchController.show();
        currentlySearching = false;
      },
      builder: (BuildContext context, Animation<double> transition) {
        return Builder(
          builder: (context) {
            if (_searchHistory.isEmpty && searchController.query.isEmpty) {
              return Container(
                height: 56,
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(
                  "Type something to start searching...",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            } else if (searchController.query.isEmpty &&
                _searchHistory.isNotEmpty) {
              return Column(children: _buildSearchList(_searchHistory, null));
            } else {
              return Column(
                children: _buildSearchList(null, null),
              );
            }
          },
        );
      },
      body: FloatingSearchBarScrollNotifier(child: widget.child),
    ));
  }

  List<Widget> _buildSearchList(
      List<Destination>? destinations, List<Agency>? agenciezs) {
    List<Widget> list = [];
    if (agencies.isNotEmpty) {
      list.add(Container(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10, top: 0),
          child: Row(
            children: [
              Container(
                width: 15,
                height: 30,
                decoration: BoxDecoration(
                    color: Color(0xffEAAD5F),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                "Agencies",
                style: TextStyle(color: Color(0xff292929), fontSize: 16),
              ),
            ],
          ),
        ),
      ));
      list += agencies
          .map((x) {
            return GestureDetector(
              onTap: () {
                // addSearchTerm(x);
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 7),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 0,
                        blurRadius: 5,
                        offset: Offset(0, 4))
                  ],
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.fromLTRB(7, 0, 15, 0),
                  leading: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                            image: x.image == ""
                                ? const AssetImage(
                                    "assets/images/imageHolder.png")
                                : imageFromBase64String(x.image!).image,
                            fit: BoxFit.cover)),
                  ),
                  title: Text(
                    x.name ?? "",
                    style: TextStyle(
                        fontSize: 15,
                        color: Color(0xff666666),
                        fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                    x.email ?? "",
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0xffBDBDBD),
                        fontWeight: FontWeight.w400),
                  ),
                  trailing: Text(
                    "AGENCY",
                    style: TextStyle(
                        fontSize: 15,
                        color: Color(0xffBDBDBD),
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            );
          })
          .cast<Widget>()
          .toList();
    }
    if (destinations != null) {
      list.add(Container(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10, top: 0),
          child: Row(
            children: [
              Container(
                width: 15,
                height: 30,
                decoration: BoxDecoration(
                    color: Color(0xffEAAD5F),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                "History",
                style: TextStyle(color: Color(0xff292929), fontSize: 16),
              ),
            ],
          ),
        ),
      ));
      list += _searchHistory
          .map((x) => GestureDetector(
                onTap: () {
                  addSearchTerm(x);
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
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 7),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 0,
                          blurRadius: 5,
                          offset: Offset(0, 4))
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.fromLTRB(7, 0, 15, 0),
                    leading: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          image: DecorationImage(
                              image: x.image == ""
                                  ? const AssetImage(
                                      "assets/images/imageHolder.png")
                                  : imageFromBase64String(x.image!).image,
                              fit: BoxFit.cover)),
                    ),
                    title: Text(
                      x.name ?? "",
                      style: TextStyle(
                          fontSize: 15,
                          color: Color(0xff666666),
                          fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      x.countryName ?? "",
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xffBDBDBD),
                          fontWeight: FontWeight.w400),
                    ),
                    trailing: Text(
                      "${x.numberOfTrips.toString()} TRIPS",
                      style: TextStyle(
                          fontSize: 15,
                          color: Color(0xffBDBDBD),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ))
          .cast<Widget>()
          .toList();
    } else if (searchDestinations.isEmpty) {
      list.add(Container(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10, top: 10),
          child: Row(
            children: [
              Container(
                width: 15,
                height: 30,
                decoration: BoxDecoration(
                    color: Color(0xffEAAD5F),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                "Destinations",
                style: TextStyle(color: Color(0xff292929), fontSize: 16),
              ),
            ],
          ),
        ),
      ));
      list.add(Container(
        height: 56,
        width: double.infinity,
        alignment: Alignment.center,
        child: Text(
          "There are no destinations for that criteria.",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ));
    } else {
      list.add(Container(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10, top: 10),
          child: Row(
            children: [
              Container(
                width: 15,
                height: 30,
                decoration: BoxDecoration(
                    color: Color(0xffEAAD5F),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                "Destinations",
                style: TextStyle(color: Color(0xff292929), fontSize: 16),
              ),
            ],
          ),
        ),
      ));
      list += searchDestinations
          .map((x) => GestureDetector(
                onTap: () {
                  addSearchTerm(x);
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
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 7),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 0,
                          blurRadius: 5,
                          offset: Offset(0, 4))
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.fromLTRB(7, 0, 15, 0),
                    leading: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          image: DecorationImage(
                              image: x.image == ""
                                  ? const AssetImage(
                                      "assets/images/imageHolder.png")
                                  : imageFromBase64String(x.image!).image,
                              fit: BoxFit.cover)),
                    ),
                    title: Text(
                      x.name ?? "",
                      style: TextStyle(
                          fontSize: 15,
                          color: Color(0xff666666),
                          fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      x.countryName ?? "",
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xffBDBDBD),
                          fontWeight: FontWeight.w400),
                    ),
                    trailing: Text(
                      "${x.numberOfTrips.toString()} TRIPS",
                      style: TextStyle(
                          fontSize: 15,
                          color: Color(0xffBDBDBD),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ))
          .cast<Widget>()
          .toList();
    }

    return list;
  }
}
