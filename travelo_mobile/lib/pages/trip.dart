import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';

import '../widgets/InputField.dart';

class Trip extends StatefulWidget {
  const Trip({super.key});

  @override
  State<Trip> createState() => _TripState();
}

class _TripState extends State<Trip> {
  @override
  var _value = "-1";
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
          height: 380,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/holistika.png"),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30))),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Holistika Resort",
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        Text("Tulum, Quintana Roo, Mexico",
                            style: TextStyle(
                                fontSize: 18,
                                color: Color(0xffE7EAEA),
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/icons/star.svg",
                              width: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("5.0",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text("172 reviews",
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.white.withOpacity(0.9),
                                fontWeight: FontWeight.w500)),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Transform.translate(
          offset: Offset(0, -20),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 0,
                              blurRadius: 5,
                              offset: Offset(0, 4))
                        ]),
                    child: DropdownButtonFormField(
                      value: _value,
                      items: [
                        DropdownMenuItem(
                            child: Text("16. Jun - 23. Jun 2023"), value: "-1"),
                        DropdownMenuItem(child: Text("Something"), value: "1"),
                        DropdownMenuItem(child: Text("Else"), value: "2"),
                        DropdownMenuItem(child: Text("naa"), value: "3"),
                      ],
                      onChanged: (v) {},
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          // width: 0.0 produces a thin "hairline" border
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Container(
                  width: 60,
                  height: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 0,
                            blurRadius: 5,
                            offset: Offset(0, 4))
                      ]),
                  child: SvgPicture.asset("assets/icons/Bookmarks.svg"),
                )
              ],
            ),
          ),
        ),
        Column(children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Divider(
              indent: 15,
              endIndent: 15,
              height: 1,
            ),
          ),
          Container(
            height: 75,
            child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(left: 20, right: 20),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Container(
                      height: 75,
                      width: 75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xffF8F8F8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset("assets/icons/surfing.svg"),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Surfing",
                            style: TextStyle(
                              color: Color(0xff6B6B6B),
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  ),
                ]),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Text(
                "This relaxed hotel in a lush jungle setting on the outskirts of Tulum is 7 km from both the white sand Paradise Beach on the Caribbean Sea, and the Zona Arqueológica de Tulum Mayan ruins.\n\nThe laid-back, 12-bed dorms have bunk beds, air-conditioning and Wi-Fi access. Private rooms add balconies, indoor hammocks and minifridges.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  color: Color(0xff5E5E5E),
                  fontWeight: FontWeight.w400,
                )),
          ),
        ]),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            height: 70,
            decoration: BoxDecoration(
                color: Color(0xffEAAD5F),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 0,
                      blurRadius: 5,
                      offset: Offset(0, 4))
                ]),
            child: Center(
                child: Text(
              "Book now for \$1256",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 20),
            )),
          ),
        )
      ]),
    );
  }
}
