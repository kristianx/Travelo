// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trip _$TripFromJson(Map<String, dynamic> json) => Trip()
  ..id = json['id'] as int?
  ..accomodationImage = json['accomodationImage'] as String?
  ..accomodationName = json['accomodationName'] as String?
  ..accomodationDescription = json['accomodationDescription'] as String?
  ..rating = json['rating'] as int?
  ..ratingCount = json['ratingCount'] as int?
  ..facilities =
      (json['facilities'] as List<dynamic>?)?.map((e) => e as String).toList()
  ..location = json['location'] as String?
  ..dates = json['dates'] as String?
  ..lowestPrice = json['lowestPrice'] as int?
  ..agencyId = json['agencyId'] as int?
  ..agencyName = json['agencyName'] as String?
  ..agencyImage = json['agencyImage'] as String?
  ..countryName = json['countryName'] as String?
  ..cityName = json['cityName'] as String?;

Map<String, dynamic> _$TripToJson(Trip instance) => <String, dynamic>{
      'id': instance.id,
      'accomodationImage': instance.accomodationImage,
      'accomodationName': instance.accomodationName,
      'accomodationDescription': instance.accomodationDescription,
      'rating': instance.rating,
      'ratingCount': instance.ratingCount,
      'facilities': instance.facilities,
      'location': instance.location,
      'dates': instance.dates,
      'lowestPrice': instance.lowestPrice,
      'agencyId': instance.agencyId,
      'agencyName': instance.agencyName,
      'agencyImage': instance.agencyImage,
      'countryName': instance.countryName,
      'cityName': instance.cityName,
    };
