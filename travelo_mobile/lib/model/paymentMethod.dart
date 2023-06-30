import 'package:json_annotation/json_annotation.dart';

part 'paymentMethod.g.dart';

@JsonSerializable()
class PaymentMethod {
  int? id;
  String? cardNumber;
  String? holderName;
  String? address;
  String? cvv;
  String? expDate;
  bool? primary;
  String? cardType;
  String? lastDigits;
  int? userId;

  PaymentMethod();

  factory PaymentMethod.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodFromJson(json);
}
