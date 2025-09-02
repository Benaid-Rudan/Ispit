// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Challenge _$ChallengeFromJson(Map<String, dynamic> json) => Challenge(
      challengeId: (json['challengeId'] as num?)?.toInt(),
      naziv: json['naziv'] as String?,
      pravilo: (json['pravilo'] as num?)?.toInt(),
      tipIzazova: json['tipIzazova'] as String?,
    );

Map<String, dynamic> _$ChallengeToJson(Challenge instance) => <String, dynamic>{
      'challengeId': instance.challengeId,
      'naziv': instance.naziv,
      'pravilo': instance.pravilo,
      'tipIzazova': instance.tipIzazova,
    };
