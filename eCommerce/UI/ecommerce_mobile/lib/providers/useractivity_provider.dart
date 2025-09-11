import 'package:ecommerce_mobile/model/activity.dart';
import 'package:ecommerce_mobile/model/unit_of_measure.dart';
import 'package:ecommerce_mobile/model/useractivity.dart';
import 'package:ecommerce_mobile/providers/base_provider.dart';

class UseractivityProvider extends BaseProvider<UserActivity> {
  UseractivityProvider() : super("UserActivity");

  @override
  UserActivity fromJson(dynamic json) {
    return UserActivity.fromJson(json);
  }
}
