// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_challenge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserChallenge _$UserChallengeFromJson(Map<String, dynamic> json) =>
    UserChallenge(
      userChallengeId: (json['userChallengeId'] as num?)?.toInt(),
      korisnikId: (json['korisnikId'] as num?)?.toInt(),
      korisnik: json['korisnik'] == null
          ? null
          : User.fromJson(json['korisnik'] as Map<String, dynamic>),
      challengeId: (json['challengeId'] as num?)?.toInt(),
      challenge: json['challenge'] == null
          ? null
          : Challenge.fromJson(json['challenge'] as Map<String, dynamic>),
      statusIzazova: json['statusIzazova'] as String?,
      datumPrihvatanja: json['datumPrihvatanja'] == null
          ? null
          : DateTime.parse(json['datumPrihvatanja'] as String),
      napredak: (json['napredak'] as num?)?.toInt(),
      vrijemeZavrsetka: json['vrijemeZavrsetka'] == null
          ? null
          : DateTime.parse(json['vrijemeZavrsetka'] as String),
    );

Map<String, dynamic> _$UserChallengeToJson(UserChallenge instance) =>
    <String, dynamic>{
      'userChallengeId': instance.userChallengeId,
      'korisnikId': instance.korisnikId,
      'korisnik': instance.korisnik,
      'challengeId': instance.challengeId,
      'challenge': instance.challenge,
      'statusIzazova': instance.statusIzazova,
      'datumPrihvatanja': instance.datumPrihvatanja?.toIso8601String(),
      'napredak': instance.napredak,
      'vrijemeZavrsetka': instance.vrijemeZavrsetka?.toIso8601String(),
    };
