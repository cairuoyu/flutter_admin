import 'dart:convert';

class RoleMenu {
  final String? menuId;
  final String? roleId;
  RoleMenu({
    this.menuId,
    this.roleId,
  });

  RoleMenu copyWith({
    String? menuId,
    String? roleId,
  }) {
    return RoleMenu(
      menuId: menuId ?? this.menuId,
      roleId: roleId ?? this.roleId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'menuId': menuId,
      'roleId': roleId,
    };
  }

  factory RoleMenu.fromMap(Map<String, dynamic> map) {
    return RoleMenu(
      menuId: map['menuId'],
      roleId: map['roleId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RoleMenu.fromJson(String source) => RoleMenu.fromMap(json.decode(source));

  @override
  String toString() => 'RoleMenu(menuId: $menuId, roleId: $roleId)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is RoleMenu &&
      o.menuId == menuId &&
      o.roleId == roleId;
  }

  @override
  int get hashCode => menuId.hashCode ^ roleId.hashCode;
}