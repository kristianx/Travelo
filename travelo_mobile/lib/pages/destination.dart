import 'package:flutter/material.dart';
import 'package:travelo_mobile/widgets/TripCard.dart';

import '../widgets/InputField.dart';

class DestinationPage extends StatefulWidget {
  const DestinationPage({super.key});

  @override
  State<DestinationPage> createState() => _DestinationPageState();
}

class _DestinationPageState extends State<DestinationPage> {
  TextEditingController _dummyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          height: 240,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/tulum-bg.png"),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30))),
          child: SafeArea(
            bottom: false,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InputField(
                  hintText: 'Search trips',
                  iconPath: 'assets/icons/Search.svg',
                  controller: _dummyController,
                ),
                const SizedBox(height: 20),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Tulum, Quintana Roo",
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                          Text("Mexico",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xffE7EAEA),
                                  fontWeight: FontWeight.w400)),
                        ],
                      ),
                      Text("21 TRIPS",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: 10,
                ),
                TripCard(
                  agency: 'Travelo Agency',
                  bookmarked: false,
                  datesString: '16.Jun - 23. Jun 2022',
                  description:
                      'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur,',
                  destination: 'Tulum, Mexico',
                  price: 1256,
                  rating: 4,
                  resort: 'Holistika resort',
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }
}
