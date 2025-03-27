class Video {

    String? title;
    String? url;
    String? categoryId;
    String? thumbs;
    String? memo;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

    Video({
    this.title,
    this.url,
    this.categoryId,
    this.thumbs,
    this.memo,
  });

    Video copyWith({
    String? title,
    String? url,
    String? categoryId,
    String? thumbs,
    String? memo,
  }) {
    return new Video(
      title: title ?? this.title,
      url: url ?? this.url,
      categoryId: categoryId ?? this.categoryId,
      thumbs: thumbs ?? this.thumbs,
      memo: memo ?? this.memo,
    );
  }

    @override
  String toString() {
    return 'Video{title: $title, url: $url, categoryId: $categoryId, thumbs: $thumbs, memo: $memo}';
  }

    @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Video &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          url == other.url &&
          categoryId == other.categoryId &&
          thumbs == other.thumbs &&
          memo == other.memo );

    @override
  int get hashCode => title.hashCode ^ url.hashCode ^ categoryId.hashCode ^ thumbs.hashCode ^ memo.hashCode;

    factory Video.fromMap(Map<String, dynamic> map) {
    return new Video(
      title: map['title'] as String?,
      url: map['url'] as String?,
      categoryId: map['categoryId'] as String?,
      thumbs: map['thumbs'] as String?,
      memo: map['memo'] as String?,
    );
  }

    Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'title': this.title,
      'url': this.url,
      'categoryId': this.categoryId,
      'thumbs': this.thumbs,
      'memo': this.memo,
    };
  }

//</editor-fold>

}
