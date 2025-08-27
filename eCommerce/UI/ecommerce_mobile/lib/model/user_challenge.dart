import 'package:json_annotation/json_annotation.dart';
import 'challenge.dart';
import 'user.dart';

part 'user_challenge.g.dart';


@JsonSerializable()
class UserChallenge {
  final int?  userChallengeId;
  final int?  izazvaniId;
  final int?  challengeId;
  final String?  statusIzazova;
  final DateTime?  datumPrihvatanja;
  final int?  napredak;
  final DateTime? vrijemeZavrsetka;

  final User? korisnik;
  final Challenge? challenge;

  UserChallenge({
    this.userChallengeId,
    this.izazvaniId,
    this.challengeId,
    this.statusIzazova,
    this.datumPrihvatanja,
    this.napredak,
    this.vrijemeZavrsetka,
    this.korisnik,
    this.challenge,
  });

  factory UserChallenge.fromJson(Map<String, dynamic> json) =>
      _$UserChallengeFromJson(json);

  Map<String, dynamic> toJson() => _$UserChallengeToJson(this);
}
