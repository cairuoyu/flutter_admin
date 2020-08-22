import 'package:json_annotation/json_annotation.dart';
import "orderItem.dart";
part 'page.g.dart';

@JsonSerializable()
class PageModel {
    PageModel({this.orders});

    num total=0;
    num size=10;
    num current=1;
    num pages=1;
    List<OrderItem> orders;
    List<Map> records;
    
    factory PageModel.fromJson(Map<String,dynamic> json) => _$PageModelFromJson(json);
    Map<String, dynamic> toJson() => _$PageModelToJson(this);
}
