// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kategorija_transakcije.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KategorijaTransakcije _$KategorijaTransakcijeFromJson(
        Map<String, dynamic> json) =>
    KategorijaTransakcije(
      kategorijaTransakcijeId:
          (json['kategorijaTransakcijeId'] as num?)?.toInt(),
      naziv: json['naziv'] as String?,
      tip: json['tip'] as String?,
    );

Map<String, dynamic> _$KategorijaTransakcijeToJson(
        KategorijaTransakcije instance) =>
    <String, dynamic>{
      'kategorijaTransakcijeId': instance.kategorijaTransakcijeId,
      'naziv': instance.naziv,
      'tip': instance.tip,
    };
