import 'package:ecommerce_mobile/model/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mood.g.dart';

@JsonSerializable()
class Mood {
  int? moodId;
  int? korisnikId;
  User? korisnik;
  DateTime? datumEvidencije;
  String? opis;
   String? status;

  Mood({
    this.moodId,
    this.korisnikId,
    this.korisnik,
    this.datumEvidencije,
    this.opis,
    this.status,
  });

  factory Mood.fromJson(Map<String, dynamic> json) => _$MoodFromJson(json);

  Map<String, dynamic> toJson() => _$MoodToJson(this);
}

