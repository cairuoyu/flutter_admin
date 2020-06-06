// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Image _$ImageFromJson(Map<String, dynamic> json) {
  return Image()
    ..title = json['title'] as String
    ..url = json['url'] as String
    ..categoryId = json['categoryId'] as String
    ..thumbs = json['thumbs'] as String
    ..memo = json['memo'] as String
    ..createTime = json['createTime'] as String;
}

Map<String, dynamic> _$ImageToJson(Image instance) => <String, dynamic>{
      'title': instance.title,
      'url': instance.url,
      'categoryId': instance.categoryId,
      'thumbs': instance.thumbs,
      'memo': instance.memo,
      'createTime': instance.createTime
    };
