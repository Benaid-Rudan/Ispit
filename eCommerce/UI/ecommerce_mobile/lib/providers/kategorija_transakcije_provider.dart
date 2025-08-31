import 'package:ecommerce_mobile/model/kategorija_transakcije.dart';
import 'package:ecommerce_mobile/providers/base_provider.dart';

class KategorijaTransakcijeProvider extends BaseProvider<KategorijaTransakcije> {
  KategorijaTransakcijeProvider() : super("KategorijaTransakcije");

  @override
  KategorijaTransakcije fromJson(dynamic json) {
    return KategorijaTransakcije.fromJson(json);
  }
}
