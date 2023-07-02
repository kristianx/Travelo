import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PageHeader extends StatefulWidget {
  final String pageName;
  final BuildContext? backContext;
  PageHeader({super.key, required this.pageName, this.backContext});

  @override
  State<PageHeader> createState() =>
      Page_HeaderState(pageName: pageName, backContext: backContext);
}

class Page_HeaderState extends State<PageHeader> {
  String pageName;
  final BuildContext? backContext;
  Page_HeaderState({required this.pageName, this.backContext});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
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
    );
  }
}
