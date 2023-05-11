import 'dart:convert';
import 'dart:core';

import 'package:http/http.dart' as http;
import 'package:rnd_flutter_app/model/todos_model.dart';

class TodoUtils {
  Future<List<TodoModel>> getTodos() async {
    try {
      var response = await http.get(
          Uri.parse('https://e-commerce-service-node.onrender.com/todo/all'));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        List<dynamic> rawTodos = data['todos'];
        List<TodoModel> todosData =
            List.from(rawTodos.map((e) => TodoModel.fromJson(e)));
        return todosData;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('Error');
    }
  }

  Future<TodoModel> createTodo(
      username, todoText, dateData, isPublic, isCompleted) async {
    final response = await http.post(
        Uri.parse("https://e-commerce-service-node.onrender.com/todo/add"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "todo": todoText,
          "author": username,
          "dueDate": dateData,
          "isPublic": isPublic,
          "isCompleted": isCompleted
        }));
    if (response.statusCode == 200) {
      final Map<String, dynamic> todoMap = json.decode(response.body);
      final todo = TodoModel.fromJson(todoMap['todo']);
      return todo;
    } else {
      throw Exception('Failed to create todo');
    }
  }
}
