import 'package:json_annotation/json_annotation.dart';
part 'responeBodyApi.g.dart';

@JsonSerializable()
class ResponeBodyApi<T> {
    ResponeBodyApi();

    bool success;
    String code;
    String message;
    T data;
    
    factory ResponeBodyApi.fromJson(Map<String,dynamic> json) => _$ResponeBodyApiFromJson(json);
    Map<String, dynamic> toJson() => _$ResponeBodyApiToJson(this);
}
