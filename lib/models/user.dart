class User {

  String? userName;
  String? password;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  User({
    this.userName,
    this.password,
  });

  User copyWith({
    String? userName,
    String? password,
  }) {
    return new User(
      userName: userName ?? this.userName,
      password: password ?? this.password,
    );
  }

  @override
  String toString() {
    return 'User{userName: $userName, password: $password}';
  }

  @override
  bool operator ==(Object other) => identical(this, other) || (other is User && runtimeType == other.runtimeType && userName == other.userName && password == other.password);

  @override
  int get hashCode => userName.hashCode ^ password.hashCode;

  factory User.fromMap(Map<String, dynamic> map) {
    return new User(
      userName: map['userName'] as String?,
      password: map['password'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'userName': this.userName,
      'password': this.password,
    } as Map<String, dynamic>;
  }

//</editor-fold>

}
