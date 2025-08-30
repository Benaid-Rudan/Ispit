import 'package:ecommerce_mobile/model/challenge.dart';
import 'package:ecommerce_mobile/model/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_challenge.g.dart';

@JsonSerializable()
class UserChallenge {
  int? userChallengeId;
  int? challengeId;
  Challenge? challenge;
  int? izazvaniId;
  User? izazvani;
  int? napredak;
  DateTime? datumPrihvatanja;
  String? statusIzazova;
  DateTime? vrijemeZavrsetka;

    UserChallenge({
      this.userChallengeId,
      this.izazvaniId,
      this.izazvani,
      this.challengeId,
      this.challenge,
      this.napredak,
      this.datumPrihvatanja,
      this.statusIzazova,
      this.vrijemeZavrsetka,
    });

  factory UserChallenge.fromJson(Map<String, dynamic> json) => _$UserChallengeFromJson(json);

  Map<String, dynamic> toJson() => _$UserChallengeToJson(this);
}
