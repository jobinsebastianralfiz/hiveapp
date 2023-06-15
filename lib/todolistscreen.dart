import 'package:flutter/material.dart';
import 'package:todoapp/models/todomodelclass.dart';
import 'package:todoapp/services/todorepository.dart';


class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final TodoRepository _todoRepository = TodoRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('Todo List'),
      ),
      body: FutureBuilder<List<Todo>>(
        future: _todoRepository.getTodos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final todos = snapshot.data;

          if (todos == null || todos.isEmpty) {
            return Center(
              child: Text('No todos yet.'),
            );
          }

          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];

              return ListTile(
                title: Text(todo.title),
                trailing: Checkbox(
                  value: todo.isCompleted,
                  onChanged: (value) {
                    setState(() {
                      todo.isCompleted = value!;
                      _todoRepository.updateTodo(todo);
                    });
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addTodoDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _addTodoDialog(BuildContext context) async {
    final TextEditingController _textEditingController =
    TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Todo'),
          content: TextField(
            controller: _textEditingController,
            decoration: InputDecoration(
              hintText: 'Enter a todo',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final todo = Todo(
                  title: _textEditingController.text,
                  isCompleted: false,
                );

                setState(() {
                  _todoRepository.addTodo(todo);
                });

                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
