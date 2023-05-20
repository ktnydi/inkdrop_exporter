import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:inkdrop_exporter/notebook/date_time_converter.dart';
import 'package:inkdrop_exporter/notebook/id_converter.dart';

part 'notebook.freezed.dart';
part 'notebook.g.dart';

@freezed
class Notebook with _$Notebook {
  const factory Notebook({
    @JsonKey(name: '_id') @IdConverter() required String id,
    required String title,
    required String body,
    @DateTimeConverter() required DateTime createdAt,
    @DateTimeConverter() required DateTime updatedAt,
  }) = _Notebook;

  factory Notebook.fromJson(Map<String, dynamic> json) =>
      _$NotebookFromJson(json);
}
