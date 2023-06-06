import 'package:flutter/cupertino.dart';
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
              color: i < rating ? const Color(0xffEAAD5F) : const Color(0xffD6D6D6)),
          const SizedBox(
            width: 5,
          ),
        ],
        Text("$rating.0",
            style: const TextStyle(fontSize: 14, color: Color(0xff616161)))
      ],
    );
  }
}
