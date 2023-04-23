import 'package:json_annotation/json_annotation.dart';

part 'destination.g.dart';

@JsonSerializable()
class Destination {
  int? id;
  String? name;
  String? countryName;
  List<String?> tags = [];
  String? image;
  int? numberOfTrips;
  int? lowestTripPrice;

  Destination() {}

  factory Destination.fromJson(Map<String, dynamic> json) =>
      _$DestinationFromJson(json);

  // Map<String, dynamic> toJson() => _$DestinationFromJson(this);
}
