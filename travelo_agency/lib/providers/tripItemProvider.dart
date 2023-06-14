import '../models/tripItem.dart';
import 'base_provider.dart';

class TripItemProvider extends BaseProvider<TripItem> {
  TripItemProvider() : super("TripItem");

  @override
  TripItem fromJson(data) {
    return TripItem.fromJson(data);
  }
}
