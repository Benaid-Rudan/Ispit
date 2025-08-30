import 'package:ecommerce_mobile/model/mood.dart';
import 'package:ecommerce_mobile/providers/base_provider.dart';

class MoodProvider extends BaseProvider<Mood> {
  MoodProvider() : super("Mood");

  @override
  Mood fromJson(dynamic json) {
    return Mood.fromJson(json);
  }
}
