// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

City _$CityFromJson(Map<String, dynamic> json) => City()
  ..id = json['id'] as int?
  ..name = json['name'] as String?
  ..countryName = json['countryName'] as String?
  ..tags = (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList()
  ..image = json['image'] as String?
  ..numberOfTrips = json['numberOfTrips'] as int?
  ..lowestTripPrice = json['lowestTripPrice'] as int?;

Map<String, dynamic> _$CityToJson(City instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'countryName': instance.countryName,
      'tags': instance.tags,
      'image': instance.image,
      'numberOfTrips': instance.numberOfTrips,
      'lowestTripPrice': instance.lowestTripPrice,
    };
