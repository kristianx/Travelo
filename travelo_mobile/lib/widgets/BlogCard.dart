import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

class BlogCard extends StatelessWidget {
  final String name;
  final String date;
  final String location;
  final String image;

  const BlogCard(
      {super.key,
      required this.name,
      required this.date,
      required this.image,
      required this.location});

  @override
  Widget build(BuildContext context) {
    return Padding(
      // padding: const EdgeInsets.only(left: 15),
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
      child: Container(
        width: 400,
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
            width: 130,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15)),
                image: DecorationImage(
                    image: AssetImage(image), fit: BoxFit.cover)),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              width: 240,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(date,
                      style: TextStyle(fontSize: 15, color: Color(0xff666666)),
                      softWrap: true,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis),
                  Text(name,
                      style: TextStyle(fontSize: 17, color: Color(0xff474747)),
                      softWrap: true,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis),
                  Row(
                    children: [
                      SvgPicture.asset("assets/icons/location.svg"),
                      SizedBox(width: 7),
                      Text(location,
                          style:
                              TextStyle(fontSize: 12, color: Color(0xff989898)),
                          softWrap: true,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
