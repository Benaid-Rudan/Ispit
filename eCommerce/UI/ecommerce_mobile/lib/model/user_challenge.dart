import 'package:ecommerce_mobile/model/challenge.dart';
import 'package:ecommerce_mobile/model/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_challenge.g.dart';

@JsonSerializable()
class UserChallenge {
  int? userChallengeId;
  int? izazvaniId;
  User? izazvani;
  int? challengeId;
  Challenge? challenge;
  DateTime? datumPrihvatanja;
  String? statusIzazov;
  int? napredak;
  DateTime? vrijemeZavrsetka;

  UserChallenge({
    this.userChallengeId,
    this.izazvaniId,
    this.challengeId,
    this.datumPrihvatanja,
    this.statusIzazov,
    this.napredak,
    this.vrijemeZavrsetka,
  });

  factory UserChallenge.fromJson(Map<String, dynamic> json) => _$UserChallengeFromJson(json);

  Map<String, dynamic> toJson() => _$UserChallengeToJson(this);
} 