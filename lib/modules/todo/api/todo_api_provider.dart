import 'dart:convert';
import 'package:bloc_example/modules/todo/model/todo_model.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class TodoApiProvider {
  static Future<List<Todo>> loadTodo(String userId) async {
    List<Todo> list = [];
    Response response;
    response = await http.get(
      Uri.parse(
          "https://6059a289b11aba001745c7ce.mockapi.io/nen/user/$userId/todo"),
    );

    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      for (int i = 0; i < body.length; i++) {
        var todo = Todo(body[i]);
        list.add(todo);
      }
      return list;
    } else {
      print(" Sign in error, code ==> " + response.statusCode.toString());
      return null;
    }
  }

  static Future<bool> addTodo(String title, String note, String userId) async {
    Response response;
    response = await http.post(
        Uri.parse(
            "https://6059a289b11aba001745c7ce.mockapi.io/nen/user/$userId/todo"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'title': title,
          'note': note,
        }));

    if (response.statusCode == 201) {
      return true;
    } else {
      print(" Add todo error, code ==> " + response.statusCode.toString());
      return false;
    }
  }

  static Future<List<Todo>> checkTodo(String id, String userId) async {
    Response response;
    response = await http.delete(
      Uri.parse(
          "https://6059a289b11aba001745c7ce.mockapi.io/nen/user/$userId/todo/$id"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      var todo = await loadTodo(userId);
      return todo;
    } else {
      print(" Check todo error, code ==> " + response.statusCode.toString());
      return null;
    }
  }
}
