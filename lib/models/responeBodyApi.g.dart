// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responeBodyApi.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponeBodyApi _$ResponeBodyApiFromJson(Map<String, dynamic> json) {
  return ResponeBodyApi()
    ..success = json['success'] as bool
    ..code = json['code'] as String
    ..message = json['message'] as String
    ..data = json['data'];
}

Map<String, dynamic> _$ResponeBodyApiToJson(ResponeBodyApi instance) =>
    <String, dynamic>{
      'success': instance.success,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data
    };
