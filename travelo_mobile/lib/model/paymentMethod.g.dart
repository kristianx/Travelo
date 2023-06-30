// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paymentMethod.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentMethod _$PaymentMethodFromJson(Map<String, dynamic> json) =>
    PaymentMethod()
      ..id = json['id'] as int?
      ..cardNumber = json['cardNumber'] as String?
      ..holderName = json['holderName'] as String?
      ..address = json['address'] as String?
      ..cvv = json['cvv'] as String?
      ..expDate = json['expDate'] as String?
      ..primary = json['primary'] as bool?
      ..cardType = json['cardType'] as String?
      ..lastDigits = json['lastDigits'] as String?
      ..userId = json['userId'] as int?;

Map<String, dynamic> _$PaymentMethodToJson(PaymentMethod instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cardNumber': instance.cardNumber,
      'holderName': instance.holderName,
      'address': instance.address,
      'cvv': instance.cvv,
      'expDate': instance.expDate,
      'primary': instance.primary,
      'cardType': instance.cardType,
      'lastDigits': instance.lastDigits,
      'userId': instance.userId,
    };
