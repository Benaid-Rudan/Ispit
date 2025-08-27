import 'package:json_annotation/json_annotation.dart';
import 'challenge.dart';

part 'challenge_reward.g.dart';

enum RewardType { Bodovi, DigitalniBadge, SpecijalnaDozvola }

@JsonSerializable()
class ChallengeReward {
  final int? challengeRewardId;
  final int? challengeId;
  final String? nazivNagrade;
  final RewardType? tipNagrade;
  final String? uslov;
  final int? vrijednost;
  final Challenge? challenge;

  ChallengeReward({
    this.challengeRewardId,
    this.challengeId,
    this.nazivNagrade,
    this.tipNagrade,
    this.uslov,
    this.vrijednost,
    this.challenge,
  });

  factory ChallengeReward.fromJson(Map<String, dynamic> json) =>
      _$ChallengeRewardFromJson(json);

  Map<String, dynamic> toJson() => _$ChallengeRewardToJson(this);
}
