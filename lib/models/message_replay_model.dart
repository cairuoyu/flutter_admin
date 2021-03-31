class MessageReplayModel{
  String id;
  String messageId;
  String content;
  String createTime;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  MessageReplayModel({
    this.id,
    this.messageId,
    this.content,
    this.createTime,
  });

  MessageReplayModel copyWith({
    String id,
    String messageId,
    String content,
    String createTime,
  }) {
    return new MessageReplayModel(
      id: id ?? this.id,
      messageId: messageId ?? this.messageId,
      content: content ?? this.content,
      createTime: createTime ?? this.createTime,
    );
  }

  @override
  String toString() {
    return 'MessageReplayModel{id: $id, messageId: $messageId, content: $content, createTime: $createTime}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MessageReplayModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          messageId == other.messageId &&
          content == other.content &&
          createTime == other.createTime);

  @override
  int get hashCode => id.hashCode ^ messageId.hashCode ^ content.hashCode ^ createTime.hashCode;

  factory MessageReplayModel.fromMap(Map<String, dynamic> map) {
    return new MessageReplayModel(
      id: map['id'] as String,
      messageId: map['messageId'] as String,
      content: map['content'] as String,
      createTime: map['createTime'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'id': this.id,
      'messageId': this.messageId,
      'content': this.content,
      'createTime': this.createTime,
    } as Map<String, dynamic>;
  }

//</editor-fold>

}