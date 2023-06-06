import 'package:flutter/material.dart';

class MyTripCard extends StatelessWidget {
  final String name;
  final String agency;
  final String location;
  final String price;
  final String image;

  const MyTripCard(
      {super.key,
      required this.name,
      required this.agency,
      required this.price,
      required this.image,
      required this.location});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => const Trip()),
        // )
      },
      child: Padding(
        // padding: const EdgeInsets.only(left: 15),
        padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
        child: Container(
          height: 170,
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
                      image: AssetImage(image), fit: BoxFit.cover)),
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
                            Text(name,
                                style: const TextStyle(
                                    fontSize: 17, color: Color(0xff292929)),
                                softWrap: true,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis),
                            Text(location,
                                style: const TextStyle(
                                    fontSize: 13, color: Color(0xffA9A9A9)),
                                softWrap: false,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis),
                          ],
                        ),
                        const Text("5.0",
                            style: TextStyle(
                                fontSize: 17, color: Color(0xff616161)))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(price,
                            style: const TextStyle(
                                fontSize: 20,
                                color: Color(0xff747474),
                                fontWeight: FontWeight.w500),
                            softWrap: false,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                        Row(
                          children: [
                            Text(agency,
                                style: const TextStyle(
                                    fontSize: 12, color: Color(0xff828282)),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
