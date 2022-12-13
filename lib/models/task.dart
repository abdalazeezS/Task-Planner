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
  List<SubTask>? subTasks = [];

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
      description:
          map['description'] == null ? '' : map['description'] as String,
      subTasks:
          map['subTasks'] == null ? [] : getSubTasksFromString(map['subTasks']),
    );
  }

  static List<SubTask> getSubTasksFromString(String subTasksString) {
    final splitNames = subTasksString.split(',');
    List<SubTask> splitList = [];
    for (int i = 0; i < splitNames.length; i++) {
      splitList.add(SubTask(title: splitNames[i], isFinished: false));
    }
    return splitList;
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

  getSubTasksTitles(List<SubTask> list) {
    if (list.isNotEmpty) {
      List titles = [];
      for (int i = 1; i < list.length; i++) {
        titles.add(list[i].title);
      }
      return titles.join(',');
    }
    return '';
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
      "subTasks": subTasks == null ? [] : getSubTasksTitles(subTasks!),
    };
  }

  subTasksToString() {
    String str = '';
    for (int i = 0; i < subTasks!.length; i++) {
      str += subTasks![i].title!;
    }
    return str;
  }
}
