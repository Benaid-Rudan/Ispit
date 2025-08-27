// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'peer_challenge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PeerChallenge _$PeerChallengeFromJson(Map<String, dynamic> json) =>
    PeerChallenge(
      peerChallengeId: (json['peerChallengeId'] as num?)?.toInt(),
      izazivacId: (json['izazivacId'] as num?)?.toInt(),
      izazvaniId: (json['izazvaniId'] as num?)?.toInt(),
      challengeId: (json['challengeId'] as num?)?.toInt(),
      status: json['status'] as String?,
      datumKreiranja: json['datumKreiranja'] == null
          ? null
          : DateTime.parse(json['datumKreiranja'] as String),
      izazivac: json['izazivac'] == null
          ? null
          : User.fromJson(json['izazivac'] as Map<String, dynamic>),
      izazvani: json['izazvani'] == null
          ? null
          : User.fromJson(json['izazvani'] as Map<String, dynamic>),
      challenge: json['challenge'] == null
          ? null
          : Challenge.fromJson(json['challenge'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PeerChallengeToJson(PeerChallenge instance) =>
    <String, dynamic>{
      'peerChallengeId': instance.peerChallengeId,
      'izazivacId': instance.izazivacId,
      'izazvaniId': instance.izazvaniId,
      'challengeId': instance.challengeId,
      'status': instance.status,
      'datumKreiranja': instance.datumKreiranja?.toIso8601String(),
      'izazivac': instance.izazivac,
      'izazvani': instance.izazvani,
      'challenge': instance.challenge,
    };
