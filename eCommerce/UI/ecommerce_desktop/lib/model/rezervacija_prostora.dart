import 'package:ecommerce_desktop/model/radni_prostor.dart';
import 'package:ecommerce_desktop/model/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rezervacija_prostora.g.dart';

@JsonSerializable()
class RezervacijaProstora {
  int? rezervacijaProstoraId;
  int? korisnikId;
  User? korisnik;
  int? radniProstorId;
  RadniProstor? radniProstor;
  DateTime? datumRezervacije;
  int? trajanje;
  String? statusRezervacije;
  String? napomena;

  RezervacijaProstora({
    this.rezervacijaProstoraId,
    this.korisnikId,
    this.korisnik,
    this.radniProstorId,
    this.radniProstor,
    this.datumRezervacije,
    this.trajanje,
    this.statusRezervacije,
    this.napomena,
  });

  factory RezervacijaProstora.fromJson(Map<String, dynamic> json) => _$RezervacijaProstoraFromJson(json);

  Map<String, dynamic> toJson() => _$RezervacijaProstoraToJson(this);
} 