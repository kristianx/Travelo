import '../model/tripitem.dart';
import 'base_provider.dart';

class TripItemProvider extends BaseProvider<TripItem> {
  TripItemProvider() : super("TripItem");

  @override
  TripItem fromJson(data) {
    // TODO: implement fromJson
    return TripItem.fromJson(data);
  }
}
