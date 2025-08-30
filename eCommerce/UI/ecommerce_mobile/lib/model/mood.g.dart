// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mood.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mood _$MoodFromJson(Map<String, dynamic> json) => Mood(
      moodId: (json['moodId'] as num?)?.toInt(),
      korisnikId: (json['korisnikId'] as num?)?.toInt(),
      korisnik: json['korisnik'] == null
          ? null
          : User.fromJson(json['korisnik'] as Map<String, dynamic>),
      datumEvidencije: json['datumEvidencije'] == null
          ? null
          : DateTime.parse(json['datumEvidencije'] as String),
      opis: json['opis'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$MoodToJson(Mood instance) => <String, dynamic>{
      'moodId': instance.moodId,
      'korisnikId': instance.korisnikId,
      'korisnik': instance.korisnik,
      'datumEvidencije': instance.datumEvidencije?.toIso8601String(),
      'opis': instance.opis,
      'status': instance.status,
    };
