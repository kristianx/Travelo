import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';

import '../../widgets/PageHeader.dart';

class TripInvoices extends StatefulWidget {
  const TripInvoices({super.key});

  @override
  State<TripInvoices> createState() => _TripInvoicesState();
}

class _TripInvoicesState extends State<TripInvoices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          PageHeader(
            pageName: "Trip invoices",
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
                            "Today",
                            style: TextStyle(color: Color(0xff8E8E8E)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 10, left: 20, right: 20),
                      child: Container(
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
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(
                                'Holistika Resort with Travelo Agency',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xff585858),
                                ),
                                softWrap: true,
                              )),
                              SvgPicture.asset("assets/icons/download.svg")
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      )),
    );
    ;
  }
}
