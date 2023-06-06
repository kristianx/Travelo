import 'package:json_annotation/json_annotation.dart';

part 'reservation.g.dart';

@JsonSerializable()
class Reservation {
  int? id;
  DateTime? timeOfReservation;
  int? numberOfAdults;
  int? numberOfChildren;
  int? userId;
  int? price;
  int? tripItemId;
  int? tripId;
  String? agencyName;
  String? destinationName;
  String? countryName;
  int? rating;
  String? destinationImage;
  String? date;
  DateTime? checkIn;
  DateTime? checkOut;

  Reservation();

  factory Reservation.fromJson(Map<String, dynamic> json) =>
      _$ReservationFromJson(json);

  Map toJson() => {
        // 'id': id,
        // 'name': name,
        // 'countryName': countryName,
        // 'tags': tags,
        // 'image': image,
        // 'numberOfTrips': numberOfTrips,
        // 'lowestTripPrice': lowestTripPrice,
      };
}
