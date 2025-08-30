// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_challenge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserChallenge _$UserChallengeFromJson(Map<String, dynamic> json) =>
    UserChallenge(
      userChallengeId: (json['userChallengeId'] as num?)?.toInt(),
      izazvaniId: (json['izazvaniId'] as num?)?.toInt(),
      izazvani: json['izazvani'] == null
          ? null
          : User.fromJson(json['izazvani'] as Map<String, dynamic>),
      challengeId: (json['challengeId'] as num?)?.toInt(),
      challenge: json['challenge'] == null
          ? null
          : Challenge.fromJson(json['challenge'] as Map<String, dynamic>),
      napredak: (json['napredak'] as num?)?.toInt(),
      datumPrihvatanja: json['datumPrihvatanja'] == null
          ? null
          : DateTime.parse(json['datumPrihvatanja'] as String),
      statusIzazova: json['statusIzazova'] as String?,
      vrijemeZavrsetka: json['vrijemeZavrsetka'] == null
          ? null
          : DateTime.parse(json['vrijemeZavrsetka'] as String),
    );

Map<String, dynamic> _$UserChallengeToJson(UserChallenge instance) =>
    <String, dynamic>{
      'userChallengeId': instance.userChallengeId,
      'challengeId': instance.challengeId,
      'challenge': instance.challenge,
      'izazvaniId': instance.izazvaniId,
      'izazvani': instance.izazvani,
      'napredak': instance.napredak,
      'datumPrihvatanja': instance.datumPrihvatanja?.toIso8601String(),
      'statusIzazova': instance.statusIzazova,
      'vrijemeZavrsetka': instance.vrijemeZavrsetka?.toIso8601String(),
    };
