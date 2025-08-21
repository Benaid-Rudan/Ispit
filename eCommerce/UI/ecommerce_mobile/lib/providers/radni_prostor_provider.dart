import 'package:ecommerce_mobile/model/radni_prostor.dart';
import 'package:ecommerce_mobile/providers/base_provider.dart';

class RadniProstorProvider extends BaseProvider<RadniProstor> {
  RadniProstorProvider() : super("RadniProstor");

  @override
  RadniProstor fromJson(dynamic json) {
    return RadniProstor.fromJson(json);
  }
} 