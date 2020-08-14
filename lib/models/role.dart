import 'package:json_annotation/json_annotation.dart';

part 'role.g.dart';

@JsonSerializable()
class Role {
    Role();

    bool selected;
    String id;
    String name;
    String nameEn;
    String createTime;
    String updateTime;
    
    factory Role.fromJson(Map<String,dynamic> json) => _$RoleFromJson(json);
    Map<String, dynamic> toJson() => _$RoleToJson(this);
}
