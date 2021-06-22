class LoginModel {
  String id;
  String username;
  String pass;

  LoginModel(Map<String, dynamic> json) {
    id = json["id"];
    username = json["username"];
    pass = json["pass"];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "pass": pass,
      };
}
