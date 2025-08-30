import 'dart:convert';

import 'package:ecommerce_mobile/model/radniprostor.dart';
import 'package:ecommerce_mobile/providers/base_provider.dart';

class RadniprostorProvider extends BaseProvider<RadniProstor> {
  RadniprostorProvider() : super("RadniProstor");

  @override
  RadniProstor fromJson(dynamic json) {
    return RadniProstor.fromJson(json);
  }
}