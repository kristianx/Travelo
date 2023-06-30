import 'package:json_annotation/json_annotation.dart';

part 'city.g.dart';

@JsonSerializable()
class City {
  int? id;
  String? name;
  String? countryName;
  List<String>? tags;
  String? image;
  int? numberOfTrips;
  int? lowestTripPrice;

  City();

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);
}
