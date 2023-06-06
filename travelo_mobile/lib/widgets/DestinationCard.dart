import 'package:flutter/material.dart';

class DestinationCard extends StatelessWidget {
  const DestinationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => const DestinationPage()),
        // )
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Container(
          height: 190,
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
              height: 190,
              alignment: Alignment.centerLeft,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15)),
                  image: DecorationImage(
                      image: AssetImage("assets/images/tulum.png"),
                      fit: BoxFit.cover)),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Tulum, Quintana Roo",
                              style: TextStyle(
                                  fontSize: 17, color: Color(0xff292929)),
                              softWrap: true,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis),
                          Text("Mexico",
                              style: TextStyle(
                                  fontSize: 15, color: Color(0xff989898)),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis)
                        ],
                      ),
                      const Text("From \$96 per person",
                          style: TextStyle(
                              fontSize: 15,
                              color: Color(0xffEAAD5F),
                              fontWeight: FontWeight.w500),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                      Text("21 trips".toUpperCase(),
                          style:
                              const TextStyle(fontSize: 15, color: Color(0xff989898)),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                      Wrap(
                        spacing: 7,
                        runSpacing: 7,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color(0xffE5F0F5),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 10),
                              child: Text("Summer",
                                  style: TextStyle(
                                      fontSize: 12, color: Color(0xff94B4C4)),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color(0xffE5F0F5),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 10),
                              child: Text("Surfing",
                                  style: TextStyle(
                                      fontSize: 12, color: Color(0xff94B4C4)),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color(0xffE5F0F5),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 10),
                              child: Text("Hot",
                                  style: TextStyle(
                                      fontSize: 12, color: Color(0xff94B4C4)),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis),
                            ),
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
