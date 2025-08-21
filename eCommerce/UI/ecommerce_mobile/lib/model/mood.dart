import 'package:ecommerce_mobile/model/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mood.g.dart';

@JsonSerializable()
class Mood {
  int? moodId;
  int? korisnikId;
  User? korisnik;
  String? statusRaspolozenja;
  String? opis;
  DateTime? datumEvidencije;

  Mood({
    this.moodId,
    this.korisnikId,  
    this.korisnik,
    this.statusRaspolozenja,
    this.opis,
    this.datumEvidencije,
    });

  factory Mood.fromJson(Map<String, dynamic> json) => _$MoodFromJson(json);

  Map<String, dynamic> toJson() => _$MoodToJson(this);
} 