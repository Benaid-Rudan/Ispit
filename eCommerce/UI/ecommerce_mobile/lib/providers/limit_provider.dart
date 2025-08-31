import 'package:ecommerce_mobile/model/limit.dart';
import 'package:ecommerce_mobile/providers/base_provider.dart';

class LimitProvider extends BaseProvider<Limit> {
  LimitProvider() : super("Limit");

  @override
  Limit fromJson(dynamic json) {
    return Limit.fromJson(json);
  }
}
