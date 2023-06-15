import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoapp/models/todomodel.dart';

class ToDoService {
  //create todo
  List<Map<String, dynamic>> todos = [];

  crateTodo(ToDoModel todo) {
    print(todo);

    Map<String, dynamic> _todo = {
      "title": todo.title,
      "subtitle": todo.subtitle,
      "createdat": DateTime.now(),
      "status": 1,
      "id":todo.id

    };

    FirebaseFirestore.instance
        .collection('todos')
        .doc(todo.id)
        .set(
       _todo);


  }

  //get all todos

 List<Map<String,dynamic>> getAllTodos(){

    return todos;
 }


  //delete to

 void deleteTodo(int index){

   // FirebaseFirestore.instance.collection('todos').doc()
}

  //update todo
}
