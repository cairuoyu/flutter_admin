import 'package:json_annotation/json_annotation.dart';

part 'person.g.dart';

@JsonSerializable()
class Person {
    Person();

    bool selected;
    String id;
    String userId;
    String nickName;
    String avatarUrl;
    String gender;
    String country;
    String province;
    String city;
    String name;
    String school;
    String major;
    String birthday;
    String entrance;
    String hometown;
    String memo;
    String deptId;
    String createTime;
    String updateTime;
    
    factory Person.fromJson(Map<String,dynamic> json) => _$PersonFromJson(json);
    Map<String, dynamic> toJson() => _$PersonToJson(this);
}
