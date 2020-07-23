import 'package:json_annotation/json_annotation.dart';

import '../vo/treeVO.dart';

part 'menu.g.dart';

@JsonSerializable()
class Menu extends TreeData {
  Menu({String id, String pid, this.name, this.pname, this.url}) : super(id, pid);

  String name;
  String nameEn;
  String pname;
  String icon;
  String url;
  num orderBy;
  String module;
  String remark;
  String createTime;
  String updateTime;

  factory Menu.fromJson(Map<String, dynamic> json) => _$MenuFromJson(json);
  Map<String, dynamic> toJson() => _$MenuToJson(this);
}
