import '../model/pasos.dart';
import 'base_provider.dart';

class PasosProvider extends BaseProvider<Pasos> {
  PasosProvider() : super("Pasos");

  @override
  Pasos fromJson(data) {
    return Pasos.fromJson(data);
  }
}
