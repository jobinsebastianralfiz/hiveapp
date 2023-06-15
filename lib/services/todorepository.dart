import 'package:hive/hive.dart';

import '../models/todomodelclass.dart';



class TodoRepository {
  final String _boxName = 'todos';

  Future<Box<Todo>> _openBox() async {
    return Hive.openBox<Todo>(_boxName);
  }

  Future<void> addTodo(Todo todo) async {
    final box = await _openBox();
    await box.add(todo);
  }

  Future<List<Todo>> getTodos() async {
    final box = await _openBox();
    return box.values.toList();
  }

  Future<void> updateTodo(Todo todo) async {
    final box = await _openBox();
    await box.put(todo.key, todo);
  }

  Future<void> deleteTodo(Todo todo) async {
    final box = await _openBox();
    await box.delete(todo.key);
  }
}
