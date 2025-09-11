// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'useractivity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserActivity _$UserActivityFromJson(Map<String, dynamic> json) => UserActivity(
      userActivityId: (json['userActivityId'] as num?)?.toInt(),
      korisnikId: (json['korisnikId'] as num?)?.toInt(),
      korisnik: json['korisnik'] == null
          ? null
          : User.fromJson(json['korisnik'] as Map<String, dynamic>),
      activityId: (json['activityId'] as num?)?.toInt(),
      activity: json['activity'] == null
          ? null
          : Activity.fromJson(json['activity'] as Map<String, dynamic>),
      dateAssigned: json['dateAssigned'] == null
          ? null
          : DateTime.parse(json['dateAssigned'] as String),
      statusActivity: json['statusActivity'] as String?,
      note: json['note'] as String?,
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      rewardTitle: json['rewardTitle'] as String?,
      rewardedAt: json['rewardedAt'] == null
          ? null
          : DateTime.parse(json['rewardedAt'] as String),
    )..rewardRule = json['rewardRule'] == null
        ? null
        : RewardRule.fromJson(json['rewardRule'] as Map<String, dynamic>);

Map<String, dynamic> _$UserActivityToJson(UserActivity instance) =>
    <String, dynamic>{
      'userActivityId': instance.userActivityId,
      'korisnikId': instance.korisnikId,
      'korisnik': instance.korisnik,
      'activityId': instance.activityId,
      'activity': instance.activity,
      'dateAssigned': instance.dateAssigned?.toIso8601String(),
      'statusActivity': instance.statusActivity,
      'note': instance.note,
      'completedAt': instance.completedAt?.toIso8601String(),
      'rewardTitle': instance.rewardTitle,
      'rewardedAt': instance.rewardedAt?.toIso8601String(),
      'rewardRule': instance.rewardRule,
    };
