// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) {
  return UserInfo()
    ..selected = json['selected'] as bool
    ..id = json['id'] as String
    ..userId = json['userId'] as String
    ..nickName = json['nickName'] as String
    ..avatarUrl = json['avatarUrl'] as String
    ..gender = json['gender'] as String
    ..country = json['country'] as String
    ..province = json['province'] as String
    ..city = json['city'] as String
    ..name = json['name'] as String
    ..school = json['school'] as String
    ..major = json['major'] as String
    ..birthday = json['birthday'] as String
    ..entrance = json['entrance'] as String
    ..hometown = json['hometown'] as String
    ..memo = json['memo'] as String
    ..deptId = json['deptId'] as String
    ..createTime = json['createTime'] as String
    ..updateTime = json['updateTime'] as String;
}

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'selected': instance.selected,
      'id': instance.id,
      'userId': instance.userId,
      'nickName': instance.nickName,
      'avatarUrl': instance.avatarUrl,
      'gender': instance.gender,
      'country': instance.country,
      'province': instance.province,
      'city': instance.city,
      'name': instance.name,
      'school': instance.school,
      'major': instance.major,
      'birthday': instance.birthday,
      'entrance': instance.entrance,
      'hometown': instance.hometown,
      'memo': instance.memo,
      'deptId': instance.deptId,
      'createTime': instance.createTime,
      'updateTime': instance.updateTime
    };
