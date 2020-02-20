// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requestBodyApi.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestBodyApi _$RequestBodyApiFromJson(Map<String, dynamic> json) {
  return RequestBodyApi()
    ..page = json['page'] == null
        ? null
        : Page.fromJson(json['page'] as Map<String, dynamic>)
    ..params = json['params'] as Map<String, dynamic>;
}

Map<String, dynamic> _$RequestBodyApiToJson(RequestBodyApi instance) =>
    <String, dynamic>{'page': instance.page, 'params': instance.params};
