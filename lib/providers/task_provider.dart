import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/task_category.dart';
import '../models/task.dart';

class TaskProvider with ChangeNotifier {
  String taskPriorityText = '';
  Color taskPriorityColor = Colors.black38;
  TaskPriorityType taskPriority = TaskPriorityType.none;

  setTaskPriority(TaskPriorityType priority) {
    if (priority.name == 'none') {
      taskPriorityText = '';
      taskPriorityColor = Colors.black38;
    } else {
      taskPriorityText = priority.name + ' ';
      taskPriorityColor = priorityColorMap[taskPriorityText.trim()]!;
    }
    taskPriority = priority;
    notifyListeners();
  }

  resetPriority() {
    taskPriorityText = '';
    taskPriorityColor = Colors.black38;
    notifyListeners();
  }

  setTaskDescription(Task task, String? description) {
    task.description = description;
    notifyListeners();
  }

  getTaskDescription(Task task) {
    return task.description;
  }

  TaskCategory taskCategory = Categories.inbox;

  resetTaskCategory() {
    taskCategory = Categories.inbox;
    notifyListeners();
  }

  setTaskCategory(TaskCategory category) {
    taskCategory = category;
    notifyListeners();
  }

  TaskCategory currentCategory = Categories.inbox;

  setCurrentCategory(TaskCategory category) {
    currentCategory = category;
    notifyListeners();
  }
}
