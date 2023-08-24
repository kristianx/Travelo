import 'package:json_annotation/json_annotation.dart';

part 'agency.g.dart';

@JsonSerializable()
class Agency {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? websiteUrl;
  String? about;
  String? image;
  bool? status;
  String? location;
  int? numberOfTrips;
  double? rating;
  String? address;
  int? cityId;
  String? cityName;
  String? postalCode;

  Agency();

  factory Agency.fromJson(Map<String, dynamic> json) => _$AgencyFromJson(json);

  Map toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "websiteUrl": websiteUrl,
        "about": about,
        "image": image,
        "status": status,
        "location": location,
        " numberOfTrips": numberOfTrips,
        " rating": rating,
        "address": address,
        " cityId": cityId,
        "cityName": cityName,
        "postalCode": postalCode,
      };
}
