import 'dart:convert';

import 'package:ecommerce_desktop/model/product.dart';
import 'package:ecommerce_desktop/model/radni_prostor.dart';
import 'package:ecommerce_desktop/model/search_result.dart';
import 'package:ecommerce_desktop/providers/base_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce_desktop/providers/auth_provider.dart';

class RadniProstorProvider extends BaseProvider<RadniProstor> {
  RadniProstorProvider() : super("RadniProstor");

  @override
  RadniProstor fromJson(dynamic json) {
    return RadniProstor.fromJson(json);
  }
}