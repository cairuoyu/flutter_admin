import 'package:json_annotation/json_annotation.dart';

part 'orderItem.g.dart';

@JsonSerializable()
class OrderItem {
    OrderItem({this.column,this.asc});

    String column;
    bool asc;
    
    factory OrderItem.fromJson(Map<String,dynamic> json) => _$OrderItemFromJson(json);
    Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}
