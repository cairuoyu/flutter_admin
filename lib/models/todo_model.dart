import 'dart:convert';

class TodoModel {
  String? title;
  String? titleEn;
  String? trailing;

  TodoModel({
    this.title,
    this.titleEn,
    this.trailing,
  });

  TodoModel copyWith({
    String? title,
    String? titleEn,
    String? trailing,
  }) {
    return TodoModel(
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

  factory TodoModel.fromMap(Map<String, dynamic> map) {

    return TodoModel(
      title: map['title'],
      titleEn: map['titleEn'],
      trailing: map['trailing'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoModel.fromJson(String source) => TodoModel.fromMap(json.decode(source));

  @override
  String toString() => 'TodoModel(title: $title, titleEn: $titleEn, trailing: $trailing)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is TodoModel && o.title == title && o.titleEn == titleEn && o.trailing == trailing;
  }

  @override
  int get hashCode => title.hashCode ^ titleEn.hashCode ^ trailing.hashCode;
}
