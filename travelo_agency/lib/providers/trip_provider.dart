import '../models/trip.dart';
import 'base_provider.dart';

class TripProvider extends BaseProvider<Trip> {
  TripProvider() : super("Trip");

  @override
  Trip fromJson(data) {
    return Trip.fromJson(data);
  }
}
