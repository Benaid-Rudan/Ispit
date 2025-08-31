import 'package:ecommerce_mobile/model/kategorija_transakcije.dart';
import 'package:ecommerce_mobile/model/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'limit.g.dart';

@JsonSerializable()
class Limit {
  int? limitId;
  int? iznos;

  int? korisnikId;
  User? korisnik;
  
  int? kategorijaTransakcijeId;
  KategorijaTransakcije? kategorijaTransakcije;


  Limit({
    this.limitId,
    this.korisnikId,
    this.korisnik,
    this.iznos,
    this.kategorijaTransakcijeId,
    this.kategorijaTransakcije,
  });

  factory Limit.fromJson(Map<String, dynamic> json) => _$LimitFromJson(json);

  Map<String, dynamic> toJson() => _$LimitToJson(this);
} 