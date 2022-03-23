class User {

  String? userName;
  String? password;
  String? face;

//<editor-fold desc="Data Methods">

  User({
    this.userName,
    this.password,
    this.face,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is User && runtimeType == other.runtimeType && userName == other.userName && password == other.password && face == other.face);

  @override
  int get hashCode => userName.hashCode ^ password.hashCode ^ face.hashCode;

  @override
  String toString() {
    return 'User{' + ' userName: $userName,' + ' password: $password,' + ' face: $face,' + '}';
  }

  User copyWith({
    String? userName,
    String? password,
    String? face,
  }) {
    return User(
      userName: userName ?? this.userName,
      password: password ?? this.password,
      face: face ?? this.face,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userName': this.userName,
      'password': this.password,
      'face': this.face,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userName: map['userName'] as String,
      password: map['password'] as String,
      face: map['face'] as String,
    );
  }

//</editor-fold>
}
