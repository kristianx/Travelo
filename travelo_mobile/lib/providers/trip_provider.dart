import 'dart:convert';
import '../model/trip.dart';
import 'base_provider.dart';

class TripProvider extends BaseProvider<Trip> {
  TripProvider() : super("Trip");

  Future<List<Trip>> getBookmarks(int userId) async {
    Map<String, String> headers = await createHeaders();

    var response = await http
        ?.get(Uri.parse("${baseUrl}Trip/Bookmarks/$userId"), headers: headers);

    if (response!.body.isNotEmpty) {
      var data = jsonDecode(response.body);
      return data.map((x) => fromJson(x)).cast<Trip>().toList();
    } else {
      return [];
    }
  }

  Future<bool> AddRating(
    int userId,
    int tripId,
    double rating,
  ) async {
    Map<String, String> headers = await createHeaders();
    var response = await http?.post(
      Uri.parse(
          "${baseUrl}Trip/AddRating?userId=$userId&tripId=$tripId&rating=$rating"),
      headers: headers,
    );

    if (response?.statusCode == 200) {
      print("Rating success");
      return true;
    } else {
      print(response!.body);
      print("Rating error here");
      return false;
    }
  }

  Future<bool> toggleBookmark(int tripId, int userId) async {
    Map<String, String> headers = await createHeaders();

    var response = await http?.post(
      Uri.parse("${baseUrl}Trip/ToggleBookmark?tripId=$tripId&userId=$userId"),
      headers: headers,
    );

    if (response!.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Unable to process");
    }
  }

  Future<List<Trip>> getRecommendation(int userId, int tripId) async {
    Map<String, String> headers = await createHeaders();

    var response = await http?.get(
        Uri.parse("${baseUrl}Trip/$tripId/recommend?userId=$userId"),
        headers: headers);

    if (response!.body.isNotEmpty) {
      var data = jsonDecode(response.body).cast<Map<String, dynamic>>();
      return data.map((x) => fromJson(x)).cast<Trip>().toList();
    } else {
      return [];
    }
  }

  @override
  Trip fromJson(data) {
    return Trip.fromJson(data);
  }
}
