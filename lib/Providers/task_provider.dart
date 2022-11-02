import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/category.dart';
import '../models/task.dart';

class TaskProvider with ChangeNotifier {
  String taskPriorityText = '';
  Color taskPriorityColor = Colors.black38;
  TaskPriority taskPriority = TaskPriority.none;

  setTaskPriority(TaskPriority priority) {
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

  Category taskCategory = Categories.inbox;

  resetTaskCategory() {
    taskCategory = Categories.inbox;
    notifyListeners();
  }

  setTaskCategory(Category category) {
    taskCategory = category;
    notifyListeners();
  }

  Category currentCategory = Categories.inbox;

  setCurrentCategory(Category category) {
    currentCategory = category;
    notifyListeners();
  }
}
