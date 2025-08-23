import 'package:json_annotation/json_annotation.dart';

part 'limit.g.dart';
// public int FinansijskiLimitId { get; set; }
// public int KorisnikId { get; set; }
// public int KategorijaId { get; set; }
// public int Limit { get; set; }
@JsonSerializable()
class FinansijskiLimit {
  int? finansijskiLimitId;
  int? korisnikId;
  int? kategorijaId;
  String? limit;


  FinansijskiLimit({
    this.finansijskiLimitId,
    this.korisnikId,
    this.kategorijaId,
    this.limit,
  });

  factory FinansijskiLimit.fromJson(Map<String, dynamic> json) => _$FinansijskiLimitFromJson(json);

  Map<String, dynamic> toJson() => _$FinansijskiLimitToJson(this);
} 