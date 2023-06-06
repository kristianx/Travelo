import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../widgets/PageHeader.dart';
import '../widgets/SimpleButton.dart';
import 'navpages/profile_page.dart';

class PaymentSettings extends StatefulWidget {
  const PaymentSettings({super.key});

  @override
  State<PaymentSettings> createState() => _PaymentSettingsState();
}

class _PaymentSettingsState extends State<PaymentSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
            const PageHeader(
              pageName: "Payment settings",
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xffEAAD5F),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 0,
                        blurRadius: 5,
                        offset: const Offset(0, 4),
                      ),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(7, 7, 15, 7),
                  child: Row(
                    children: [
                      Container(
                        height: 55,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xffffffff),
                        ),
                        child: Center(
                            child: Image.asset("assets/images/paypal.png")),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Expanded(
                          child: Text(
                        'mar**@gmail.com',
                        style: TextStyle(
                            fontSize: 15,
                            color: Color(0xffffffff),
                            fontWeight: FontWeight.w600),
                        softWrap: true,
                      )),
                      const SizedBox(
                        width: 15,
                      ),
                      const Text(
                        "DEFAULT",
                        style: TextStyle(
                            fontSize: 12,
                            color: Color(0xffffffff),
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xffffffff),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 0,
                        blurRadius: 5,
                        offset: const Offset(0, 4),
                      ),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(7, 7, 15, 7),
                  child: Row(
                    children: [
                      Container(
                        height: 55,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xffffffff),
                        ),
                        child: Center(
                            child: Image.asset("assets/images/visa.png")),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Expanded(
                          child: Text(
                        '**** **** **** 6132',
                        style: TextStyle(
                            fontSize: 15,
                            color: Color(0xff454F63),
                            fontWeight: FontWeight.w600),
                        softWrap: true,
                      )),
                      const SizedBox(
                        width: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xffffffff),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 0,
                        blurRadius: 5,
                        offset: const Offset(0, 4),
                      ),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(7, 7, 15, 7),
                  child: Row(
                    children: [
                      Container(
                        height: 55,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xffffffff),
                        ),
                        child: Center(
                            child: Image.asset("assets/images/mastercard.png")),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Expanded(
                          child: Text(
                        '**** **** **** 7583',
                        style: TextStyle(
                            fontSize: 15,
                            color: Color(0xff454F63),
                            fontWeight: FontWeight.w600),
                        softWrap: true,
                      )),
                      const SizedBox(
                        width: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/icons/plus.svg"),
                  const SizedBox(
                    width: 15,
                  ),
                  const Text(
                    "Add new payment method",
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff454F63),
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            SimpleButton(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
              bgColor: const Color(0xffEAAD5F),
              textColor: Colors.white,
              text: "Save",
              width: 300,
              height: 70,
            )
          ])),
    );
  }
}
