import 'package:ecommerce_mobile/model/radni_prostor.dart';
import 'package:ecommerce_mobile/model/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rezervacija_prostora.g.dart';

@JsonSerializable()
class RezervacijaProstora {

  int? rezervacijaProstoraId;
  int? radniProstorId;
  RadniProstor? radniProstor;
  int? korisnikId;
  User? korisnik;
  DateTime? datumEvidencije;
  int? trajanje;
  String? statusRezervacije;
  String? napomena;

  RezervacijaProstora({
    this.rezervacijaProstoraId,
    this.radniProstorId,
    this.korisnikId,
    this.korisnik,
    this.datumEvidencije,
    this.trajanje,
    this.statusRezervacije,
    this.napomena,
    this.radniProstor

  });

  factory RezervacijaProstora.fromJson(Map<String, dynamic> json) => _$RezervacijaProstoraFromJson(json);

  Map<String, dynamic> toJson() => _$RezervacijaProstoraToJson(this);
} 