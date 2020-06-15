import 'package:json_annotation/json_annotation.dart';

part 'video.g.dart';

@JsonSerializable()
class Video {
    Video();

    String title;
    String url;
    String categoryId;
    String thumbs;
    String memo;
    String createTime;
    
    factory Video.fromJson(Map<String,dynamic> json) => _$VideoFromJson(json);
    Map<String, dynamic> toJson() => _$VideoToJson(this);
}
