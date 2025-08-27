import 'package:json_annotation/json_annotation.dart';

part 'challenge.g.dart';

@JsonSerializable()
class Challenge {
  final int? challengeId;
  final String? nazivIzazova;
  final String? praviloUspjeha;
  final String? tipIzazova;

  Challenge({
    this.challengeId,
    this.nazivIzazova,
    this.praviloUspjeha,
    this.tipIzazova,
  });

  factory Challenge.fromJson(Map<String, dynamic> json) =>
      _$ChallengeFromJson(json);

  Map<String, dynamic> toJson() => _$ChallengeToJson(this);
}
