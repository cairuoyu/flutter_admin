import 'dart:convert';


class SubsystemVO {
  String? name;
  String? code;
  bool? isEnable;
  bool? isDisable;
  SubsystemVO({
    this.name,
    this.code,
    this.isEnable = true,
    this.isDisable = false,
  });

  SubsystemVO copyWith({
    String? name,
    String? code,
    bool? isEnable,
    bool? isDisable,
  }) {
    return SubsystemVO(
      name: name ?? this.name,
      code: code ?? this.code,
      isEnable: isEnable ?? this.isEnable,
      isDisable: isDisable ?? this.isDisable,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'code': code,
      'isEnable': isEnable,
      'isDisable': isDisable,
    };
  }

  factory SubsystemVO.fromMap(Map<String, dynamic> map) {

    return SubsystemVO(
      name: map['name'],
      code: map['code'],
      isEnable: map['isEnable'],
      isDisable: map['isDisable'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SubsystemVO.fromJson(String source) => SubsystemVO.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SubsystemVO(name: $name, code: $code, isEnable: $isEnable, isDisable: $isDisable)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is SubsystemVO &&
      o.name == name &&
      o.code == code &&
      o.isEnable == isEnable &&
      o.isDisable == isDisable;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      code.hashCode ^
      isEnable.hashCode ^
      isDisable.hashCode;
  }
}
