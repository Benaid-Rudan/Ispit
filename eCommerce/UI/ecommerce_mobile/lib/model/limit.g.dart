// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'limit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Limit _$LimitFromJson(Map<String, dynamic> json) => Limit(
      limitId: (json['limitId'] as num?)?.toInt(),
      korisnikId: (json['korisnikId'] as num?)?.toInt(),
      korisnik: json['korisnik'] == null
          ? null
          : User.fromJson(json['korisnik'] as Map<String, dynamic>),
      iznos: (json['iznos'] as num?)?.toInt(),
      kategorijaTransakcijeId:
          (json['kategorijaTransakcijeId'] as num?)?.toInt(),
      kategorijaTransakcije: json['kategorijaTransakcije'] == null
          ? null
          : KategorijaTransakcije.fromJson(
              json['kategorijaTransakcije'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LimitToJson(Limit instance) => <String, dynamic>{
      'limitId': instance.limitId,
      'iznos': instance.iznos,
      'korisnikId': instance.korisnikId,
      'korisnik': instance.korisnik,
      'kategorijaTransakcijeId': instance.kategorijaTransakcijeId,
      'kategorijaTransakcije': instance.kategorijaTransakcije,
    };
