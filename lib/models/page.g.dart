// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Page _$PageFromJson(Map<String, dynamic> json) {
  return Page()
    ..current = json['current'] as num
    ..orders = (json['orders'] as List)
        ?.map((e) =>
            e == null ? null : OrderItem.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$PageToJson(Page instance) =>
    <String, dynamic>{'current': instance.current, 'orders': instance.orders};
