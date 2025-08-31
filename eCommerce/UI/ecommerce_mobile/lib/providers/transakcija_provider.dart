import 'package:ecommerce_mobile/model/transakcija.dart';
import 'package:ecommerce_mobile/providers/base_provider.dart';

class TransakcijaProvider extends BaseProvider<Transakcija> {
  TransakcijaProvider() : super("Transakcija");

  @override
  Transakcija fromJson(dynamic json) {
    return Transakcija.fromJson(json);
  }
}
