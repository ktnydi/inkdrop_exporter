// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notebook.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Notebook _$$_NotebookFromJson(Map<String, dynamic> json) => _$_Notebook(
      id: const IdConverter().fromJson(json['_id'] as String),
      title: json['title'] as String,
      body: json['body'] as String,
      createdAt: const DateTimeConverter().fromJson(json['createdAt'] as int),
      updatedAt: const DateTimeConverter().fromJson(json['updatedAt'] as int),
    );

Map<String, dynamic> _$$_NotebookToJson(_$_Notebook instance) =>
    <String, dynamic>{
      '_id': const IdConverter().toJson(instance.id),
      'title': instance.title,
      'body': instance.body,
      'createdAt': const DateTimeConverter().toJson(instance.createdAt),
      'updatedAt': const DateTimeConverter().toJson(instance.updatedAt),
    };
