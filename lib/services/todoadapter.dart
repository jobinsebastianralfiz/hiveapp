import 'package:hive/hive.dart';

import '../models/todomodelclass.dart';

class TodoAdapter extends TypeAdapter<Todo> {
  @override
  final int typeId = 0;

  @override
  Todo read(BinaryReader reader) {
    final titleLength = reader.readInt32();
    final title = reader.readString(titleLength);
    final isCompleted = reader.readBool();
    return Todo(
      title: title,
      isCompleted: isCompleted,
    );
  }

  @override
  void write(BinaryWriter writer, Todo obj) {
    writer.writeInt32(obj.title.length);
    writer.writeString(obj.title);
    writer.writeBool(obj.isCompleted);
  }
}
