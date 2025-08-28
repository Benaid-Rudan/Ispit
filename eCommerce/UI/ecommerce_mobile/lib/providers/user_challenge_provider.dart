import 'package:ecommerce_mobile/model/user_challenge.dart';
import 'package:ecommerce_mobile/providers/base_provider.dart';

class UserChallengeProvider extends BaseProvider<UserChallenge> {
  UserChallengeProvider() : super("UserChallenge");

  @override
  UserChallenge fromJson(dynamic json) {
    return UserChallenge.fromJson(json);
  }
}
