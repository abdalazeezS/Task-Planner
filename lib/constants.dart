import 'package:Task_Planner/models/task_priority.dart';
import 'package:flutter/material.dart';

import 'models/task_category.dart';

const Color backgroundColor = Color(0xFFF2F5FE);
const EdgeInsets space16 = EdgeInsets.all(16.0);
const EdgeInsets space8 = EdgeInsets.all(8.0);
const SizedBox sizedBox16Height = SizedBox(height: 16);

enum TaskPriorityType { high, medium, low, none }

Map<String, Color> priorityColorMap = {
  'high': Colors.red,
  'medium': Colors.yellow,
  'low': Colors.blue,
  'none': Colors.black38
};

List<TaskPriority> _tasksPriorities = [
  TaskPriority(
    taskPriority: TaskPriorityType.high,
    color: Colors.red,
  ),
  TaskPriority(
    taskPriority: TaskPriorityType.medium,
    color: Colors.yellow,
  ),
  TaskPriority(
    taskPriority: TaskPriorityType.low,
    color: Colors.blue,
  ),
  TaskPriority(
    taskPriority: TaskPriorityType.none,
    color: Colors.grey,
  ),
];

List<PopupMenuEntry<TaskPriorityType>> taskPriorityOptionList() {
  return _tasksPriorities.map((priority) {
    return PopupMenuItem(
      value: priority.taskPriority,
      child: ListTile(
        title: Text(priority.taskPriority.name),
        leading: Icon(
          Icons.flag,
          color: priority.color,
        ),
      ),
    );
  }).toList();
}
