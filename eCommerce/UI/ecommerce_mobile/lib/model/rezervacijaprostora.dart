import 'package:ecommerce_mobile/model/radniprostor.dart';
import 'package:ecommerce_mobile/model/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rezervacijaprostora.g.dart';

@JsonSerializable()
class RezervacijaProstora {
  int? rezervacijaProstoraId;
  int? radniProstorId;
  int? korisnikId;
  User? korisnik;
  RadniProstor? radniProstor;
  DateTime? datumRezervacije;
  int? trajanje;
  String? status;
  String? napomena;

  RezervacijaProstora({
    this.rezervacijaProstoraId,
    this.radniProstorId,
    this.korisnikId,
    this.korisnik,
    this.radniProstor,
    this.datumRezervacije,
    this.trajanje,
    this.status,
    this.napomena,
  });

  factory RezervacijaProstora.fromJson(Map<String, dynamic> json) => _$RezervacijaProstoraFromJson(json);

  Map<String, dynamic> toJson() => _$RezervacijaProstoraToJson(this);
} 