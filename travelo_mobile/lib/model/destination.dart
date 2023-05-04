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

  Map toJson() => {
        'id': id,
        'name': name,
        'countryName': countryName,
        'tags': tags,
        'image': image,
        'numberOfTrips': numberOfTrips,
        'lowestTripPrice': lowestTripPrice,
      };
}
