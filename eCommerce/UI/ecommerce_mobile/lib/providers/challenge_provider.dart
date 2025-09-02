import 'package:ecommerce_mobile/model/challenge.dart';
import 'package:ecommerce_mobile/model/unit_of_measure.dart';
import 'package:ecommerce_mobile/providers/base_provider.dart';

class ChallengeProvider extends BaseProvider<Challenge> {
  ChallengeProvider() : super("Challenge");

  @override
  Challenge fromJson(dynamic json) {
    return Challenge.fromJson(json);
  }
}
