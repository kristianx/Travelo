// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User()
  ..id = json['id'] as int?
  ..firstName = json['firstName'] as String?
  ..lastName = json['lastName'] as String?
  ..email = json['email'] as String?
  ..username = json['username'] as String?
  ..image = json['image'] as String?
  ..cityId = json['cityId'] as int?
  ..address = json['address'] as String?
  ..postalCode = json['postalCode'] as String?;

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'username': instance.username,
      'image': instance.image,
      'cityId': instance.cityId,
      'address': instance.address,
      'postalCode': instance.postalCode,
    };
