import 'package:json_annotation/json_annotation.dart';

part 'trip.g.dart';

@JsonSerializable()
class Trip {
  int? id;
  String? accomodationImage;
  String? accomodationName;
  String? accomodationDescription;
  int? rating;
  int? ratingCount;
  List<String>? facilities;
  String? location;
  String? dates;
  int? lowestPrice;
  int? agencyId;
  String? agencyName;
  String? agencyImage;
  String? countryName;
  String? cityName;

  Trip();

  factory Trip.fromJson(Map<String, dynamic> json) => _$TripFromJson(json);
}
