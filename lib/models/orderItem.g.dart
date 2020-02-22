// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) {
  return OrderItem()
    ..column = json['column'] as String
    ..asc = json['asc'] as bool;
}

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) =>
    <String, dynamic>{'column': instance.column, 'asc': instance.asc};
