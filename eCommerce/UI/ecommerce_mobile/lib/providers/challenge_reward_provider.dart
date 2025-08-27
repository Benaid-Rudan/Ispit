import 'dart:convert';

import 'package:ecommerce_mobile/model/challenge_reward.dart';
import 'package:ecommerce_mobile/providers/base_provider.dart';

class ChallengeRewardProvider extends BaseProvider<ChallengeReward> {
  ChallengeRewardProvider() : super("ChallengeReward");

  @override
  ChallengeReward fromJson(dynamic json) {
    return ChallengeReward.fromJson(json);
  }
}
