import 'package:ecommerce_mobile/model/product_type.dart';
import 'package:ecommerce_mobile/model/rezervacija_prostora.dart';
import 'package:ecommerce_mobile/providers/base_provider.dart';

class RezervacijaProstoraProvider extends BaseProvider<RezervacijaProstora> {
  RezervacijaProstoraProvider() : super("RezervacijaProstora");

  @override
  RezervacijaProstora fromJson(dynamic json) {
    return RezervacijaProstora.fromJson(json);
  }
} 