import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:travelo_mobile/providers/paymentMethod_provider.dart';
import '../main.dart';
import '../model/paymentMethod.dart';
import '../widgets/CustomSnackBar.dart';
import '../widgets/PageHeader.dart';

import '../widgets/SimpleButton.dart';
import 'navpages/profile_page.dart';

class PaymentSettings extends StatefulWidget {
  const PaymentSettings({super.key});

  @override
  State<PaymentSettings> createState() => _PaymentSettingsState();
}

class _PaymentSettingsState extends State<PaymentSettings> {
  late PaymentMethodProvider _paymentMethodProvider;
  List<PaymentMethod> paymentMethods = [];

  @override
  void initState() {
    super.initState();
    _paymentMethodProvider = context.read<PaymentMethodProvider>();
    loadData();
  }

  Future loadData() async {
    var tmpData = await _paymentMethodProvider
        .get({'UserId': localStorage.getItem("userId")});
    setState(() {
      paymentMethods = tmpData;
    });
    print(paymentMethods.first.cardNumber);
  }

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
            Column(
              children: _buildPaymentMethods(),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
            //   child: Container(
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(15),
            //         color: const Color(0xffEAAD5F),
            //         boxShadow: [
            //           BoxShadow(
            //             color: Colors.grey.withOpacity(0.2),
            //             spreadRadius: 0,
            //             blurRadius: 5,
            //             offset: const Offset(0, 4),
            //           ),
            //         ]),
            //     child: Padding(
            //       padding: const EdgeInsets.fromLTRB(7, 7, 15, 7),
            //       child: Row(
            //         children: [
            //           Container(
            //             height: 55,
            //             width: 70,
            //             decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(10),
            //               color: const Color(0xffffffff),
            //             ),
            //             child: Center(
            //                 child: Image.asset("assets/images/paypal.png")),
            //           ),
            //           const SizedBox(
            //             width: 15,
            //           ),
            //           const Expanded(
            //               child: Text(
            //             'mar**@gmail.com',
            //             style: TextStyle(
            //                 fontSize: 15,
            //                 color: Color(0xffffffff),
            //                 fontWeight: FontWeight.w600),
            //             softWrap: true,
            //           )),
            //           const SizedBox(
            //             width: 15,
            //           ),
            //           const Text(
            //             "DEFAULT",
            //             style: TextStyle(
            //                 fontSize: 12,
            //                 color: Color(0xffffffff),
            //                 fontWeight: FontWeight.w400),
            //           )
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
            //   child: Container(
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(15),
            //         color: const Color(0xffffffff),
            //         boxShadow: [
            //           BoxShadow(
            //             color: Colors.grey.withOpacity(0.2),
            //             spreadRadius: 0,
            //             blurRadius: 5,
            //             offset: const Offset(0, 4),
            //           ),
            //         ]),
            //     child: Padding(
            //       padding: const EdgeInsets.fromLTRB(7, 7, 15, 7),
            //       child: Row(
            //         children: [
            //           Container(
            //             height: 55,
            //             width: 70,
            //             decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(10),
            //               color: const Color(0xffffffff),
            //             ),
            //             child: Center(
            //                 child: Image.asset("assets/images/visa.png")),
            //           ),
            //           const SizedBox(
            //             width: 15,
            //           ),
            //           const Expanded(
            //               child: Text(
            //             '**** **** **** 6132',
            //             style: TextStyle(
            //                 fontSize: 15,
            //                 color: Color(0xff454F63),
            //                 fontWeight: FontWeight.w600),
            //             softWrap: true,
            //           )),
            //           const SizedBox(
            //             width: 15,
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
            //   child: Container(
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(15),
            //         color: const Color(0xffffffff),
            //         boxShadow: [
            //           BoxShadow(
            //             color: Colors.grey.withOpacity(0.2),
            //             spreadRadius: 0,
            //             blurRadius: 5,
            //             offset: const Offset(0, 4),
            //           ),
            //         ]),
            //     child: Padding(
            //       padding: const EdgeInsets.fromLTRB(7, 7, 15, 7),
            //       child: Row(
            //         children: [
            //           Container(
            //             height: 55,
            //             width: 70,
            //             decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(10),
            //               color: const Color(0xffffffff),
            //             ),
            //             child: Center(
            //                 child: Image.asset("assets/images/mastercard.png")),
            //           ),
            //           const SizedBox(
            //             width: 15,
            //           ),
            //           const Expanded(
            //               child: Text(
            //             '**** **** **** 7583',
            //             style: TextStyle(
            //                 fontSize: 15,
            //                 color: Color(0xff454F63),
            //                 fontWeight: FontWeight.w600),
            //             softWrap: true,
            //           )),
            //           const SizedBox(
            //             width: 15,
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),

            const SizedBox(
              height: 50,
            ),
            // GestureDetector(
            //   onTap: () => {context.go("/new-payment-method")},
            //   child: Padding(
            //     padding:
            //         const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         SvgPicture.asset("assets/icons/plus.svg"),
            //         const SizedBox(
            //           width: 15,
            //         ),
            //         const Text(
            //           "Add new payment method",
            //           style: TextStyle(
            //               fontSize: 14,
            //               color: Color(0xff454F63),
            //               fontWeight: FontWeight.w500),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            SimpleButton(
              onTap: () => {context.go("/new-payment-method")},
              bgColor: const Color(0xffEAAD5F),
              textColor: Colors.white,
              text: "Add new payment method",
              width: 300,
              height: 70,
            )
          ])),
    );
  }

  List<Widget> _buildPaymentMethods() {
    if (paymentMethods.isEmpty) {
      return [
        Padding(
          padding: const EdgeInsets.only(top: 40, bottom: 60),
          child: const Center(child: Text("There are no payment methods.")),
        )
      ];
    } else {
      return paymentMethods
          .map((x) => Padding(
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
                            child: Image.asset(
                                "assets/images/${x.cardType!.toLowerCase()}.png"),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                            child: Text(
                          "**** **** **** ${x.lastDigits ?? '****'}",
                          style: const TextStyle(
                              fontSize: 15,
                              color: Color(0xff454F63),
                              fontWeight: FontWeight.w600),
                          softWrap: true,
                        )),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          x.primary != null && x.primary == true
                              ? "DEFAULT"
                              : "",
                          style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xffffffff),
                              fontWeight: FontWeight.w400),
                        ),
                        GestureDetector(
                          onTap: () async {
                            bool flag =
                                await _paymentMethodProvider.delete(x.id!);
                            if (flag) {
                              loadData();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  CustomSnackBar.showSuccessSnackBar(
                                      "You have successfuly deleted this payment method."));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  CustomSnackBar.showErrorSnackBar(
                                      "Something went wrong, please try again."));
                            }
                          },
                          child: Center(
                              child: SvgPicture.asset(
                            'assets/icons/trash.svg',
                            height: 25,
                          )),
                        )
                      ],
                    ),
                  ),
                ),
              ))
          .cast<Widget>()
          .toList();
    }
  }
}
