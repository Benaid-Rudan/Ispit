// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rewardrule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RewardRule _$RewardRuleFromJson(Map<String, dynamic> json) => RewardRule(
      rewardRuleId: (json['rewardRuleId'] as num?)?.toInt(),
      activityId: (json['activityId'] as num?)?.toInt(),
      activity: json['activity'] == null
          ? null
          : Activity.fromJson(json['activity'] as Map<String, dynamic>),
      rewardTitle: json['rewardTitle'] as String?,
      maxDaysToComplete: (json['maxDaysToComplete'] as num?)?.toInt(),
      numberOfPoints: (json['numberOfPoints'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RewardRuleToJson(RewardRule instance) =>
    <String, dynamic>{
      'rewardRuleId': instance.rewardRuleId,
      'activityId': instance.activityId,
      'activity': instance.activity,
      'rewardTitle': instance.rewardTitle,
      'maxDaysToComplete': instance.maxDaysToComplete,
      'numberOfPoints': instance.numberOfPoints,
    };
