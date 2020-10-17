class User {
  String id, email, token;

  static User fromMap(var data) {
    return User()
      ..id = data["id"]
      ..email = data["email"]
      ..token = data["token"];
  }

  toMap() {
    return {
      "id": id,
      "email": email,
      "token": token,
    };
  }
}
