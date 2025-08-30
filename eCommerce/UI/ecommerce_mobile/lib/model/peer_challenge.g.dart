// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'peer_challenge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PeerChallenge _$PeerChallengeFromJson(Map<String, dynamic> json) =>
    PeerChallenge(
      peerChallengeId: (json['peerChallengeId'] as num?)?.toInt(),
      izazivacId: (json['izazivacId'] as num?)?.toInt(),
      izazivac: json['izazivac'] == null
          ? null
          : User.fromJson(json['izazivac'] as Map<String, dynamic>),
      izazvaniId: (json['izazvaniId'] as num?)?.toInt(),
      izazvani: json['izazvani'] == null
          ? null
          : User.fromJson(json['izazvani'] as Map<String, dynamic>),
      challengeId: (json['challengeId'] as num?)?.toInt(),
      challenge: json['challenge'] == null
          ? null
          : Challenge.fromJson(json['challenge'] as Map<String, dynamic>),
      statusPeera: json['statusPeera'] as String?,
      datumKreiranja: json['datumKreiranja'] == null
          ? null
          : DateTime.parse(json['datumKreiranja'] as String),
    );

Map<String, dynamic> _$PeerChallengeToJson(PeerChallenge instance) =>
    <String, dynamic>{
      'peerChallengeId': instance.peerChallengeId,
      'izazivacId': instance.izazivacId,
      'izazivac': instance.izazivac,
      'izazvaniId': instance.izazvaniId,
      'izazvani': instance.izazvani,
      'challengeId': instance.challengeId,
      'challenge': instance.challenge,
      'statusPeera': instance.statusPeera,
      'datumKreiranja': instance.datumKreiranja?.toIso8601String(),
    };
