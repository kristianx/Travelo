import '../model/destination.dart';
import 'base_provider.dart';

class DestinationProvider extends BaseProvider<Destination> {
  DestinationProvider() : super("GetDestinations");

  @override
  Destination fromJson(data) {
    // TODO: implement fromJson
    return Destination.fromJson(data);
  }
}
