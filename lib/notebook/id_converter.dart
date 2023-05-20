import 'package:freezed_annotation/freezed_annotation.dart';

class IdConverter implements JsonConverter<String, String> {
  const IdConverter();

  @override
  String fromJson(String json) {
    return json.split(':').last;
  }

  @override
  String toJson(String object) {
    return 'note:$object';
  }
}
