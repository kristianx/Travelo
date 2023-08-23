import 'dart:convert';

import '../model/reservation.dart';
import 'base_provider.dart';

class ReservationProvider extends BaseProvider<Reservation> {
  ReservationProvider() : super("Reservation");

  Future<String> processReservation(
      int numberOfAdults,
      int numberOfChildren,
      int userId,
      int price,
      int tripItemId,
      int tripId,
      DateTime timeOfReservation) async {
    Map<String, String> headers = await createHeaders();
    var response = await http?.post(
      Uri.parse("${baseUrl}Reservation"),
      body: jsonEncode(<String, dynamic>{
        "numberOfAdults": numberOfAdults,
        "numberOfChildren": numberOfChildren,
        "userId": userId,
        "price": price,
        "tripItemId": tripItemId,
        "tripId": tripId,
        "timeOfReservation": timeOfReservation.toIso8601String()
      }),
      headers: headers,
    );

    if (response?.statusCode == 200) {
      print("Reservation success");
      return "";
    } else {
      print("Reservation error here");
      return response?.body ?? "Error while processing reservation.";
    }
  }

  @override
  Reservation fromJson(data) {
    // TODO: implement fromJson
    return Reservation.fromJson(data);
  }
}
