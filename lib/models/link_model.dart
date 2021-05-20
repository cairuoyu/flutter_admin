import 'dart:convert';

class LinkModel {
  String? title;
  String? titleEn;
  String? trailing;

  LinkModel({
    this.title,
    this.titleEn,
    this.trailing,
  });

  LinkModel copyWith({
    String? title,
    String? titleEn,
    String? trailing,
  }) {
    return LinkModel(
      title: title ?? this.title,
      titleEn: titleEn ?? this.titleEn,
      trailing: trailing ?? this.trailing,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'titleEn': titleEn,
      'trailing': trailing,
    };
  }

  factory LinkModel.fromMap(Map<String, dynamic> map) {

    return LinkModel(
      title: map['title'],
      titleEn: map['titleEn'],
      trailing: map['trailing'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LinkModel.fromJson(String source) => LinkModel.fromMap(json.decode(source));

  @override
  String toString() => 'LinkModel(title: $title, titleEn: $titleEn, trailing: $trailing)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is LinkModel && o.title == title && o.titleEn == titleEn && o.trailing == trailing;
  }

  @override
  int get hashCode => title.hashCode ^ titleEn.hashCode ^ trailing.hashCode;
}
