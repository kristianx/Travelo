// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'destination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Destination _$DestinationFromJson(Map<String, dynamic> json) => Destination()
  ..id = json['id'] as int?
  ..name = json['name'] as String?
  ..countryName = json['countryName'] as String?
  ..tags = (json['tags'] as List<dynamic>).map((e) => e as String?).toList()
  ..image = json['image'] as String?
  ..numberOfTrips = json['numberOfTrips'] as int?
  ..lowestTripPrice = json['lowestTripPrice'] as int?;

Map<String, dynamic> _$DestinationToJson(Destination instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'countryName': instance.countryName,
      'tags': instance.tags,
      'image': instance.image,
      'numberOfTrips': instance.numberOfTrips,
      'lowestTripPrice': instance.lowestTripPrice,
    };
