import 'package:json_annotation/json_annotation.dart';

part 'challenge.g.dart';

@JsonSerializable()
class Challenge {
  int? challengeId;
  String? naziv;
  int? pravilo;
  String? tipIzazova;


  Challenge({
    this.challengeId,
    this.naziv,
    this.pravilo,
    this.tipIzazova,
  });

  factory Challenge.fromJson(Map<String, dynamic> json) => _$ChallengeFromJson(json);

  Map<String, dynamic> toJson() => _$ChallengeToJson(this);
} 