import '../model/paymentMethod.dart';
import 'base_provider.dart';

class PaymentMethodProvider extends BaseProvider<PaymentMethod> {
  PaymentMethodProvider() : super("PaymentMethod");

  @override
  PaymentMethod fromJson(data) {
    // TODO: implement fromJson
    return PaymentMethod.fromJson(data);
  }
}
