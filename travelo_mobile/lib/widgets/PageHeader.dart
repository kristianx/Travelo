import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';

class PageHeader extends StatefulWidget {
  final String pageName;
  const PageHeader({super.key, required this.pageName});

  @override
  State<PageHeader> createState() => Page_HeaderState(pageName: pageName);
}

class Page_HeaderState extends State<PageHeader> {
  String pageName;

  Page_HeaderState({required this.pageName});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              pageName,
              style: TextStyle(
                  color: Color(0xff000000),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            // SvgPicture.asset("assets/icons/Search.svg")
          ],
        ),
      )
    ]);
  }
}
