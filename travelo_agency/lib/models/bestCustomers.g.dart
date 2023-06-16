// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bestCustomers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BestCustomers _$BestCustomersFromJson(Map<String, dynamic> json) =>
    BestCustomers()
      ..userId = json['userId'] as int?
      ..image = json['image'] as String?
      ..customerName = json['customerName'] as String?
      ..numberOfTrips = json['numberOfTrips'] as int?;

Map<String, dynamic> _$BestCustomersToJson(BestCustomers instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'image': instance.image,
      'customerName': instance.customerName,
      'numberOfTrips': instance.numberOfTrips,
    };
