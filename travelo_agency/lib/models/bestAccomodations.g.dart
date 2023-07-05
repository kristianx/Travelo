// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bestAccomodations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BestAccomodations _$BestAccomodationsFromJson(Map<String, dynamic> json) =>
    BestAccomodations()
      ..tripId = json['tripId'] as int?
      ..accommodationName = json['accommodationName'] as String?
      ..totalPrice = (json['totalPrice'] as num?)?.toDouble();

Map<String, dynamic> _$BestAccomodationsToJson(BestAccomodations instance) =>
    <String, dynamic>{
      'tripId': instance.tripId,
      'accommodationName': instance.accommodationName,
      'totalPrice': instance.totalPrice,
    };
