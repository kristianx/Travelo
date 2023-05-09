// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agency.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Agency _$AgencyFromJson(Map<String, dynamic> json) => Agency()
  ..id = json['id'] as int?
  ..name = json['name'] as String?
  ..email = json['email'] as String?
  ..phone = json['phone'] as String?
  ..websiteUrl = json['websiteUrl'] as String?
  ..about = json['about'] as String?
  ..image = json['image'] as String?
  ..status = json['status'] as bool?;

Map<String, dynamic> _$AgencyToJson(Agency instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'websiteUrl': instance.websiteUrl,
      'about': instance.about,
      'image': instance.image,
      'status': instance.status,
    };
