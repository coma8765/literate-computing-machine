import 'package:json_annotation/json_annotation.dart';

typedef Timestamp = int;

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }

  @override
  Timestamp toJson(DateTime date) => date.millisecondsSinceEpoch;
}
