class Role {

    bool? selected;
    String? id;
    String? name;
    String? nameEn;
    String? createTime;
    String? updateTime;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

    Role({
    this.selected,
    this.id,
    this.name,
    this.nameEn,
    this.createTime,
    this.updateTime,
  });

    Role copyWith({
    bool? selected,
    String? id,
    String? name,
    String? nameEn,
    String? createTime,
    String? updateTime,
  }) {
    return new Role(
      selected: selected ?? this.selected,
      id: id ?? this.id,
      name: name ?? this.name,
      nameEn: nameEn ?? this.nameEn,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
    );
  }

    @override
  String toString() {
    return 'Role{selected: $selected, id: $id, name: $name, nameEn: $nameEn, createTime: $createTime, updateTime: $updateTime}';
  }

    @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Role &&
          runtimeType == other.runtimeType &&
          selected == other.selected &&
          id == other.id &&
          name == other.name &&
          nameEn == other.nameEn &&
          createTime == other.createTime &&
          updateTime == other.updateTime);

    @override
  int get hashCode => selected.hashCode ^ id.hashCode ^ name.hashCode ^ nameEn.hashCode ^ createTime.hashCode ^ updateTime.hashCode;

    factory Role.fromMap(Map<String?, dynamic> map) {
    return new Role(
      selected: map['selected'] as bool?,
      id: map['id'] as String?,
      name: map['name'] as String?,
      nameEn: map['nameEn'] as String?,
      createTime: map['createTime'] as String?,
      updateTime: map['updateTime'] as String?,
    );
  }

    Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'selected': this.selected,
      'id': this.id,
      'name': this.name,
      'nameEn': this.nameEn,
      'createTime': this.createTime,
      'updateTime': this.updateTime,
    } as Map<String, dynamic>;
  }

//</editor-fold>

}
