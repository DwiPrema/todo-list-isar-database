import 'package:isar/isar.dart';
import 'package:todo_list_isar_database/model/enum_status.dart';

part 'todo.g.dart';

@Collection()
class Todo {
  Id id = Isar.autoIncrement;

  @Index(type: IndexType.value)
  late String title;

  String? description;

  @Index()
  @enumerated
  Status status = Status.pending;

  DateTime createdAt = DateTime.now();
  DateTime? updatedAt;

  Todo copyWith({
    String? title,
    String? description,
    Status? status,
    DateTime? updatedAt,
  }) {
    return Todo()
      ..id = id
      ..status = status ?? this.status
      ..createdAt = createdAt
      ..updatedAt = updatedAt ?? this.updatedAt
      ..title = title ?? this.title
      ..description = description ?? this.description;
  }
}
