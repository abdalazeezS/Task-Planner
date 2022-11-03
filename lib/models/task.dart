import 'package:Task_Planner/models/task_category.dart';

import '../constants.dart';

class Task {
  String title;
  DateTime date;
  bool isFinished;
  TaskPriorityType taskPriority;
  TaskCategory category;
  String? description = '';

  Task({
    required this.title,
    required this.date,
    required this.isFinished,
    required this.taskPriority,
    required this.category,
    this.description,
  });
}
