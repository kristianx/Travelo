import 'dart:convert';

import 'package:travelo_agency/models/dailyStats.dart';

import '../models/reservation.dart';
import 'base_provider.dart';

class ReservationProvider extends BaseProvider<Reservation> {
  ReservationProvider() : super("Reservation");

  @override
  Reservation fromJson(data) {
    return Reservation.fromJson(data);
  }

  Future<List<DailyStats>> getStats(int agencyId, int month, int year) async {
    Map<String, String> headers = await createHeaders();

    var response = await http?.get(
        Uri.parse(
            "https://127.0.0.1:7100/Reservation/GetDailyReservations?Year=$year&Month=$month&AgencyId=$agencyId"),
        headers: headers);

    if (response!.body.isNotEmpty) {
      var data = jsonDecode(response.body);
      return data
          .map((x) => DailyStats.fromJson(x))
          .cast<DailyStats>()
          .toList();
    } else {
      return List<DailyStats>.empty();
    }
  }
}
