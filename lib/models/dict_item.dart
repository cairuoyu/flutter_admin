import 'dart:convert';

class DictItem {
  String? id;
  String? dictId;

  String? code;

  String? name;

  String? createTime;

  String? updateTime;

  String? createrId;

  DictItem({
    this.id,
    this.dictId,
    this.code,
    this.name,
    this.createTime,
    this.updateTime,
    this.createrId,
  });

  DictItem copyWith({
    String? id,
    String? dictId,
    String? code,
    String? name,
    String? createTime,
    String? updateTime,
    String? createrId,
  }) {
    return DictItem(
      id: id ?? this.id,
      dictId: dictId ?? this.dictId,
      code: code ?? this.code,
      name: name ?? this.name,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
      createrId: createrId ?? this.createrId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dictId': dictId,
      'code': code,
      'name': name,
      'createTime': createTime,
      'updateTime': updateTime,
      'createrId': createrId,
    };
  }

  factory DictItem.fromMap(Map<String, dynamic> map) {

    return DictItem(
      id: map['id'],
      dictId: map['dictId'],
      code: map['code'],
      name: map['name'],
      createTime: map['createTime'],
      updateTime: map['updateTime'],
      createrId: map['createrId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DictItem.fromJson(String source) => DictItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DictItem(id: $id, dictId: $dictId, code: $code, name: $name, createTime: $createTime, updateTime: $updateTime, createrId: $createrId)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is DictItem &&
      o.id == id &&
      o.dictId == dictId &&
      o.code == code &&
      o.name == name &&
      o.createTime == createTime &&
      o.updateTime == updateTime &&
      o.createrId == createrId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      dictId.hashCode ^
      code.hashCode ^
      name.hashCode ^
      createTime.hashCode ^
      updateTime.hashCode ^
      createrId.hashCode;
  }
}
