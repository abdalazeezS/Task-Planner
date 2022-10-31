import 'package:Task_Planner/constants.dart';
import 'package:flutter/material.dart';

class TaskPriorityProvider with ChangeNotifier {
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
}
