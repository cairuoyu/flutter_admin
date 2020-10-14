import 'dart:convert';

class Dict {
  String id;
  String code;

  String name;

  String createTime;

  String updateTime;

  String createrId;
  String state;

  Dict({
    this.id,
    this.code,
    this.name,
    this.createTime,
    this.updateTime,
    this.createrId,
    this.state,
  });

  Dict copyWith({
    String id,
    String code,
    String name,
    String createTime,
    String updateTime,
    String createrId,
    String state,
  }) {
    return Dict(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
      createrId: createrId ?? this.createrId,
      state: state ?? this.state,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'createTime': createTime,
      'updateTime': updateTime,
      'createrId': createrId,
      'state': state,
    };
  }

  factory Dict.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Dict(
      id: map['id'],
      code: map['code'],
      name: map['name'],
      createTime: map['createTime'],
      updateTime: map['updateTime'],
      createrId: map['createrId'],
      state: map['state'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Dict.fromJson(String source) => Dict.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Dict(id: $id, code: $code, name: $name, createTime: $createTime, updateTime: $updateTime, createrId: $createrId, state: $state)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Dict &&
      o.id == id &&
      o.code == code &&
      o.name == name &&
      o.createTime == createTime &&
      o.updateTime == updateTime &&
      o.createrId == createrId &&
      o.state == state;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      code.hashCode ^
      name.hashCode ^
      createTime.hashCode ^
      updateTime.hashCode ^
      createrId.hashCode ^
      state.hashCode;
  }
}
