import 'package:flutter/material.dart';

class TaskPriorityProvider with ChangeNotifier {
  Map<String, Color> priorityColorMap = {
    'high': Colors.red,
    'medium': Colors.yellow,
    'low': Colors.blue,
    'none': Colors.black38,
  };

  String taskPriority = '';
  Color taskPriorityColor = Colors.black38;

  setTaskPriority(String priority) {
    if (priority == 'none') {
      taskPriority = '';
      taskPriorityColor = Colors.black38;
    } else {
      taskPriority = priority + ' ';
      taskPriorityColor = priorityColorMap[taskPriority.trim()]!;
    }
    notifyListeners();
  }
}
