import 'package:json_annotation/json_annotation.dart';
import 'challenge.dart';
import 'user.dart';

part 'peer_challenge.g.dart';

// enum StatusPeer { Poslan, Prihvacen, Odbijen, Zavrsen }

@JsonSerializable()
class PeerChallenge {
  final int? peerChallengeId;
  final int? izazivacId;
  final int? izazvaniId;
  final int? challengeId;
  final String? status;
  final DateTime? datumKreiranja;

  final User? izazivac;
  final User? izazvani;
  final Challenge? challenge;

  PeerChallenge({
    this.peerChallengeId,
    this.izazivacId,
    this.izazvaniId,
    this.challengeId,
    this.status,
    this.datumKreiranja,
    this.izazivac,
    this.izazvani,
    this.challenge,
  });

  factory PeerChallenge.fromJson(Map<String, dynamic> json) =>
      _$PeerChallengeFromJson(json);

  Map<String, dynamic> toJson() => _$PeerChallengeToJson(this);
}
