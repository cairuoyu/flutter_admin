import 'dart:convert';

class RoleUser {
  final String? userId;
  final String? roleId;
  RoleUser({
    this.userId,
    this.roleId,
  });

  RoleUser copyWith({
    String? userId,
    String? roleId,
  }) {
    return RoleUser(
      userId: userId ?? this.userId,
      roleId: roleId ?? this.roleId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'roleId': roleId,
    };
  }

  factory RoleUser.fromMap(Map<String, dynamic> map) {
    return RoleUser(
      userId: map['userId'],
      roleId: map['roleId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RoleUser.fromJson(String source) => RoleUser.fromMap(json.decode(source));

  @override
  String toString() => 'RoleUser(userId: $userId, roleId: $roleId)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is RoleUser &&
      o.userId == userId &&
      o.roleId == roleId;
  }

  @override
  int get hashCode => userId.hashCode ^ roleId.hashCode;
}