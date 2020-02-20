import 'package:json_annotation/json_annotation.dart';
import "orderItem.dart";
part 'page.g.dart';

@JsonSerializable()
class Page {
    Page({this.orders});

    num current;
    List<OrderItem> orders;
    
    factory Page.fromJson(Map<String,dynamic> json) => _$PageFromJson(json);
    Map<String, dynamic> toJson() => _$PageToJson(this);
}
