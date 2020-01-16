import 'package:json_annotation/json_annotation.dart';

part 'userInfo.g.dart';

@JsonSerializable()
class UserInfo {
    UserInfo();

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
    
    factory UserInfo.fromJson(Map<String,dynamic> json) => _$UserInfoFromJson(json);
    Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}
