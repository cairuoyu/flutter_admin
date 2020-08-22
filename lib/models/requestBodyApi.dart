import 'package:flutter_admin/models/page.dart';
import 'package:json_annotation/json_annotation.dart';
part 'requestBodyApi.g.dart';

@JsonSerializable()
class RequestBodyApi {
    RequestBodyApi();

    PageModel page;
    Map params;
    
    factory RequestBodyApi.fromJson(Map<String,dynamic> json) => _$RequestBodyApiFromJson(json);
    Map<String, dynamic> toJson() => _$RequestBodyApiToJson(this);
}
