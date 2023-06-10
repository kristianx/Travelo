import 'package:flutter/material.dart';

import '../models/trip.dart';

class OfferPage extends StatefulWidget {
  OfferPage({super.key, required this.trip});

  Trip? trip;

  @override
  State<OfferPage> createState() => _OfferPageState();
}

class _OfferPageState extends State<OfferPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        widget.trip!.accomodationName ?? "-",
      ),
    );
  }
}
