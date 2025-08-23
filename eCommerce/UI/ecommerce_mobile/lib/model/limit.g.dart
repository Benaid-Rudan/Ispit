// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'limit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FinansijskiLimit _$FinansijskiLimitFromJson(Map<String, dynamic> json) =>
    FinansijskiLimit(
      finansijskiLimitId: (json['finansijskiLimitId'] as num?)?.toInt(),
      korisnikId: (json['korisnikId'] as num?)?.toInt(),
      kategorijaId: (json['kategorijaId'] as num?)?.toInt(),
      limit: json['limit'] as String?,
    );

Map<String, dynamic> _$FinansijskiLimitToJson(FinansijskiLimit instance) =>
    <String, dynamic>{
      'finansijskiLimitId': instance.finansijskiLimitId,
      'korisnikId': instance.korisnikId,
      'kategorijaId': instance.kategorijaId,
      'limit': instance.limit,
    };
