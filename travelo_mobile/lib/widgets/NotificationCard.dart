import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
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
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xffE5F0F5),
                ),
                child: Center(child: SvgPicture.asset("assets/icons/bell.svg")),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                  child: Text(
                'Your trip to Holistika Resort is in 3 days!',
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xff585858),
                ),
                softWrap: true,
              ))
            ],
          ),
        ),
      ),
    );
  }
}
