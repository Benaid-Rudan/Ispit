import 'package:ecommerce_mobile/model/peer_challenge.dart';
import 'package:ecommerce_mobile/model/user_challenge.dart';
import 'package:ecommerce_mobile/providers/base_provider.dart';

class PeerChallengeProvider extends BaseProvider<PeerChallenge> {
  PeerChallengeProvider() : super("PeerChallenge");

  @override
  PeerChallenge fromJson(dynamic json) {
    return PeerChallenge.fromJson(json);
  }
}
