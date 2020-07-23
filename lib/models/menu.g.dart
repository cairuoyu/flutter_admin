// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Menu _$MenuFromJson(Map<String, dynamic> json) {
  return Menu()
    ..id = json['id'] as String
    ..name = json['name'] as String
    ..nameEn = json['nameEn'] as String
    ..icon = json['icon'] as String
    ..pid = json['pid'] as String
    ..url = json['url'] as String
    ..module = json['module'] as String
    ..remark = json['remark'] as String
    ..createTime = json['createTime'] as String
    ..updateTime = json['updateTime'] as String;
}

Map<String, dynamic> _$MenuToJson(Menu instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'nameEn': instance.nameEn,
      'icon': instance.icon,
      'pid': instance.pid,
      'url': instance.url,
      'module': instance.module,
      'remark': instance.remark,
      'createTime': instance.createTime,
      'updateTime': instance.updateTime
    };
