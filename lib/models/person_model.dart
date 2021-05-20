class PersonModel {

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
    String? createTime;
    String? updateTime;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

    PersonModel({
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
    this.createTime,
    this.updateTime,
  });

    PersonModel copyWith({
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
    String? createTime,
    String? updateTime,
  }) {
    return new PersonModel(
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
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
    );
  }

    @override
  String toString() {
    return 'PersonModel{selected: $selected, id: $id, userId: $userId, nickName: $nickName, avatarUrl: $avatarUrl, gender: $gender, country: $country, province: $province, city: $city, name: $name, school: $school, major: $major, birthday: $birthday, entrance: $entrance, hometown: $hometown, memo: $memo, deptId: $deptId, createTime: $createTime, updateTime: $updateTime}';
  }

    @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PersonModel &&
          runtimeType == other.runtimeType &&
          selected == other.selected &&
          id == other.id &&
          userId == other.userId &&
          nickName == other.nickName &&
          avatarUrl == other.avatarUrl &&
          gender == other.gender &&
          country == other.country &&
          province == other.province &&
          city == other.city &&
          name == other.name &&
          school == other.school &&
          major == other.major &&
          birthday == other.birthday &&
          entrance == other.entrance &&
          hometown == other.hometown &&
          memo == other.memo &&
          deptId == other.deptId &&
          createTime == other.createTime &&
          updateTime == other.updateTime);

    @override
  int get hashCode =>
      selected.hashCode ^
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
      createTime.hashCode ^
      updateTime.hashCode;

    factory PersonModel.fromMap(Map<String?, dynamic> map) {
    return new PersonModel(
      selected: map['selected'] as bool?,
      id: map['id'] as String?,
      userId: map['userId'] as String?,
      nickName: map['nickName'] as String?,
      avatarUrl: map['avatarUrl'] as String?,
      gender: map['gender'] as String?,
      country: map['country'] as String?,
      province: map['province'] as String?,
      city: map['city'] as String?,
      name: map['name'] as String?,
      school: map['school'] as String?,
      major: map['major'] as String?,
      birthday: map['birthday'] as String?,
      entrance: map['entrance'] as String?,
      hometown: map['hometown'] as String?,
      memo: map['memo'] as String?,
      deptId: map['deptId'] as String?,
      createTime: map['createTime'] as String?,
      updateTime: map['updateTime'] as String?,
    );
  }

    Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'selected': this.selected,
      'id': this.id,
      'userId': this.userId,
      'nickName': this.nickName,
      'avatarUrl': this.avatarUrl,
      'gender': this.gender,
      'country': this.country,
      'province': this.province,
      'city': this.city,
      'name': this.name,
      'school': this.school,
      'major': this.major,
      'birthday': this.birthday,
      'entrance': this.entrance,
      'hometown': this.hometown,
      'memo': this.memo,
      'deptId': this.deptId,
      'createTime': this.createTime,
      'updateTime': this.updateTime,
    } as Map<String, dynamic>;
  }

//</editor-fold>

}
