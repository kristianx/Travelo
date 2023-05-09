import 'dart:convert';
import '../model/trip.dart';
import 'base_provider.dart';

class TripProvider extends BaseProvider<Trip> {
  TripProvider() : super("Trip");

  Future<List<Trip>> getBookmarks(int userId) async {
    Map<String, String> headers = await createHeaders();

    var response = await http?.get(
        Uri.parse("https://127.0.0.1:7100/Trip/Bookmarks/$userId"),
        headers: headers);

    if (response!.body.isNotEmpty) {
      var data = jsonDecode(response.body);
      return data.map((x) => fromJson(x)).cast<Trip>().toList();
    } else {
      return [];
    }
  }

  Future<bool> toggleBookmark(int tripId, int userId) async {
    Map<String, String> headers = await createHeaders();

    var response = await http?.post(
      Uri.parse(
          "https://127.0.0.1:7100/ToggleBookmark?tripId=$tripId&userId=$userId"),
      headers: headers,
    );

    if (response!.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Unable to process");
    }
  }

  @override
  Trip fromJson(data) {
    return Trip.fromJson(data);
  }
}
