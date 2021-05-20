import 'dart:convert';

class SAreaAgeGender {
  String? id;

  String? area;

  int? age;

  int? ageG1;

  int? ageG2;

  int? age1;

  int? age1G1;

  int? age1G2;

  int? age2;

  int? age2G1;

  int? age2G2;

  int? age3;

  int? age3G1;

  int? age3G2;

  int? age4;

  int? age4G1;

  int? age4G2;

  int? age5;

  int? age5G1;

  int? age5G2;

  int? age6;

  int? age6G1;

  int? age6G2;

  int? age7;

  int? age7G1;

  int? age7G2;

  int? age8;

  int? age8G1;

  int? age8G2;

  int? age9;

  int? age9G1;

  int? age9G2;

  int? age10;

  int? age10G1;

  int? age10G2;

  int? age11;

  int? age11G1;

  int? age11G2;

  int? age12;

  int? age12G1;

  int? age12G2;

  int? age13;

  int? age13G1;

  int? age13G2;

  int? age14;

  int? age14G1;

  int? age14G2;

  int? age15;

  int? age15G1;

  int? age15G2;

  int? age16;

  int? age16G1;

  int? age16G2;

  int? age17;

  int? age17G1;

  int? age17G2;

  int? age18;

  int? age18G1;

  int? age18G2;

  int? age19;

  int? age19G1;

  int? age19G2;

  int? age20;

  int? age20G1;

  int? age20G2;

  int? age21;

  int? age21G1;

  int? age21G2;

  int? age22;

  int? age22G1;

  int? age22G2;

  SAreaAgeGender({
    this.id,
    this.area,
    this.age,
    this.ageG1,
    this.ageG2,
    this.age1,
    this.age1G1,
    this.age1G2,
    this.age2,
    this.age2G1,
    this.age2G2,
    this.age3,
    this.age3G1,
    this.age3G2,
    this.age4,
    this.age4G1,
    this.age4G2,
    this.age5,
    this.age5G1,
    this.age5G2,
    this.age6,
    this.age6G1,
    this.age6G2,
    this.age7,
    this.age7G1,
    this.age7G2,
    this.age8,
    this.age8G1,
    this.age8G2,
    this.age9,
    this.age9G1,
    this.age9G2,
    this.age10,
    this.age10G1,
    this.age10G2,
    this.age11,
    this.age11G1,
    this.age11G2,
    this.age12,
    this.age12G1,
    this.age12G2,
    this.age13,
    this.age13G1,
    this.age13G2,
    this.age14,
    this.age14G1,
    this.age14G2,
    this.age15,
    this.age15G1,
    this.age15G2,
    this.age16,
    this.age16G1,
    this.age16G2,
    this.age17,
    this.age17G1,
    this.age17G2,
    this.age18,
    this.age18G1,
    this.age18G2,
    this.age19,
    this.age19G1,
    this.age19G2,
    this.age20,
    this.age20G1,
    this.age20G2,
    this.age21,
    this.age21G1,
    this.age21G2,
    this.age22,
    this.age22G1,
    this.age22G2,
  });

  SAreaAgeGender copyWith({
    String? id,
    String? area,
    int? age,
    int? ageG1,
    int? ageG2,
    int? age1,
    int? age1G1,
    int? age1G2,
    int? age2,
    int? age2G1,
    int? age2G2,
    int? age3,
    int? age3G1,
    int? age3G2,
    int? age4,
    int? age4G1,
    int? age4G2,
    int? age5,
    int? age5G1,
    int? age5G2,
    int? age6,
    int? age6G1,
    int? age6G2,
    int? age7,
    int? age7G1,
    int? age7G2,
    int? age8,
    int? age8G1,
    int? age8G2,
    int? age9,
    int? age9G1,
    int? age9G2,
    int? age10,
    int? age10G1,
    int? age10G2,
    int? age11,
    int? age11G1,
    int? age11G2,
    int? age12,
    int? age12G1,
    int? age12G2,
    int? age13,
    int? age13G1,
    int? age13G2,
    int? age14,
    int? age14G1,
    int? age14G2,
    int? age15,
    int? age15G1,
    int? age15G2,
    int? age16,
    int? age16G1,
    int? age16G2,
    int? age17,
    int? age17G1,
    int? age17G2,
    int? age18,
    int? age18G1,
    int? age18G2,
    int? age19,
    int? age19G1,
    int? age19G2,
    int? age20,
    int? age20G1,
    int? age20G2,
    int? age21,
    int? age21G1,
    int? age21G2,
    int? age22,
    int? age22G1,
    int? age22G2,
  }) {
    return SAreaAgeGender(
      id: id ?? this.id,
      area: area ?? this.area,
      age: age ?? this.age,
      ageG1: ageG1 ?? this.ageG1,
      ageG2: ageG2 ?? this.ageG2,
      age1: age1 ?? this.age1,
      age1G1: age1G1 ?? this.age1G1,
      age1G2: age1G2 ?? this.age1G2,
      age2: age2 ?? this.age2,
      age2G1: age2G1 ?? this.age2G1,
      age2G2: age2G2 ?? this.age2G2,
      age3: age3 ?? this.age3,
      age3G1: age3G1 ?? this.age3G1,
      age3G2: age3G2 ?? this.age3G2,
      age4: age4 ?? this.age4,
      age4G1: age4G1 ?? this.age4G1,
      age4G2: age4G2 ?? this.age4G2,
      age5: age5 ?? this.age5,
      age5G1: age5G1 ?? this.age5G1,
      age5G2: age5G2 ?? this.age5G2,
      age6: age6 ?? this.age6,
      age6G1: age6G1 ?? this.age6G1,
      age6G2: age6G2 ?? this.age6G2,
      age7: age7 ?? this.age7,
      age7G1: age7G1 ?? this.age7G1,
      age7G2: age7G2 ?? this.age7G2,
      age8: age8 ?? this.age8,
      age8G1: age8G1 ?? this.age8G1,
      age8G2: age8G2 ?? this.age8G2,
      age9: age9 ?? this.age9,
      age9G1: age9G1 ?? this.age9G1,
      age9G2: age9G2 ?? this.age9G2,
      age10: age10 ?? this.age10,
      age10G1: age10G1 ?? this.age10G1,
      age10G2: age10G2 ?? this.age10G2,
      age11: age11 ?? this.age11,
      age11G1: age11G1 ?? this.age11G1,
      age11G2: age11G2 ?? this.age11G2,
      age12: age12 ?? this.age12,
      age12G1: age12G1 ?? this.age12G1,
      age12G2: age12G2 ?? this.age12G2,
      age13: age13 ?? this.age13,
      age13G1: age13G1 ?? this.age13G1,
      age13G2: age13G2 ?? this.age13G2,
      age14: age14 ?? this.age14,
      age14G1: age14G1 ?? this.age14G1,
      age14G2: age14G2 ?? this.age14G2,
      age15: age15 ?? this.age15,
      age15G1: age15G1 ?? this.age15G1,
      age15G2: age15G2 ?? this.age15G2,
      age16: age16 ?? this.age16,
      age16G1: age16G1 ?? this.age16G1,
      age16G2: age16G2 ?? this.age16G2,
      age17: age17 ?? this.age17,
      age17G1: age17G1 ?? this.age17G1,
      age17G2: age17G2 ?? this.age17G2,
      age18: age18 ?? this.age18,
      age18G1: age18G1 ?? this.age18G1,
      age18G2: age18G2 ?? this.age18G2,
      age19: age19 ?? this.age19,
      age19G1: age19G1 ?? this.age19G1,
      age19G2: age19G2 ?? this.age19G2,
      age20: age20 ?? this.age20,
      age20G1: age20G1 ?? this.age20G1,
      age20G2: age20G2 ?? this.age20G2,
      age21: age21 ?? this.age21,
      age21G1: age21G1 ?? this.age21G1,
      age21G2: age21G2 ?? this.age21G2,
      age22: age22 ?? this.age22,
      age22G1: age22G1 ?? this.age22G1,
      age22G2: age22G2 ?? this.age22G2,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'area': area,
      'age': age,
      'ageG1': ageG1,
      'ageG2': ageG2,
      'age1': age1,
      'age1G1': age1G1,
      'age1G2': age1G2,
      'age2': age2,
      'age2G1': age2G1,
      'age2G2': age2G2,
      'age3': age3,
      'age3G1': age3G1,
      'age3G2': age3G2,
      'age4': age4,
      'age4G1': age4G1,
      'age4G2': age4G2,
      'age5': age5,
      'age5G1': age5G1,
      'age5G2': age5G2,
      'age6': age6,
      'age6G1': age6G1,
      'age6G2': age6G2,
      'age7': age7,
      'age7G1': age7G1,
      'age7G2': age7G2,
      'age8': age8,
      'age8G1': age8G1,
      'age8G2': age8G2,
      'age9': age9,
      'age9G1': age9G1,
      'age9G2': age9G2,
      'age10': age10,
      'age10G1': age10G1,
      'age10G2': age10G2,
      'age11': age11,
      'age11G1': age11G1,
      'age11G2': age11G2,
      'age12': age12,
      'age12G1': age12G1,
      'age12G2': age12G2,
      'age13': age13,
      'age13G1': age13G1,
      'age13G2': age13G2,
      'age14': age14,
      'age14G1': age14G1,
      'age14G2': age14G2,
      'age15': age15,
      'age15G1': age15G1,
      'age15G2': age15G2,
      'age16': age16,
      'age16G1': age16G1,
      'age16G2': age16G2,
      'age17': age17,
      'age17G1': age17G1,
      'age17G2': age17G2,
      'age18': age18,
      'age18G1': age18G1,
      'age18G2': age18G2,
      'age19': age19,
      'age19G1': age19G1,
      'age19G2': age19G2,
      'age20': age20,
      'age20G1': age20G1,
      'age20G2': age20G2,
      'age21': age21,
      'age21G1': age21G1,
      'age21G2': age21G2,
      'age22': age22,
      'age22G1': age22G1,
      'age22G2': age22G2,
    };
  }

  factory SAreaAgeGender.fromMap(Map<String, dynamic> map) {
    return SAreaAgeGender(
      id: map['id'],
      area: map['area'],
      age: map['age'],
      ageG1: map['ageG1'],
      ageG2: map['ageG2'],
      age1: map['age1'],
      age1G1: map['age1G1'],
      age1G2: map['age1G2'],
      age2: map['age2'],
      age2G1: map['age2G1'],
      age2G2: map['age2G2'],
      age3: map['age3'],
      age3G1: map['age3G1'],
      age3G2: map['age3G2'],
      age4: map['age4'],
      age4G1: map['age4G1'],
      age4G2: map['age4G2'],
      age5: map['age5'],
      age5G1: map['age5G1'],
      age5G2: map['age5G2'],
      age6: map['age6'],
      age6G1: map['age6G1'],
      age6G2: map['age6G2'],
      age7: map['age7'],
      age7G1: map['age7G1'],
      age7G2: map['age7G2'],
      age8: map['age8'],
      age8G1: map['age8G1'],
      age8G2: map['age8G2'],
      age9: map['age9'],
      age9G1: map['age9G1'],
      age9G2: map['age9G2'],
      age10: map['age10'],
      age10G1: map['age10G1'],
      age10G2: map['age10G2'],
      age11: map['age11'],
      age11G1: map['age11G1'],
      age11G2: map['age11G2'],
      age12: map['age12'],
      age12G1: map['age12G1'],
      age12G2: map['age12G2'],
      age13: map['age13'],
      age13G1: map['age13G1'],
      age13G2: map['age13G2'],
      age14: map['age14'],
      age14G1: map['age14G1'],
      age14G2: map['age14G2'],
      age15: map['age15'],
      age15G1: map['age15G1'],
      age15G2: map['age15G2'],
      age16: map['age16'],
      age16G1: map['age16G1'],
      age16G2: map['age16G2'],
      age17: map['age17'],
      age17G1: map['age17G1'],
      age17G2: map['age17G2'],
      age18: map['age18'],
      age18G1: map['age18G1'],
      age18G2: map['age18G2'],
      age19: map['age19'],
      age19G1: map['age19G1'],
      age19G2: map['age19G2'],
      age20: map['age20'],
      age20G1: map['age20G1'],
      age20G2: map['age20G2'],
      age21: map['age21'],
      age21G1: map['age21G1'],
      age21G2: map['age21G2'],
      age22: map['age22'],
      age22G1: map['age22G1'],
      age22G2: map['age22G2'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SAreaAgeGender.fromJson(String source) => SAreaAgeGender.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SAreaAgeGender(id: $id, area: $area, age: $age, ageG1: $ageG1, ageG2: $ageG2, age1: $age1, age1G1: $age1G1, age1G2: $age1G2, age2: $age2, age2G1: $age2G1, age2G2: $age2G2, age3: $age3, age3G1: $age3G1, age3G2: $age3G2, age4: $age4, age4G1: $age4G1, age4G2: $age4G2, age5: $age5, age5G1: $age5G1, age5G2: $age5G2, age6: $age6, age6G1: $age6G1, age6G2: $age6G2, age7: $age7, age7G1: $age7G1, age7G2: $age7G2, age8: $age8, age8G1: $age8G1, age8G2: $age8G2, age9: $age9, age9G1: $age9G1, age9G2: $age9G2, age10: $age10, age10G1: $age10G1, age10G2: $age10G2, age11: $age11, age11G1: $age11G1, age11G2: $age11G2, age12: $age12, age12G1: $age12G1, age12G2: $age12G2, age13: $age13, age13G1: $age13G1, age13G2: $age13G2, age14: $age14, age14G1: $age14G1, age14G2: $age14G2, age15: $age15, age15G1: $age15G1, age15G2: $age15G2, age16: $age16, age16G1: $age16G1, age16G2: $age16G2, age17: $age17, age17G1: $age17G1, age17G2: $age17G2, age18: $age18, age18G1: $age18G1, age18G2: $age18G2, age19: $age19, age19G1: $age19G1, age19G2: $age19G2, age20: $age20, age20G1: $age20G1, age20G2: $age20G2, age21: $age21, age21G1: $age21G1, age21G2: $age21G2, age22: $age22, age22G1: $age22G1, age22G2: $age22G2)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is SAreaAgeGender &&
        o.id == id &&
        o.area == area &&
        o.age == age &&
        o.ageG1 == ageG1 &&
        o.ageG2 == ageG2 &&
        o.age1 == age1 &&
        o.age1G1 == age1G1 &&
        o.age1G2 == age1G2 &&
        o.age2 == age2 &&
        o.age2G1 == age2G1 &&
        o.age2G2 == age2G2 &&
        o.age3 == age3 &&
        o.age3G1 == age3G1 &&
        o.age3G2 == age3G2 &&
        o.age4 == age4 &&
        o.age4G1 == age4G1 &&
        o.age4G2 == age4G2 &&
        o.age5 == age5 &&
        o.age5G1 == age5G1 &&
        o.age5G2 == age5G2 &&
        o.age6 == age6 &&
        o.age6G1 == age6G1 &&
        o.age6G2 == age6G2 &&
        o.age7 == age7 &&
        o.age7G1 == age7G1 &&
        o.age7G2 == age7G2 &&
        o.age8 == age8 &&
        o.age8G1 == age8G1 &&
        o.age8G2 == age8G2 &&
        o.age9 == age9 &&
        o.age9G1 == age9G1 &&
        o.age9G2 == age9G2 &&
        o.age10 == age10 &&
        o.age10G1 == age10G1 &&
        o.age10G2 == age10G2 &&
        o.age11 == age11 &&
        o.age11G1 == age11G1 &&
        o.age11G2 == age11G2 &&
        o.age12 == age12 &&
        o.age12G1 == age12G1 &&
        o.age12G2 == age12G2 &&
        o.age13 == age13 &&
        o.age13G1 == age13G1 &&
        o.age13G2 == age13G2 &&
        o.age14 == age14 &&
        o.age14G1 == age14G1 &&
        o.age14G2 == age14G2 &&
        o.age15 == age15 &&
        o.age15G1 == age15G1 &&
        o.age15G2 == age15G2 &&
        o.age16 == age16 &&
        o.age16G1 == age16G1 &&
        o.age16G2 == age16G2 &&
        o.age17 == age17 &&
        o.age17G1 == age17G1 &&
        o.age17G2 == age17G2 &&
        o.age18 == age18 &&
        o.age18G1 == age18G1 &&
        o.age18G2 == age18G2 &&
        o.age19 == age19 &&
        o.age19G1 == age19G1 &&
        o.age19G2 == age19G2 &&
        o.age20 == age20 &&
        o.age20G1 == age20G1 &&
        o.age20G2 == age20G2 &&
        o.age21 == age21 &&
        o.age21G1 == age21G1 &&
        o.age21G2 == age21G2 &&
        o.age22 == age22 &&
        o.age22G1 == age22G1 &&
        o.age22G2 == age22G2;
  }

  @override
  int get hashCode {
    return id.hashCode ^
    area.hashCode ^
    age.hashCode ^
    ageG1.hashCode ^
    ageG2.hashCode ^
    age1.hashCode ^
    age1G1.hashCode ^
    age1G2.hashCode ^
    age2.hashCode ^
    age2G1.hashCode ^
    age2G2.hashCode ^
    age3.hashCode ^
    age3G1.hashCode ^
    age3G2.hashCode ^
    age4.hashCode ^
    age4G1.hashCode ^
    age4G2.hashCode ^
    age5.hashCode ^
    age5G1.hashCode ^
    age5G2.hashCode ^
    age6.hashCode ^
    age6G1.hashCode ^
    age6G2.hashCode ^
    age7.hashCode ^
    age7G1.hashCode ^
    age7G2.hashCode ^
    age8.hashCode ^
    age8G1.hashCode ^
    age8G2.hashCode ^
    age9.hashCode ^
    age9G1.hashCode ^
    age9G2.hashCode ^
    age10.hashCode ^
    age10G1.hashCode ^
    age10G2.hashCode ^
    age11.hashCode ^
    age11G1.hashCode ^
    age11G2.hashCode ^
    age12.hashCode ^
    age12G1.hashCode ^
    age12G2.hashCode ^
    age13.hashCode ^
    age13G1.hashCode ^
    age13G2.hashCode ^
    age14.hashCode ^
    age14G1.hashCode ^
    age14G2.hashCode ^
    age15.hashCode ^
    age15G1.hashCode ^
    age15G2.hashCode ^
    age16.hashCode ^
    age16G1.hashCode ^
    age16G2.hashCode ^
    age17.hashCode ^
    age17G1.hashCode ^
    age17G2.hashCode ^
    age18.hashCode ^
    age18G1.hashCode ^
    age18G2.hashCode ^
    age19.hashCode ^
    age19G1.hashCode ^
    age19G2.hashCode ^
    age20.hashCode ^
    age20G1.hashCode ^
    age20G2.hashCode ^
    age21.hashCode ^
    age21G1.hashCode ^
    age21G2.hashCode ^
    age22.hashCode ^
    age22G1.hashCode ^
    age22G2.hashCode;
  }
}
