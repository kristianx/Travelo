import 'package:json_annotation/json_annotation.dart';

part 'bestCustomers.g.dart';

@JsonSerializable()
class BestCustomers {
  int? userId;
  String? image;
  String? customerName;
  int? numberOfTrips;

  BestCustomers();

  factory BestCustomers.fromJson(Map<String, dynamic> json) =>
      _$BestCustomersFromJson(json);
}
