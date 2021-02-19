import 'dart:isolate';

class Task {
  final String task;
  final String priority;
  DateTime deadline;
  String category;
  bool isDone;
  Task({this.task, this.priority, this.deadline, this.category, this.isDone});
}
