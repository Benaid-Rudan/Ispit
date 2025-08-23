// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transakcija.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transakcija _$TransakcijaFromJson(Map<String, dynamic> json) => Transakcija(
      transakcijaId: (json['transakcijaId'] as num?)?.toInt(),
      korisnikId: (json['korisnikId'] as num?)?.toInt(),
      korisnik: json['korisnik'] == null
          ? null
          : User.fromJson(json['korisnik'] as Map<String, dynamic>),
      iznos: (json['iznos'] as num?)?.toInt(),
      datumTransakcije: json['datumTransakcije'] == null
          ? null
          : DateTime.parse(json['datumTransakcije'] as String),
      opis: json['opis'] as String?,
      kategorijaTransakcijeId:
          (json['kategorijaTransakcijeId'] as num?)?.toInt(),
      kategorijaTransakcije: json['kategorijaTransakcije'] == null
          ? null
          : KategorijaTransakcije.fromJson(
              json['kategorijaTransakcije'] as Map<String, dynamic>),
      statusTransakcije: json['statusTransakcije'] as String?,
    );

Map<String, dynamic> _$TransakcijaToJson(Transakcija instance) =>
    <String, dynamic>{
      'transakcijaId': instance.transakcijaId,
      'korisnikId': instance.korisnikId,
      'korisnik': instance.korisnik,
      'iznos': instance.iznos,
      'datumTransakcije': instance.datumTransakcije?.toIso8601String(),
      'opis': instance.opis,
      'kategorijaTransakcijeId': instance.kategorijaTransakcijeId,
      'kategorijaTransakcije': instance.kategorijaTransakcije,
      'statusTransakcije': instance.statusTransakcije,
    };
