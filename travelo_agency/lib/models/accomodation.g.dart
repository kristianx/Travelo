// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accomodation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Accomodation _$AccomodationFromJson(Map<String, dynamic> json) => Accomodation()
  ..id = json['id'] as int?
  ..name = json['name'] as String?
  ..cityId = json['cityId'] as int?
  ..cityName = json['cityName'] as String?
  ..address = json['address'] as String?
  ..postalCode = json['postalCode'] as String?
  ..description = json['description'] as String?
  ..facilities =
      (json['facilities'] as List<dynamic>?)?.map((e) => e as String).toList()
  ..locationMap = json['locationMap'] as String?
  ..images = json['images'] as String?;

Map<String, dynamic> _$AccomodationToJson(Accomodation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'cityId': instance.cityId,
      'cityName': instance.cityName,
      'address': instance.address,
      'postalCode': instance.postalCode,
      'description': instance.description,
      'facilities': instance.facilities,
      'locationMap': instance.locationMap,
      'images': instance.images,
    };
