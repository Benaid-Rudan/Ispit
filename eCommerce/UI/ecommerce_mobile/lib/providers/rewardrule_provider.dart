import 'package:ecommerce_mobile/model/activity.dart';
import 'package:ecommerce_mobile/model/rewardrule.dart';
import 'package:ecommerce_mobile/model/unit_of_measure.dart';
import 'package:ecommerce_mobile/providers/base_provider.dart';

class RewardRuleProvider extends BaseProvider<RewardRule> {
  RewardRuleProvider() : super("RewardRule");

  @override
  RewardRule fromJson(dynamic json) {
    return RewardRule.fromJson(json);
  }
}
