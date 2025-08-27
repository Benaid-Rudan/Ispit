// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge_reward.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChallengeReward _$ChallengeRewardFromJson(Map<String, dynamic> json) =>
    ChallengeReward(
      challengeRewardId: (json['challengeRewardId'] as num?)?.toInt(),
      challengeId: (json['challengeId'] as num?)?.toInt(),
      nazivNagrade: json['nazivNagrade'] as String?,
      tipNagrade: $enumDecodeNullable(_$RewardTypeEnumMap, json['tipNagrade']),
      uslov: json['uslov'] as String?,
      vrijednost: (json['vrijednost'] as num?)?.toInt(),
      challenge: json['challenge'] == null
          ? null
          : Challenge.fromJson(json['challenge'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChallengeRewardToJson(ChallengeReward instance) =>
    <String, dynamic>{
      'challengeRewardId': instance.challengeRewardId,
      'challengeId': instance.challengeId,
      'nazivNagrade': instance.nazivNagrade,
      'tipNagrade': _$RewardTypeEnumMap[instance.tipNagrade],
      'uslov': instance.uslov,
      'vrijednost': instance.vrijednost,
      'challenge': instance.challenge,
    };

const _$RewardTypeEnumMap = {
  RewardType.Bodovi: 'Bodovi',
  RewardType.DigitalniBadge: 'DigitalniBadge',
  RewardType.SpecijalnaDozvola: 'SpecijalnaDozvola',
};
