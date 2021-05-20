import 'dart:convert';

class Subsystem {
  String? id;

  String? code;

  String? name;

  String? url;

  String? orderBy;

  String? remark;

  String? state;

  String? createTime;

  String? updateTime;

  String? createrId;

  String? updateId;
  Subsystem({
    this.id,
    this.code,
    this.name,
    this.url,
    this.orderBy,
    this.remark,
    this.state,
    this.createTime,
    this.updateTime,
    this.createrId,
    this.updateId,
  });

  Subsystem copyWith({
    String? id,
    String? code,
    String? name,
    String? url,
    String? orderBy,
    String? remark,
    String? state,
    String? createTime,
    String? updateTime,
    String? createrId,
    String? updateId,
  }) {
    return Subsystem(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      url: url ?? this.url,
      orderBy: orderBy ?? this.orderBy,
      remark: remark ?? this.remark,
      state: state ?? this.state,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
      createrId: createrId ?? this.createrId,
      updateId: updateId ?? this.updateId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'url': url,
      'orderBy': orderBy,
      'remark': remark,
      'state': state,
      'createTime': createTime,
      'updateTime': updateTime,
      'createrId': createrId,
      'updateId': updateId,
    };
  }

  factory Subsystem.fromMap(Map<String?, dynamic> map) {

    return Subsystem(
      id: map['id'],
      code: map['code'],
      name: map['name'],
      url: map['url'],
      orderBy: map['orderBy'],
      remark: map['remark'],
      state: map['state'],
      createTime: map['createTime'],
      updateTime: map['updateTime'],
      createrId: map['createrId'],
      updateId: map['updateId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Subsystem.fromJson(String source) => Subsystem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Subsystem(id: $id, code: $code, name: $name, url: $url, orderBy: $orderBy, remark: $remark, state: $state, createTime: $createTime, updateTime: $updateTime, createrId: $createrId, updateId: $updateId)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Subsystem &&
      o.id == id &&
      o.code == code &&
      o.name == name &&
      o.url == url &&
      o.orderBy == orderBy &&
      o.remark == remark &&
      o.state == state &&
      o.createTime == createTime &&
      o.updateTime == updateTime &&
      o.createrId == createrId &&
      o.updateId == updateId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      code.hashCode ^
      name.hashCode ^
      url.hashCode ^
      orderBy.hashCode ^
      remark.hashCode ^
      state.hashCode ^
      createTime.hashCode ^
      updateTime.hashCode ^
      createrId.hashCode ^
      updateId.hashCode;
  }
}
