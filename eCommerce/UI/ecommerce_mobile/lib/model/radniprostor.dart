import 'package:json_annotation/json_annotation.dart';

part 'radniprostor.g.dart';

@JsonSerializable()
class RadniProstor {
  int? radniProstorId;
  String? oznaka;
  int? kapacitet;
  bool? aktivna;

  RadniProstor({
    this.radniProstorId,
    this.oznaka,
    this.kapacitet,
    this.aktivna,
  });

  factory RadniProstor.fromJson(Map<String, dynamic> json) => _$RadniProstorFromJson(json);

  Map<String, dynamic> toJson() => _$RadniProstorToJson(this);
} 