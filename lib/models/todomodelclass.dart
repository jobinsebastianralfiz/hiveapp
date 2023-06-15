import 'package:hive/hive.dart';

class Todo extends HiveObject {
  String title;
  bool isCompleted;

  Todo({
    required this.title,
    required this.isCompleted,
  });
}
