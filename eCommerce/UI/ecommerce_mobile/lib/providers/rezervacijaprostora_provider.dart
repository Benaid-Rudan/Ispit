import 'dart:convert';

import 'package:ecommerce_mobile/model/rezervacijaprostora.dart';
import 'package:ecommerce_mobile/providers/base_provider.dart';

class RezervacijaprostoraProvider extends BaseProvider<RezervacijaProstora> {
  RezervacijaprostoraProvider() : super("RezervacijaProstora");

  @override
  RezervacijaProstora fromJson(dynamic json) {
    return RezervacijaProstora.fromJson(json);
  }
}