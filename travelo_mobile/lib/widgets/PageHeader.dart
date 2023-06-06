import 'package:flutter/cupertino.dart';

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
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              pageName,
              style: const TextStyle(
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
