class User {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? token;

  User({
    this.id,
    this.password,
    this.token,
    this.firstName,
    this.lastName,
    this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        token: json.containsKey('token') ? json['token'] : null,
        email: json['email']);
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};

    if (id != null) map['id'] = id;
    if (token != null) map['token'] = token;
    if (firstName != null) map['first_name'] = firstName;
    if (lastName != null) map['last_name'] = lastName;
    if (email != null) map['email'] = email;

    return map;
  }

  @override
  String toString() {
    return "User : {$id, $email, $password, $token, $firstName, $lastName}";
  }
}
