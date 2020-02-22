import 'package:json_annotation/json_annotation.dart';
import "page.dart";
part 'requestBodyApi.g.dart';

@JsonSerializable()
class RequestBodyApi {
    RequestBodyApi();

    Page page;
    Map params;
    
    factory RequestBodyApi.fromJson(Map<String,dynamic> json) => _$RequestBodyApiFromJson(json);
    Map<String, dynamic> toJson() => _$RequestBodyApiToJson(this);
}
