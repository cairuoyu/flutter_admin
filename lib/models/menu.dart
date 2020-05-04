import 'package:json_annotation/json_annotation.dart';

part 'menu.g.dart';

@JsonSerializable()
class Menu {
  Menu({this.id, this.pid, this.name,this.url});

  String id;
  String name;
  String pid;
  String url;
  String module;
  String remark;
  String createTime;
  String updateTime;

  factory Menu.fromJson(Map<String, dynamic> json) => _$MenuFromJson(json);
  Map<String, dynamic> toJson() => _$MenuToJson(this);
}
