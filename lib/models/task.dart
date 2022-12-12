import 'package:Task_Planner/models/sub_task.dart';
import 'package:Task_Planner/models/task_category.dart';

import '../constants.dart';
import 'categories.dart';

class Task {
  int? id;
  String title;
  DateTime date;
  bool isFinished;
  TaskPriorityType taskPriority;
  TaskCategory category;
  String? description = '';
  List<SubTask>? subTasks;

  Task({
    this.id,
    required this.title,
    required this.date,
    required this.isFinished,
    required this.taskPriority,
    required this.category,
    this.description,
    this.subTasks,
  });

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      date: DateTime.parse(map['date']),
      isFinished: map['isFinished'] == 1 ? true : false,
      taskPriority: getTaskPriority(map['priority']),
      category: getCategory(map['category']),
      description: map['description'],
    );
  }

  static TaskPriorityType getTaskPriority(String str) {
    if (str == 'high') {
      return TaskPriorityType.high;
    } else if (str == 'medium') {
      return TaskPriorityType.medium;
    } else if (str == 'low') {
      return TaskPriorityType.high;
    }
    return TaskPriorityType.none;
  }

  static getCategory(String category) {
    return Categories.categoriesList
        .firstWhere((element) => element.name == category);
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "date": date.toString(),
      "isFinished": isFinished == true ? 1 : 0,
      "priority": taskPriority.name,
      "category": category.name,
      "description": description,
      // "subTasks": subTasks?.join(", ")
    };
  }
}
