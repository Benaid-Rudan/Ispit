// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rezervacija_prostora.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RezervacijaProstora _$RezervacijaProstoraFromJson(Map<String, dynamic> json) =>
    RezervacijaProstora(
      rezervacijaProstoraId: (json['rezervacijaProstoraId'] as num?)?.toInt(),
      radniProstorId: (json['radniProstorId'] as num?)?.toInt(),
      korisnikId: (json['korisnikId'] as num?)?.toInt(),
      korisnik: json['korisnik'] == null
          ? null
          : User.fromJson(json['korisnik'] as Map<String, dynamic>),
      datumEvidencije: json['datumEvidencije'] == null
          ? null
          : DateTime.parse(json['datumEvidencije'] as String),
      trajanje: (json['trajanje'] as num?)?.toInt(),
      statusRezervacije: json['statusRezervacije'] as String?,
      napomena: json['napomena'] as String?,
      radniProstor: json['radniProstor'] == null
          ? null
          : RadniProstor.fromJson(json['radniProstor'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RezervacijaProstoraToJson(
        RezervacijaProstora instance) =>
    <String, dynamic>{
      'rezervacijaProstoraId': instance.rezervacijaProstoraId,
      'radniProstorId': instance.radniProstorId,
      'radniProstor': instance.radniProstor,
      'korisnikId': instance.korisnikId,
      'korisnik': instance.korisnik,
      'datumEvidencije': instance.datumEvidencije?.toIso8601String(),
      'trajanje': instance.trajanje,
      'statusRezervacije': instance.statusRezervacije,
      'napomena': instance.napomena,
    };
