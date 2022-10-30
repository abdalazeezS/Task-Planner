import 'package:flutter/material.dart';

class TaskPriorityProvider with ChangeNotifier {
  String taskPriority = '';

  setTaskPriority(String priority) {
    if (priority == 'none') {
      taskPriority = '';
    } else
      taskPriority = priority + ' ';
    notifyListeners();
  }
}
