import 'package:json_annotation/json_annotation.dart';

part 'challenge.g.dart';

@JsonSerializable()
class Challenge {
  int? challengeId;
  String? naziv;
  String? tipIzazova;
  int? praviloUspjeha;

  Challenge({
    this.challengeId,
    this.naziv,
    this.tipIzazova,
    this.praviloUspjeha,
  });

  factory Challenge.fromJson(Map<String, dynamic> json) => _$ChallengeFromJson(json);

  Map<String, dynamic> toJson() => _$ChallengeToJson(this);
} 