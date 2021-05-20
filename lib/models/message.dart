import 'dart:convert';

class Message {
  String? id;
  String? title;

  String? content;

  String? state;

  num? commentCount;

  num? appreciateCount;

  String? createrId;

  String? createTime;

  String? updateTime;
  Message({
    this.id,
    this.title,
    this.content,
    this.state,
    this.commentCount,
    this.appreciateCount,
    this.createrId,
    this.createTime,
    this.updateTime,
  });

  Message copyWith({
    String? id,
    String? title,
    String? content,
    String? state,
    num? commentCount,
    num? appreciateCount,
    String? createrId,
    String? createTime,
    String? updateTime,
  }) {
    return Message(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      state: state ?? this.state,
      commentCount: commentCount ?? this.commentCount,
      appreciateCount: appreciateCount ?? this.appreciateCount,
      createrId: createrId ?? this.createrId,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'state': state,
      'commentCount': commentCount,
      'appreciateCount': appreciateCount,
      'createrId': createrId,
      'createTime': createTime,
      'updateTime': updateTime,
    };
  }

  factory Message.fromMap(Map<String?, dynamic> map) {

    return Message(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      state: map['state'],
      commentCount: map['commentCount'],
      appreciateCount: map['appreciateCount'],
      createrId: map['createrId'],
      createTime: map['createTime'],
      updateTime: map['updateTime'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) => Message.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Message(id: $id, title: $title, content: $content, state: $state, commentCount: $commentCount, appreciateCount: $appreciateCount, createrId: $createrId, createTime: $createTime, updateTime: $updateTime)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Message &&
      o.id == id &&
      o.title == title &&
      o.content == content &&
      o.state == state &&
      o.commentCount == commentCount &&
      o.appreciateCount == appreciateCount &&
      o.createrId == createrId &&
      o.createTime == createTime &&
      o.updateTime == updateTime;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      content.hashCode ^
      state.hashCode ^
      commentCount.hashCode ^
      appreciateCount.hashCode ^
      createrId.hashCode ^
      createTime.hashCode ^
      updateTime.hashCode;
  }
}
