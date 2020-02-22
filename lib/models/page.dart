import 'package:json_annotation/json_annotation.dart';
import "orderItem.dart";
part 'page.g.dart';

@JsonSerializable()
class Page {
    Page();

    num total=0;
    num size=10;
    num current=1;
    num pages=1;
    List<OrderItem> orders = [];
    List<Map> records;
    
    factory Page.fromJson(Map<String,dynamic> json) => _$PageFromJson(json);
    Map<String, dynamic> toJson() => _$PageToJson(this);
}
