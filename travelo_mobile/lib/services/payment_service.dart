import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:travelo_mobile/.env';
import 'package:travelo_mobile/main.dart';

import '../model/city.dart';
import '../model/user.dart';
import '../providers/city_provider.dart';
import '../providers/user_provider.dart';
import '../widgets/CustomSnackBar.dart';

class PaymentController extends GetxController {
  Map<String, dynamic>? paymentIntentData;

  Future<bool> makePayment(
      {required String amount, required String currency}) async {
    try {
      final customer = await createCustomer(null);

      paymentIntentData =
          await _createPaymentIntents(amount, currency, customer!['id']);
      if (paymentIntentData != null) {
        await displayPaymentSheet(paymentIntentData!['client_secret']);
        return true;
      }
    } catch (e, s) {
      print('exception:$e$s');
      return false;
    }
    return false;
  }

  Future<Map<String, dynamic>> _createPaymentIntents(
      String amount, String currency, String customerId) async {
    final String url = 'https://api.stripe.com/v1/payment_intents';

    Map<String, dynamic> body = {
      'amount': calculateAmount(amount),
      'currency': currency,
      'payment_method_types[]': 'card',
      'customer': customerId
    };

    var response = await http.post(Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $stripPrivateKey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw 'Failed to create PaymentIntents.';
    }
  }

  Future<void> subscriptions() async {
    // final _customer = await createCustomer();
    // final _paymentMethod = await createPaymentMethod(
    //     number: '4242424242424242', expMonth: '03', expYear: '23', cvc: '123');
    // await _attachPaymentMethod(_paymentMethod['id'], _customer['id']);
    // await _updateCustomer(_paymentMethod['id'], _customer['id']);
    // await _createSubscriptions(_customer['id']);
  }

  // Future<bool> makePayment(
  //     {required String amount, required String currency}) async {
  //   try {
  //     paymentIntentData = await _createPaymentIntent(amount, currency);
  //     if (paymentIntentData != null) {
  //       await displayPaymentSheet();
  //       return true;
  //     }
  //   } catch (e, s) {
  //     print('exception:$e$s');
  //     return false;
  //   }
  //   return false;
  // }

  displayPaymentSheet(String clientSecret) async {
    final customer = await createCustomer(null);
    final ephemeralKey = await createEphemeralKey(customer!['id']);

    try {
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              customFlow: true,
              merchantDisplayName: 'Travelo',
              customerId: customer['id'],
              customerEphemeralKeySecret: ephemeralKey['secret'],
              paymentIntentClientSecret: clientSecret,
              appearance: PaymentSheetAppearance(
                  colors: PaymentSheetAppearanceColors(
                background: Colors.white,
                primary: Colors.black,
              ))));
    } catch (e) {
      print("Error: $e");
      rethrow;
    }

    await Stripe.instance.presentPaymentSheet();
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }

  Future<dynamic> createEphemeralKey(String customerId) async {
    final response = await http
        .post(Uri.parse('https://api.stripe.com/v1/ephemeral_keys'), headers: {
      'Authorization': 'Bearer $stripPrivateKey',
      'Content-Type': 'application/x-www-form-urlencoded',
      "Stripe-Version": '2022-11-15'
    }, body: {
      "customer": customerId,
    });
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw 'Failed.';
    }
  }

  Future<Map<String, dynamic>?> createCustomer(String? holderName) async {
    User user = await UserProvider().getById(localStorage.getItem("userId"));
    City city = await CityProvider().getById(user.cityId ?? -1);
    var customers = await doesCustomerExist(user.email ?? "");
    if (customers.isEmpty) {
      var body = {
        'name': holderName != null
            ? holderName
            : "${user.firstName} ${user.lastName}",
        'email': user.email,
      };

      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/customers'),
          body: body,
          headers: {
            'Authorization': 'Bearer $stripPrivateKey',
            'Content-Type': 'application/x-www-form-urlencoded'
          });

      if (response.statusCode == 200) {
        print(json.decode(response.body));
        return json.decode(response.body);
      } else {
        print(json.decode(response.body));
        throw 'Failed to register as a customer.';
      }
    } else {
      return customers[0];
    }
  }

  Future<void> _createCreditCard(
      String customerId, String paymentIntentClientSecret) async {
    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
      merchantDisplayName: 'Travelo',
      customerId: customerId,
      paymentIntentClientSecret: paymentIntentClientSecret,
    ));

    await Stripe.instance.presentPaymentSheet();
  }

  // Future<void> payment(
  //     {required String amount, required String currency}) async {
  //   final _customer = await createCustomer();
  //   final _paymentIntent = await _createPaymentIntents(amount, currency);
  //   await _createCreditCard(_customer['id'], _paymentIntent['client_secret']);
  // }

  Future<Map<String, dynamic>> createPaymentMethod(
      {required String number,
      required String expMonth,
      required String expYear,
      required String cvc}) async {
    final String url = 'https://api.stripe.com/v1/payment_methods';
    var response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $stripPrivateKey',
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      body: {
        'type': 'card',
        'card[number]': '$number',
        'card[exp_month]': '$expMonth',
        'card[exp_year]': '$expYear',
        'card[cvc]': '$cvc',
      },
    );
    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return json.decode(response.body);
    } else {
      print(json.decode(response.body));
      throw 'Failed to create PaymentMethod.';
    }
  }

  Future<Map<String, dynamic>> attachPaymentMethod(
      String paymentMethodId, String customerId) async {
    final String url =
        'https://api.stripe.com/v1/payment_methods/$paymentMethodId/attach';
    var response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $stripPrivateKey',
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      body: {
        'customer': customerId,
      },
    );
    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return json.decode(response.body);
    } else {
      print(json.decode(response.body));
      throw 'Failed to attach PaymentMethod.';
    }
  }

  Future<Map<String, dynamic>> _updateCustomer(
      String paymentMethodId, String customerId) async {
    final String url = 'https://api.stripe.com/v1/customers/$customerId';

    var response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $stripPrivateKey',
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      body: {
        'invoice_settings[default_payment_method]': paymentMethodId,
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(json.decode(response.body));
      throw 'Failed to update Customer.';
    }
  }

  // Future<Map<String, dynamic>?> createPaymentIntent(
  //     String amount, String currency) async {
  //   try {
  //     Map<String, dynamic> body = {
  //       'amount': calculateAmount(amount),
  //       'currency': currency,
  //       'payment_method_types[]': 'card',
  //       // "customer": localStorage.getItem("userId").toString(),
  //     };
  //     var response = await http.post(
  //         Uri.parse('https://api.stripe.com/v1/payment_intents'),
  //         body: body,
  //         headers: {
  //           'Authorization': 'Bearer $stripPrivateKey',
  //           'Content-Type': 'application/x-www-form-urlencoded'
  //         });
  //     return jsonDecode(response.body);
  //   } catch (err) {
  //     print('err charging user: ${err.toString()}');
  //     return null;
  //   }
  // }
  Future<Map<String, String>> createHeaders() async {
    var headers = {
      'Authorization': 'Bearer $stripPrivateKey',
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    return headers;
  }

  Future<dynamic> doesCustomerExist(String email) async {
    final customerList = await http.get(
        Uri.parse('https://api.stripe.com/v1/customers?email=$email'),
        headers: {
          'Authorization': 'Bearer $stripPrivateKey',
          'Content-Type': 'application/x-www-form-urlencoded'
        });
    return json.decode(customerList.body)['data'];
  }
}
