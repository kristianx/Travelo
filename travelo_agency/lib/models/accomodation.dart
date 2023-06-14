import 'package:json_annotation/json_annotation.dart';

part 'accomodation.g.dart';

@JsonSerializable()
class Accomodation {
  int? id;
  String? name;
  int? cityId;
  String? cityName;
  String? address;
  String? postalCode;
  String? description;
  List<String>? facilities;
  String? locationMap;
  String? images;

  Accomodation();

  factory Accomodation.fromJson(Map<String, dynamic> json) =>
      _$AccomodationFromJson(json);
}
