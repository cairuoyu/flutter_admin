import 'dart:convert';

class UserInfo {
  bool? selected;
  String? id;
  String? userId;
  String? nickName;
  String? avatarUrl;
  String? gender;
  String? country;
  String? province;
  String? city;
  String? name;
  String? school;
  String? major;
  String? birthday;
  String? entrance;
  String? hometown;
  String? memo;
  String? deptId;
  String? deptName;
  String? createTime;
  String? updateTime;
  String? userName;

  UserInfo({
    this.selected,
    this.id,
    this.userId,
    this.nickName,
    this.avatarUrl,
    this.gender,
    this.country,
    this.province,
    this.city,
    this.name,
    this.school,
    this.major,
    this.birthday,
    this.entrance,
    this.hometown,
    this.memo,
    this.deptId,
    this.deptName,
    this.createTime,
    this.updateTime,
    this.userName,
  });

  UserInfo copyWith({
    bool? selected,
    String? id,
    String? userId,
    String? nickName,
    String? avatarUrl,
    String? gender,
    String? country,
    String? province,
    String? city,
    String? name,
    String? school,
    String? major,
    String? birthday,
    String? entrance,
    String? hometown,
    String? memo,
    String? deptId,
    String? deptName,
    String? createTime,
    String? updateTime,
    String? userName,
  }) {
    return UserInfo(
      selected: selected ?? this.selected,
      id: id ?? this.id,
      userId: userId ?? this.userId,
      nickName: nickName ?? this.nickName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      gender: gender ?? this.gender,
      country: country ?? this.country,
      province: province ?? this.province,
      city: city ?? this.city,
      name: name ?? this.name,
      school: school ?? this.school,
      major: major ?? this.major,
      birthday: birthday ?? this.birthday,
      entrance: entrance ?? this.entrance,
      hometown: hometown ?? this.hometown,
      memo: memo ?? this.memo,
      deptId: deptId ?? this.deptId,
      deptName: deptName ?? this.deptName,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
      userName: userName ?? this.userName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'selected': selected,
      'id': id,
      'userId': userId,
      'nickName': nickName,
      'avatarUrl': avatarUrl,
      'gender': gender,
      'country': country,
      'province': province,
      'city': city,
      'name': name,
      'school': school,
      'major': major,
      'birthday': birthday,
      'entrance': entrance,
      'hometown': hometown,
      'memo': memo,
      'deptId': deptId,
      'deptName': deptName,
      'createTime': createTime,
      'updateTime': updateTime,
      'userName': userName,
    };
  }

  factory UserInfo.fromMap(Map<String?, dynamic> map) {
    return UserInfo(
      selected: map['selected'],
      id: map['id'],
      userId: map['userId'],
      nickName: map['nickName'],
      avatarUrl: map['avatarUrl'],
      gender: map['gender'],
      country: map['country'],
      province: map['province'],
      city: map['city'],
      name: map['name'],
      school: map['school'],
      major: map['major'],
      birthday: map['birthday'],
      entrance: map['entrance'],
      hometown: map['hometown'],
      memo: map['memo'],
      deptId: map['deptId'],
      deptName: map['deptName'],
      createTime: map['createTime'],
      updateTime: map['updateTime'],
      userName: map['userName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserInfo.fromJson(String source) => UserInfo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserInfo(selected: $selected, id: $id, userId: $userId, nickName: $nickName, avatarUrl: $avatarUrl, gender: $gender, country: $country, province: $province, city: $city, name: $name, school: $school, major: $major, birthday: $birthday, entrance: $entrance, hometown: $hometown, memo: $memo, deptId: $deptId, deptName: $deptName, createTime: $createTime, updateTime: $updateTime, userName: $userName)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is UserInfo &&
        o.selected == selected &&
        o.id == id &&
        o.userId == userId &&
        o.nickName == nickName &&
        o.avatarUrl == avatarUrl &&
        o.gender == gender &&
        o.country == country &&
        o.province == province &&
        o.city == city &&
        o.name == name &&
        o.school == school &&
        o.major == major &&
        o.birthday == birthday &&
        o.entrance == entrance &&
        o.hometown == hometown &&
        o.memo == memo &&
        o.deptId == deptId &&
        o.deptName == deptName &&
        o.createTime == createTime &&
        o.updateTime == updateTime &&
        o.userName == userName;
  }

  @override
  int get hashCode {
    return selected.hashCode ^
        id.hashCode ^
        userId.hashCode ^
        nickName.hashCode ^
        avatarUrl.hashCode ^
        gender.hashCode ^
        country.hashCode ^
        province.hashCode ^
        city.hashCode ^
        name.hashCode ^
        school.hashCode ^
        major.hashCode ^
        birthday.hashCode ^
        entrance.hashCode ^
        hometown.hashCode ^
        memo.hashCode ^
        deptId.hashCode ^
        deptName.hashCode ^
        createTime.hashCode ^
        updateTime.hashCode ^
        userName.hashCode;
  }
}
