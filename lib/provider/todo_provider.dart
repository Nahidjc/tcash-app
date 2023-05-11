import 'package:flutter/material.dart';
import 'package:rnd_flutter_app/api_caller/todo_utils.dart';
import 'package:rnd_flutter_app/model/todos_model.dart';

class TodoProvider extends ChangeNotifier {
  late List<TodoModel> _openTodos = [];
  List<TodoModel> get openTodos => _openTodos;
  bool isLoading = false;
  TodoUtils todoUtils = TodoUtils();
  void getTodo() async {
    try {
      isLoading = true;
      _openTodos = await todoUtils.getTodos();
      isLoading = false;
    } catch (e) {
      isLoading = false;
    }
    notifyListeners();
  }

  Future<void> createTodo(
      username, todoText, dateData, isPublic, isCompleted) async {
    try {
      isLoading = true;

      await todoUtils.createTodo(
          username, todoText, dateData, isPublic, isCompleted);
      getTodo();
      isLoading = false;
    } catch (e) {
      isLoading = false;
    }
    notifyListeners();
  }

  // void removeTodoList(TodoModel todo) {
  //   final index = _todoList.indexOf(todo);
  //   _todoList.removeAt(index);
  //   notifyListeners();
  // }
}
