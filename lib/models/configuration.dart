import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_admin/components/cryRoot.dart';

class Configuration {
  final String locale;
  final Color themeColor;

  const Configuration({
    this.locale,
    this.themeColor,
  });

  static Configuration of(BuildContext context) {
    return CryRootScope.of(context).state.configuration;
  }

  Configuration copyWith({
    String locale,
    Color themeColor,
  }) {
    return Configuration(
      locale: locale ?? this.locale,
      themeColor: themeColor ?? this.themeColor,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'locale': locale,
      'themeColor': themeColor?.value,
    };
  }

  factory Configuration.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Configuration(
      locale: map['locale'],
      themeColor: Color(map['themeColor']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Configuration.fromJson(String source) => Configuration.fromMap(json.decode(source));

  @override
  String toString() => 'Configuration(locale: $locale, themeColor: $themeColor)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Configuration && o.locale == locale && o.themeColor == themeColor;
  }

  @override
  int get hashCode => locale.hashCode ^ themeColor.hashCode;
}
