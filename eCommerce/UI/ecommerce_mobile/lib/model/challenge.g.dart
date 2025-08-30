// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Challenge _$ChallengeFromJson(Map<String, dynamic> json) => Challenge(
      challengeId: (json['challengeId'] as num?)?.toInt(),
      naziv: json['naziv'] as String?,
      praviloUspjeha: json['praviloUspjeha'] as String?,
      tipIzazova: json['tipIzazova'] as String?,
    );

Map<String, dynamic> _$ChallengeToJson(Challenge instance) => <String, dynamic>{
      'challengeId': instance.challengeId,
      'naziv': instance.naziv,
      'praviloUspjeha': instance.praviloUspjeha,
      'tipIzazova': instance.tipIzazova,
    };
