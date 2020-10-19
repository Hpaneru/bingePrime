class User {
  String id, name, email, token;

  static User fromMap(var data) {
    return User()
      ..id = data["id"]
      ..name = data["name"]
      ..email = data["email"]
      ..token = data["token"];
  }

  toMap() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "token": token,
    };
  }
}
