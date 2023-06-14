// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tripItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripItem _$TripItemFromJson(Map<String, dynamic> json) => TripItem()
  ..id = json['id'] as int?
  ..checkIn =
      json['checkIn'] == null ? null : DateTime.parse(json['checkIn'] as String)
  ..checkOut = json['checkOut'] == null
      ? null
      : DateTime.parse(json['checkOut'] as String)
  ..pricePerPerson = json['pricePerPerson'] as int?
  ..nightsStay = json['nightsStay'] as int?
  ..tripId = json['tripId'] as int?
  ..expired = json['expired'] as bool?
  ..totalPrice = json['totalPrice'] as int?
  ..dates = json['dates'] as String?;

Map<String, dynamic> _$TripItemToJson(TripItem instance) => <String, dynamic>{
      'id': instance.id,
      'checkIn': instance.checkIn?.toIso8601String(),
      'checkOut': instance.checkOut?.toIso8601String(),
      'pricePerPerson': instance.pricePerPerson,
      'nightsStay': instance.nightsStay,
      'tripId': instance.tripId,
      'expired': instance.expired,
      'totalPrice': instance.totalPrice,
      'dates': instance.dates,
    };
