import 'package:ecommerce_mobile/model/kategorija_transakcije.dart';
import 'package:ecommerce_mobile/model/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transakcija.g.dart';

@JsonSerializable()
class Transakcija {
  int? transakcijaId;
  int? korisnikId;
  User? korisnik;
  int? iznos;
  DateTime? datumTransakcije;
  String? opis;
  int? kategorijaTransakcijeId;
  KategorijaTransakcije? kategorijaTransakcije;
  String? status;


  Transakcija({
    this.transakcijaId,
    this.korisnikId,
    this.korisnik,
    this.iznos,
    this.datumTransakcije,
    this.opis,
    this.kategorijaTransakcijeId,
    this.kategorijaTransakcije,
    this.status,
  });

  factory Transakcija.fromJson(Map<String, dynamic> json) => _$TransakcijaFromJson(json);

  Map<String, dynamic> toJson() => _$TransakcijaToJson(this);
} 