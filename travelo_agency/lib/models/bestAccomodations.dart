import 'package:json_annotation/json_annotation.dart';

part 'bestAccomodations.g.dart';

@JsonSerializable()
class BestAccomodations {
  int? tripId;
  String? accommodationName;
  double? totalPrice;

  BestAccomodations();

  factory BestAccomodations.fromJson(Map<String, dynamic> json) =>
      _$BestAccomodationsFromJson(json);
}
