import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:travelo_mobile/pages/payment_settings.dart';
import 'package:travelo_mobile/providers/paymentMethod_provider.dart';
import '../main.dart';
import '../services/payment_service.dart';
import '../widgets/CustomSnackBar.dart';
import '../widgets/InputField.dart';
import '../widgets/PageHeader.dart';
import '../widgets/SimpleButton.dart';

class NewPaymentMethod extends StatefulWidget {
  const NewPaymentMethod({super.key});

  @override
  State<NewPaymentMethod> createState() => _NewPaymentMethodState();
}

class _NewPaymentMethodState extends State<NewPaymentMethod> {
  late PaymentMethodProvider _paymentMethodProvider;

  @override
  void initState() {
    super.initState();
    _paymentMethodProvider = context.read<PaymentMethodProvider>();
    loadData();
  }

  Future loadData() async {
    // var tmpData = await _paymentMethodProvider
    //     .get({'UserId': localStorage.getItem("userId")});
    // setState(() {
    //   paymentMethods = tmpData;
    // });
  }

  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _holderNameController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _monthController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final paymentController = PaymentController();
    return Scaffold(
      body: SafeArea(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.go("/payment");
                    },
                    child: const Icon(
                      Icons.arrow_back_ios_rounded,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "New Payment Method",
                    style: TextStyle(
                        color: Color(0xff000000),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  // SvgPicture.asset("assets/icons/Search.svg")
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  InputField(
                    controller: _cardNumberController,
                    hintText: 'Card number',
                  ),
                  const SizedBox(height: 15),
                  InputField(
                    controller: _holderNameController,
                    hintText: 'Card holder',
                  ),
                  const SizedBox(height: 15),
                  InputField(
                    controller: _addressController,
                    hintText: 'Address',
                  ),
                  const SizedBox(height: 15),
                  InputField(
                    controller: _cvvController,
                    hintText: 'Cvv',
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: InputField(
                          controller: _monthController,
                          hintText: 'MM',
                        ),
                      ),
                      Text("/"),
                      Expanded(
                        child: InputField(
                          controller: _yearController,
                          hintText: 'YY',
                        ),
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            SimpleButton(
              onTap: () async {
                if (_cardNumberController.text != "" &&
                    _holderNameController.text != "" &&
                    _addressController.text != "" &&
                    _cvvController.text != "" &&
                    _monthController.text != "" &&
                    _yearController.text != "") {
                  try {
                    // final _customer = await paymentController
                    //     .createCustomer(_holderNameController.text);
                    // final _paymentMethod =
                    //     await paymentController.createPaymentMethod(
                    //         cvc: _cvvController.text,
                    //         expMonth: _monthController.text,
                    //         expYear: _yearController.text,
                    //         number: _cardNumberController.text);
                    // await paymentController.attachPaymentMethod(
                    //     _paymentMethod['id'], _customer!['id']);

                    var flag = await _paymentMethodProvider.insert({
                      "CardNumber": _cardNumberController.text,
                      "HolderName": _holderNameController.text,
                      "Address": _addressController.text,
                      "Cvv": _cvvController.text,
                      "ExpDate":
                          "${_monthController.text}/${_yearController.text}",
                      "UserId": localStorage.getItem("userId"),
                    });

                    if (flag != null) {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (_) => const PaymentSettings()));
                      context.go('/payment');
                    }
                  } catch (e) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: const Text("Error"),
                              content: Text(e.toString()),
                              actions: [
                                TextButton(
                                  child: const Text("Ok"),
                                  onPressed: () => Navigator.pop(context),
                                )
                              ],
                            ));
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      CustomSnackBar.showErrorSnackBar(
                          "Please fill in the details."));
                }
              },
              bgColor: const Color(0xffEAAD5F),
              textColor: Colors.white,
              text: "Add new payment method",
              width: 300,
              height: 70,
            )
          ])),
    );
  }
}
