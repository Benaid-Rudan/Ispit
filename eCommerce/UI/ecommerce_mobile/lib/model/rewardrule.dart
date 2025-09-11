import 'package:ecommerce_mobile/model/activity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rewardrule.g.dart';

@JsonSerializable()
class RewardRule {
  int? rewardRuleId;
  int? activityId;
  Activity? activity; // Promijeni u Activity ako imaš model
  String? rewardTitle;
  int? maxDaysToComplete;
  int? numberOfPoints;

  RewardRule({
    this.rewardRuleId,
    this.activityId,
    this.activity,
    this.rewardTitle,
    this.maxDaysToComplete,
    this.numberOfPoints,
  });

  factory RewardRule.fromJson(Map<String, dynamic> json) => _$RewardRuleFromJson(json);

  Map<String, dynamic> toJson() => _$RewardRuleToJson(this);
}
