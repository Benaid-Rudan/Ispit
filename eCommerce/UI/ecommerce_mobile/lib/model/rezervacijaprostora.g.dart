// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rezervacijaprostora.dart';

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
      radniProstor: json['radniProstor'] == null
          ? null
          : RadniProstor.fromJson(json['radniProstor'] as Map<String, dynamic>),
      datumRezervacije: json['datumRezervacije'] == null
          ? null
          : DateTime.parse(json['datumRezervacije'] as String),
      trajanje: (json['trajanje'] as num?)?.toInt(),
      status: json['status'] as String?,
      napomena: json['napomena'] as String?,
    );

Map<String, dynamic> _$RezervacijaProstoraToJson(
        RezervacijaProstora instance) =>
    <String, dynamic>{
      'rezervacijaProstoraId': instance.rezervacijaProstoraId,
      'radniProstorId': instance.radniProstorId,
      'korisnikId': instance.korisnikId,
      'korisnik': instance.korisnik,
      'radniProstor': instance.radniProstor,
      'datumRezervacije': instance.datumRezervacije?.toIso8601String(),
      'trajanje': instance.trajanje,
      'status': instance.status,
      'napomena': instance.napomena,
    };
