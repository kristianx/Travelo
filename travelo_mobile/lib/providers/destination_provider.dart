import '../model/destination.dart';
import 'base_provider.dart';

class DestinationProvider extends BaseProvider<Destination> {
  DestinationProvider() : super("City/Destinations");

  @override
  Destination fromJson(data) {
    // TODO: implement fromJson
    return Destination.fromJson(data);
  }
}
