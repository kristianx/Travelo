// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pasos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pasos _$PasosFromJson(Map<String, dynamic> json) => Pasos()
  ..id = json['id'] as int?
  ..dateIssued = json['dateIssued'] == null
      ? null
      : DateTime.parse(json['dateIssued'] as String)
  ..userName = json['userName'] as String?
  ..valid = json['valid'] as bool?;

Map<String, dynamic> _$PasosToJson(Pasos instance) => <String, dynamic>{
      'id': instance.id,
      'dateIssued': instance.dateIssued?.toIso8601String(),
      'userName': instance.userName,
      'valid': instance.valid,
    };
