import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';

class ReviewStars extends StatelessWidget {
  final int rating;

  const ReviewStars({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (int i = 0; i < 5; i++) ...[
          SvgPicture.asset("assets/icons/star.svg",
              color: i < rating ? Color(0xffEAAD5F) : Color(0xffD6D6D6)),
          SizedBox(
            width: 5,
          ),
        ],
        Text(rating.toString() + ".0",
            style: TextStyle(fontSize: 14, color: Color(0xff616161)))
      ],
    );
  }
}
