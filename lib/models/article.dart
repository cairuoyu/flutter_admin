
class Article {
  String? id;
  String? title;
  String? titleSub;
  String? author;
  String? status;
  String? publishTime;
  String? publishTimeStart;
  String? publishTimeEnd;
  String? fileUrl;
  int? orderBy;
  String? createTime;
  String? updateTime;
  String? createrId;
  String? updateId;

  Article({
    this.id,
    this.title,
    this.titleSub,
    this.author,
    this.status,
    this.publishTime,
    this.publishTimeStart,
    this.publishTimeEnd,
    this.fileUrl,
    this.orderBy,
    this.createTime,
    this.updateTime,
    this.createrId,
    this.updateId,
  });

  Article copyWith({
    String? id,
    String? title,
    String? titleSub,
    String? author,
    String? status,
    String? publishTime,
    String? publishTimeStart,
    String? publishTimeEnd,
    String? fileUrl,
    int? orderBy,
    String? createTime,
    String? updateTime,
    String? createrId,
    String? updateId,
  }) {
    return new Article(
      id: id ?? this.id,
      title: title ?? this.title,
      titleSub: titleSub ?? this.titleSub,
      author: author ?? this.author,
      status: status ?? this.status,
      publishTime: publishTime ?? this.publishTime,
      publishTimeStart: publishTimeStart ?? this.publishTimeStart,
      publishTimeEnd: publishTimeEnd ?? this.publishTimeEnd,
      fileUrl: fileUrl ?? this.fileUrl,
      orderBy: orderBy ?? this.orderBy,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
      createrId: createrId ?? this.createrId,
      updateId: updateId ?? this.updateId,
    );
  }

  @override
  String toString() {
    return 'Article{id: $id, title: $title, titleSub: $titleSub, author: $author, status: $status, publishTime: $publishTime, publishTimeStart: $publishTimeStart, publishTimeEnd: $publishTimeEnd, fileUrl: $fileUrl, orderBy: $orderBy, createTime: $createTime, updateTime: $updateTime, createrId: $createrId, updateId: $updateId}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Article &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          titleSub == other.titleSub &&
          author == other.author &&
          status == other.status &&
          publishTime == other.publishTime &&
          publishTimeStart == other.publishTimeStart &&
          publishTimeEnd == other.publishTimeEnd &&
          fileUrl == other.fileUrl &&
          orderBy == other.orderBy &&
          createTime == other.createTime &&
          updateTime == other.updateTime &&
          createrId == other.createrId &&
          updateId == other.updateId);

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      titleSub.hashCode ^
      author.hashCode ^
      status.hashCode ^
      publishTime.hashCode ^
      publishTimeStart.hashCode ^
      publishTimeEnd.hashCode ^
      fileUrl.hashCode ^
      orderBy.hashCode ^
      createTime.hashCode ^
      updateTime.hashCode ^
      createrId.hashCode ^
      updateId.hashCode;

  factory Article.fromMap(Map<String?, dynamic> map) {
    return new Article(
      id: map['id'] as String?,
      title: map['title'] as String?,
      titleSub: map['titleSub'] as String?,
      author: map['author'] as String?,
      status: map['status'] as String?,
      publishTime: map['publishTime'] as String?,
      publishTimeStart: map['publishTimeStart'] as String?,
      publishTimeEnd: map['publishTimeEnd'] as String?,
      fileUrl: map['fileUrl'] as String?,
      orderBy: map['orderBy'] as int?,
      createTime: map['createTime'] as String?,
      updateTime: map['updateTime'] as String?,
      createrId: map['createrId'] as String?,
      updateId: map['updateId'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'id': this.id,
      'title': this.title,
      'titleSub': this.titleSub,
      'author': this.author,
      'status': this.status,
      'publishTime': this.publishTime,
      'publishTimeStart': this.publishTimeStart,
      'publishTimeEnd': this.publishTimeEnd,
      'fileUrl': this.fileUrl,
      'orderBy': this.orderBy,
      'createTime': this.createTime,
      'updateTime': this.updateTime,
      'createrId': this.createrId,
      'updateId': this.updateId,
    } as Map<String, dynamic>;
  }

//</editor-fold>

}
