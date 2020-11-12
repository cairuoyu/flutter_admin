import 'dart:convert';

import 'package:cry/model/page_model.dart';
import 'package:flutter/foundation.dart';

class RequestBodyApi {
  PageModel page;
  Map params;

  RequestBodyApi({
    this.page,
    this.params,
  });

  RequestBodyApi copyWith({
    PageModel page,
    Map params,
  }) {
    return RequestBodyApi(
      page: page ?? this.page,
      params: params ?? this.params,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'page': page?.toMap(),
      'params': params,
    };
  }

  factory RequestBodyApi.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return RequestBodyApi(
      page: PageModel.fromMap(map['page']),
      params: Map.from(map['params']),
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestBodyApi.fromJson(String source) => RequestBodyApi.fromMap(json.decode(source));

  @override
  String toString() => 'RequestBodyApi(page: $page, params: $params)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is RequestBodyApi && o.page == page && mapEquals(o.params, params);
  }

  @override
  int get hashCode => page.hashCode ^ params.hashCode;
}
