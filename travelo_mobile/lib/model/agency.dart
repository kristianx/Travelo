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
  int? ratingCount;

  Agency();

  factory Agency.fromJson(Map<String, dynamic> json) => _$AgencyFromJson(json);

  Map toJson() => {
        "id": 0,
        "name": name,
        "email": email,
        "phone": phone,
        "websiteUrl": websiteUrl,
        "about": about,
        "image": image,
        "status": status,
        "rating": rating,
        "ratingCount": ratingCount
      };
}
