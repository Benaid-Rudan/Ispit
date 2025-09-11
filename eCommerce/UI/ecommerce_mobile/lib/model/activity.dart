import 'package:json_annotation/json_annotation.dart';

part 'activity.g.dart';

@JsonSerializable()
class Activity {
  int? activityId;
  String? name;
  String? description;
  DateTime? dueDate;
  Activity({
    this.activityId,
    this.name,
    this.description,
    this.dueDate,
  });

  factory Activity.fromJson(Map<String, dynamic> json) => _$ActivityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityToJson(this);
}
