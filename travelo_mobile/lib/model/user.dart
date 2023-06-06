import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? username;
  String? image;
  int? cityId;
  String? address;
  String? postalCode;

  User();

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

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
