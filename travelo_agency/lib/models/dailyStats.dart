import 'package:json_annotation/json_annotation.dart';

part 'dailyStats.g.dart';

@JsonSerializable()
class DailyStats {
  DateTime? date;
  int? count;
  int? totalPrice;

  DailyStats();

  factory DailyStats.fromJson(Map<String, dynamic> json) =>
      _$DailyStatsFromJson(json);
}
