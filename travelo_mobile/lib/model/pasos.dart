import 'package:json_annotation/json_annotation.dart';

part 'pasos.g.dart';

@JsonSerializable()
class Pasos {
  int? id;
  DateTime? dateIssued;
  String? userName;
  bool? valid;
  Pasos();

  factory Pasos.fromJson(Map<String, dynamic> json) => _$PasosFromJson(json);

  // Map toJson() => {
  //       "id": 0,
  //       "name": name,
  //       "email": email,
  //       "phone": phone,
  //       "websiteUrl": websiteUrl,
  //       "about": about,
  //       "image": image,
  //       "status": status,
  //       "rating": rating,
  //       "ratingCount": ratingCount
  //     };
}
