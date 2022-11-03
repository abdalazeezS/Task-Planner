import 'package:flutter/material.dart';

import '../constants.dart';

class TaskPriority {
  TaskPriorityType taskPriority;
  String title;
  Color color;

  TaskPriority({
    required this.taskPriority,
    required this.title,
    required this.color,
  });
}
