// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responseBodyApi.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseBodyApi _$ResponseBodyApiFromJson(Map<String, dynamic> json) {
  return ResponseBodyApi()
    ..success = json['success'] as bool
    ..code = json['code'] as String
    ..message = json['message'] as String
    ..data = json['data'];
}

Map<String, dynamic> _$ResponseBodyApiToJson(ResponseBodyApi instance) =>
    <String, dynamic>{
      'success': instance.success,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data
    };
