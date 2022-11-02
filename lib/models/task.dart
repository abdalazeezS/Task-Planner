import 'package:Task_Planner/models/category.dart';

import '../constants.dart';

class Task {
  String title;
  DateTime date;
  bool isFinished;
  TaskPriority taskPriority;
  Category category;
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
