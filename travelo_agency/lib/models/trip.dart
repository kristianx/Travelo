import 'package:json_annotation/json_annotation.dart';

part 'trip.g.dart';

@JsonSerializable()
class Trip {
  int? id;
  String? accomodationImage;
  String? accomodationName;
  String? accomodationDescription;
  int? accomodationId;
  int? rating;
  int? ratingCount;
  List<String>? facilities;
  List<String>? allDates;
  String? location;
  String? dates;
  int? lowestPrice;
  int? highestPrice;
  int? agencyId;
  String? agencyName;
  String? agencyImage;
  String? countryName;
  String? cityName;
  bool? bookamrked;

  Trip();

  factory Trip.fromJson(Map<String, dynamic> json) => _$TripFromJson(json);

  // Map toJson() => {
  //       'id': id,
  //       'name': name,
  //       'countryName': countryName,
  //       'tags': tags,
  //       'image': image,
  //       'numberOfTrips': numberOfTrips,
  //       'lowestTripPrice': lowestTripPrice,
  //     };
}
