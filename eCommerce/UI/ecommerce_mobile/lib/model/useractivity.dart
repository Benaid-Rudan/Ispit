import 'package:ecommerce_mobile/model/activity.dart';
import 'package:ecommerce_mobile/model/rewardrule.dart';
import 'package:ecommerce_mobile/model/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'useractivity.g.dart';

@JsonSerializable()
class UserActivity {
  int? userActivityId;
  int? korisnikId;
  User? korisnik;
  int? activityId;
  Activity? activity;
  DateTime? dateAssigned;
  String? statusActivity; 
  String? note;
  DateTime? completedAt;
  String? rewardTitle;
  DateTime? rewardedAt;
  RewardRule? rewardRule;

  UserActivity({
    this.userActivityId,
    this.korisnikId,
    this.korisnik,
    this.activityId,
    this.activity,
    this.dateAssigned,
    this.statusActivity,
    this.note,
    this.completedAt,
    this.rewardTitle,
    this.rewardedAt,
  });

  factory UserActivity.fromJson(Map<String, dynamic> json) => _$UserActivityFromJson(json);

  Map<String, dynamic> toJson() => _$UserActivityToJson(this);
}
