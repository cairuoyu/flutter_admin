import 'package:flutter_admin/vo/treeVO.dart';
import 'package:json_annotation/json_annotation.dart';

part 'menu.g.dart';

@JsonSerializable()
class Menu extends TreeData {
  Menu({String id, String pid, this.name, this.pname, this.url}) : super(id, pid);

  String name;
  String pname;
  String url;
  String module;
  String remark;
  String createTime;
  String updateTime;

  factory Menu.fromJson(Map<String, dynamic> json) => _$MenuFromJson(json);
  Map<String, dynamic> toJson() => _$MenuToJson(this);
}
