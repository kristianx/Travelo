import 'package:flutter/material.dart';
import 'package:travelo_mobile/widgets/TripCard.dart';

import '../../widgets/PageHeader.dart';

class BookmarksPage extends StatelessWidget {
  const BookmarksPage({super.key});

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
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Row(
                        children: [
                          Container(
                            width: 15,
                            height: 30,
                            decoration: BoxDecoration(
                                color: Color(0xffEAAD5F),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10))),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "16. Jun - 23. Jun 2022",
                            style: TextStyle(color: Color(0xff8E8E8E)),
                          ),
                        ],
                      ),
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
                  ],
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
