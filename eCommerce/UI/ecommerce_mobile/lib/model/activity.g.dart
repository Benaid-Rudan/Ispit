// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Activity _$ActivityFromJson(Map<String, dynamic> json) => Activity(
      activityId: (json['activityId'] as num?)?.toInt(),
      name: json['name'] as String?,
      description: json['description'] as String?,
      dueDate: json['dueDate'] == null
          ? null
          : DateTime.parse(json['dueDate'] as String),
    );

Map<String, dynamic> _$ActivityToJson(Activity instance) => <String, dynamic>{
      'activityId': instance.activityId,
      'name': instance.name,
      'description': instance.description,
      'dueDate': instance.dueDate?.toIso8601String(),
    };
