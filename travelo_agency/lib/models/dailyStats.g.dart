// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dailyStats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyStats _$DailyStatsFromJson(Map<String, dynamic> json) => DailyStats()
  ..date = json['date'] == null ? null : DateTime.parse(json['date'] as String)
  ..count = json['count'] as int?
  ..totalPrice = json['totalPrice'] as int?;

Map<String, dynamic> _$DailyStatsToJson(DailyStats instance) =>
    <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'count': instance.count,
      'totalPrice': instance.totalPrice,
    };
