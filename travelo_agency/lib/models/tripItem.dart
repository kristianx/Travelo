import 'package:json_annotation/json_annotation.dart';

part 'tripItem.g.dart';

@JsonSerializable()
class TripItem {
  int? id;
  DateTime? checkIn;
  DateTime? checkOut;
  int? pricePerPerson;
  int? nightsStay;
  int? tripId;
  bool? expired;
  int? totalPrice;
  String? dates;

  TripItem();

  factory TripItem.fromJson(Map<String, dynamic> json) =>
      _$TripItemFromJson(json);
}
