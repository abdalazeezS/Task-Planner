import '../constants.dart';

class Task {
  String title;
  DateTime date;
  bool isFinished;
  TaskPriority taskPriority;

  Task({
    required this.title,
    required this.date,
    required this.isFinished,
    required this.taskPriority,
  });
}
