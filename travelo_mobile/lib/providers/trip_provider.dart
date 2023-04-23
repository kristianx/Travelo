import '../model/trip.dart';
import 'base_provider.dart';

class TripProvider extends BaseProvider<Trip> {
  TripProvider() : super("Trip");

  @override
  Trip fromJson(data) {
    // TODO: implement fromJson
    return Trip.fromJson(data);
  }
}
