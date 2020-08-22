// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageModel _$PageModelFromJson(Map<String, dynamic> json) {
  return PageModel()
    ..total = json['total'] as num
    ..size = json['size'] as num
    ..current = json['current'] as num
    ..pages = json['pages'] as num
    ..orders = (json['orders'] as List)
        ?.map((e) =>
            e == null ? null : OrderItem.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..records = (json['records'] as List)
        ?.map((e) => e as Map<String, dynamic>)
        ?.toList();
}

Map<String, dynamic> _$PageModelToJson(PageModel instance) => <String, dynamic>{
      'total': instance.total,
      'size': instance.size,
      'current': instance.current,
      'pages': instance.pages,
      'orders': instance.orders,
      'records': instance.records
    };
