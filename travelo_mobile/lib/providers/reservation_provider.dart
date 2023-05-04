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
      Uri.parse("https://127.0.0.1:7100/Reservation"),
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
      print(response?.body);
      return "";
    } else {
      print("Reservation error here");
      print(response?.body);
      return response?.body ?? "Error while processing reservation.";
    }
  }

  @override
  Reservation fromJson(data) {
    // TODO: implement fromJson
    return Reservation.fromJson(data);
  }
}
