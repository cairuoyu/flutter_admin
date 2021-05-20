import 'dart:convert';

import 'package:cry/vo/tree_vo.dart';

class Dept extends TreeData {
  String? id;

  String? name;

  String? nameShort;

  String? pid;

  String? headerId;

  String? fun;

  String? remark;

  int? orderBy;

  String? createTime;

  String? updateTime;

  String? createrId;

  String? updateId;

  Dept({
    this.id,
    this.name,
    this.nameShort,
    this.pid,
    this.headerId,
    this.fun,
    this.remark,
    this.orderBy,
    this.createTime,
    this.updateTime,
    this.createrId,
    this.updateId,
  }) : super(id, pid);

  Dept copyWith({
    String? id,
    String? name,
    String? nameShort,
    String? pid,
    String? headerId,
    String? fun,
    String? remark,
    int? orderBy,
    String? createTime,
    String? updateTime,
    String? createrId,
    String? updateId,
  }) {
    return Dept(
      id: id ?? this.id,
      name: name ?? this.name,
      nameShort: nameShort ?? this.nameShort,
      pid: pid ?? this.pid,
      headerId: headerId ?? this.headerId,
      fun: fun ?? this.fun,
      remark: remark ?? this.remark,
      orderBy: orderBy ?? this.orderBy,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
      createrId: createrId ?? this.createrId,
      updateId: updateId ?? this.updateId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'nameShort': nameShort,
      'pid': pid,
      'headerId': headerId,
      'fun': fun,
      'remark': remark,
      'orderBy': orderBy,
      'createTime': createTime,
      'updateTime': updateTime,
      'createrId': createrId,
      'updateId': updateId,
    };
  }

  factory Dept.fromMap(Map<String, dynamic> map) {
    return Dept(
      id: map['id'],
      name: map['name'],
      nameShort: map['nameShort'],
      pid: map['pid'],
      headerId: map['headerId'],
      fun: map['fun'],
      remark: map['remark'],
      orderBy: map['orderBy'],
      createTime: map['createTime'],
      updateTime: map['updateTime'],
      createrId: map['createrId'],
      updateId: map['updateId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Dept.fromJson(String source) => Dept.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Dept(id: $id, name: $name, nameShort: $nameShort, pid: $pid, headerId: $headerId, fun: $fun, remark: $remark, orderBy: $orderBy, createTime: $createTime, updateTime: $updateTime, createrId: $createrId, updateId: $updateId)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Dept &&
        o.id == id &&
        o.name == name &&
        o.nameShort == nameShort &&
        o.pid == pid &&
        o.headerId == headerId &&
        o.fun == fun &&
        o.remark == remark &&
        o.orderBy == orderBy &&
        o.createTime == createTime &&
        o.updateTime == updateTime &&
        o.createrId == createrId &&
        o.updateId == updateId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        nameShort.hashCode ^
        pid.hashCode ^
        headerId.hashCode ^
        fun.hashCode ^
        remark.hashCode ^
        orderBy.hashCode ^
        createTime.hashCode ^
        updateTime.hashCode ^
        createrId.hashCode ^
        updateId.hashCode;
  }
}
