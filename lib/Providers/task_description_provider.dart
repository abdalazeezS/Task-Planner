import 'package:flutter/material.dart';

import '../models/task.dart';

class TaskDescriptionProvider with ChangeNotifier {
  setTaskDescription(Task task, String? description) {
    task.description = description;
    notifyListeners();
  }

  getTaskDescription(Task task) {
    return task.description;
  }
}
