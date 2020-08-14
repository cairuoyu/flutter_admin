// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Role _$RoleFromJson(Map<String, dynamic> json) {
  return Role()
    ..selected = json['selected'] as bool
    ..id = json['id'] as String
    ..name = json['name'] as String
    ..nameEn = json['nameEn'] as String
    ..createTime = json['createTime'] as String
    ..updateTime = json['updateTime'] as String;
}

Map<String, dynamic> _$RoleToJson(Role instance) => <String, dynamic>{
      'selected': instance.selected,
      'id': instance.id,
      'name': instance.name,
      'nameEn': instance.nameEn,
      'createTime': instance.createTime,
      'updateTime': instance.updateTime
    };
