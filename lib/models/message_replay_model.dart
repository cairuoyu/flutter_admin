class MessageReplayModel{
  String? id;
  String? messageId;
  String? content;
  String? createTime;
  String? avatarUrl;

//<editor-fold desc="Data Methods" defaultstate="collapsed">


  MessageReplayModel({
    this.id,
    this.messageId,
    this.content,
    this.createTime,
    this.avatarUrl,
  });

  MessageReplayModel copyWith({
    String? id,
    String? messageId,
    String? content,
    String? createTime,
    String? avatarUrl,
  }) {
    return new MessageReplayModel(
      id: id ?? this.id,
      messageId: messageId ?? this.messageId,
      content: content ?? this.content,
      createTime: createTime ?? this.createTime,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  @override
  String toString() {
    return 'MessageReplayModel{id: $id, messageId: $messageId, content: $content, createTime: $createTime, avatarUrl: $avatarUrl}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MessageReplayModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          messageId == other.messageId &&
          content == other.content &&
          createTime == other.createTime &&
          avatarUrl == other.avatarUrl);

  @override
  int get hashCode => id.hashCode ^ messageId.hashCode ^ content.hashCode ^ createTime.hashCode ^ avatarUrl.hashCode;

  factory MessageReplayModel.fromMap(Map<String?, dynamic> map) {
    return new MessageReplayModel(
      id: map['id'] as String?,
      messageId: map['messageId'] as String?,
      content: map['content'] as String?,
      createTime: map['createTime'] as String?,
      avatarUrl: map['avatarUrl'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'id': this.id,
      'messageId': this.messageId,
      'content': this.content,
      'createTime': this.createTime,
      'avatarUrl': this.avatarUrl,
    } as Map<String, dynamic>;
  }

//</editor-fold>

}