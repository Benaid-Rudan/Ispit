import 'package:json_annotation/json_annotation.dart';

part 'kategorija_transakcije.g.dart';

@JsonSerializable()
class KategorijaTransakcije {
  int? kategorijaTransakcijeId;
  String? naziv;
  String? tip;

  KategorijaTransakcije({
    this.kategorijaTransakcijeId,
    this.naziv,
    this.tip,
  });

  factory KategorijaTransakcije.fromJson(Map<String, dynamic> json) => _$KategorijaTransakcijeFromJson(json);

  Map<String, dynamic> toJson() => _$KategorijaTransakcijeToJson(this);
} 