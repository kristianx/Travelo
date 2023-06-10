// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reservation _$ReservationFromJson(Map<String, dynamic> json) => Reservation()
  ..id = json['id'] as int?
  ..timeOfReservation = json['timeOfReservation'] == null
      ? null
      : DateTime.parse(json['timeOfReservation'] as String)
  ..numberOfAdults = json['numberOfAdults'] as int?
  ..numberOfChildren = json['numberOfChildren'] as int?
  ..userId = json['userId'] as int?
  ..price = json['price'] as int?
  ..tripItemId = json['tripItemId'] as int?
  ..tripId = json['tripId'] as int?
  ..accomodationName = json['accomodationName'] as String?
  ..agencyName = json['agencyName'] as String?
  ..destinationName = json['destinationName'] as String?
  ..countryName = json['countryName'] as String?
  ..rating = json['rating'] as int?
  ..destinationImage = json['destinationImage'] as String?
  ..date = json['date'] as String?
  ..checkIn =
      json['checkIn'] == null ? null : DateTime.parse(json['checkIn'] as String)
  ..checkOut = json['checkOut'] == null
      ? null
      : DateTime.parse(json['checkOut'] as String);

Map<String, dynamic> _$ReservationToJson(Reservation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'timeOfReservation': instance.timeOfReservation?.toIso8601String(),
      'numberOfAdults': instance.numberOfAdults,
      'numberOfChildren': instance.numberOfChildren,
      'userId': instance.userId,
      'price': instance.price,
      'tripItemId': instance.tripItemId,
      'tripId': instance.tripId,
      'accomodationName': instance.accomodationName,
      'agencyName': instance.agencyName,
      'destinationName': instance.destinationName,
      'countryName': instance.countryName,
      'rating': instance.rating,
      'destinationImage': instance.destinationImage,
      'date': instance.date,
      'checkIn': instance.checkIn?.toIso8601String(),
      'checkOut': instance.checkOut?.toIso8601String(),
    };
