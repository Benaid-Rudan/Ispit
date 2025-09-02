import 'package:ecommerce_mobile/model/challenge.dart';
import 'package:ecommerce_mobile/model/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'peer_challenge.g.dart';

@JsonSerializable()
class PeerChallenge {
  int? peerChallengeId;
  int? izazivacId;
  User? izazivac;
  int? izazvaniId;
  User? izazvani;
  int? challengeId;
  Challenge? challenge;
  String? statusPeera;
  DateTime? datumKreiranja;

  PeerChallenge({
   this.peerChallengeId,
   this.izazivacId,
   this.izazivac,
   this.izazvaniId,
   this.izazvani,
   this.challengeId,
   this.challenge,
   this.statusPeera,
   this.datumKreiranja,
  });

  factory PeerChallenge.fromJson(Map<String, dynamic> json) => _$PeerChallengeFromJson(json);

  Map<String, dynamic> toJson() => _$PeerChallengeToJson(this);
} 