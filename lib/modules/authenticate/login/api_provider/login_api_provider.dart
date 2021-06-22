import 'dart:convert';

import 'package:bloc_example/modules/authenticate/login/model/login_model.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class LoginApiProvider {
  static Future<LoginModel> login(String userName, String pass) async {
    Response response;
    response = await http.get(
        Uri.parse(
            "https://6059a289b11aba001745c7ce.mockapi.io/nen/user?username=$userName&pass=$pass"),
        headers: {
          'authorization':
              'Basic ' + base64Encode(utf8.encode('appueh:@appueh@'))
        });

    if (response.statusCode == 200) {
      for (int i = 0; i < json.decode(response.body).length; i++) {
        if (LoginModel(json.decode(response.body)[i]).pass == pass) {
          return LoginModel(json.decode(response.body)[i]);
        }
      }
      return null;
    } else {
      print(" Sign in error, code ==> " + response.statusCode.toString());
      return null;
    }
  }

  static Future<LoginModel> signUp(String userName, String pass) async {
    Response response;
    response = await http.post(
        Uri.parse(
            "https://6059a289b11aba001745c7ce.mockapi.io/nen/user?username=$userName&pass=$pass"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'username': userName,
          'pass': pass,
        }));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return LoginModel(json.decode(response.body));
    } else {
      print(" Sign up error, code ==> " + response.statusCode.toString());
      return null;
    }
  }
}
