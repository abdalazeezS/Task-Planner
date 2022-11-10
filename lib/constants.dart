import 'package:Task_Planner/models/sub_task.dart';
import 'package:Task_Planner/models/task_priority.dart';
import 'package:flutter/material.dart';

import 'models/task_category.dart';
import 'models/task.dart';

const Color backgroundColor = Color(0xFFF2F5FE);
const EdgeInsets space16 = EdgeInsets.all(16.0);
const EdgeInsets space8 = EdgeInsets.all(8.0);
const SizedBox sizedBox16Height = SizedBox(height: 16);

class Categories {
  static TaskCategory today = TaskCategory(name: 'Today', icon: Icons.today);
  static TaskCategory inbox = TaskCategory(name: 'Inbox', icon: Icons.inbox);
  static TaskCategory welcome =
      TaskCategory(name: 'Welcome', icon: Icons.waving_hand_sharp);
  static TaskCategory work = TaskCategory(name: 'Work', icon: Icons.today);
  static TaskCategory personal =
      TaskCategory(name: 'Personal', icon: Icons.work);
  static TaskCategory shopping =
      TaskCategory(name: 'Shopping', icon: Icons.shopping_cart_rounded);
  static TaskCategory wishList =
      TaskCategory(name: 'Wish List', icon: Icons.hourglass_top);
  static TaskCategory birthday =
      TaskCategory(name: 'Birthday', icon: Icons.cake);

  static List<TaskCategory> categoriesList = [
    inbox,
    today,
    welcome,
    work,
    personal,
    shopping,
    wishList,
    birthday,
  ];
}

var finishedList = [
  Task(
    title: 'Study for SW Exam',
    date: DateTime.now(),
    isFinished: false,
    taskPriority: TaskPriorityType.none,
    category: Categories.inbox,
  ),
  Task(
    title: 'Clean up my room',
    date: DateTime.now(),
    isFinished: false,
    taskPriority: TaskPriorityType.none,
    category: Categories.personal,
  ),
  Task(
    title: 'Go to gym',
    date: DateTime.now(),
    isFinished: false,
    taskPriority: TaskPriorityType.none,
    category: Categories.inbox,
  ),
];

var tasksList = [
  Task(
      title: 'Wash the car',
      date: DateTime.now(),
      isFinished: false,
      taskPriority: TaskPriorityType.high,
      category: Categories.inbox,
      subTasks: [
        SubTask(title: 'title', isFinished: false),
        SubTask(title: 'title2', isFinished: false),
        SubTask(title: 'title', isFinished: false),
        SubTask(title: 'title2', isFinished: false),
      ]),
  Task(
    title: 'buy new clothes',
    date: DateTime.now(),
    isFinished: false,
    taskPriority: TaskPriorityType.low,
    category: Categories.personal,
  ),
  Task(
    title: 'Start coding flutter project',
    date: DateTime.now(),
    isFinished: false,
    taskPriority: TaskPriorityType.medium,
    category: Categories.work,
  ),
  Task(
    title: 'Prepare RTIT project',
    date: DateTime.now(),
    isFinished: false,
    taskPriority: TaskPriorityType.none,
    category: Categories.work,
  ),
  Task(
    title: 'buy a new perfume',
    date: DateTime.now(),
    isFinished: false,
    taskPriority: TaskPriorityType.none,
    category: Categories.shopping,
  )
];

enum TaskPriorityType { high, medium, low, none }

Map<String, Color> priorityColorMap = {
  'high': Colors.red,
  'medium': Colors.yellow,
  'low': Colors.blue,
  'none': Colors.black38
};

List<TaskPriority> tasksPriorities = [
  TaskPriority(
    taskPriority: TaskPriorityType.high,
    title: 'High Priority',
    color: Colors.red,
  ),
  TaskPriority(
    taskPriority: TaskPriorityType.medium,
    title: 'Medium Priority',
    color: Colors.yellow,
  ),
  TaskPriority(
    taskPriority: TaskPriorityType.low,
    title: 'Low Priority',
    color: Colors.blue,
  ),
  TaskPriority(
    taskPriority: TaskPriorityType.none,
    title: 'No Priority',
    color: Colors.grey,
  ),
];

List<PopupMenuEntry<TaskPriorityType>> taskPriorityOptionList() {
  return tasksPriorities.map((priority) {
    return PopupMenuItem(
      value: priority.taskPriority,
      child: ListTile(
        title: Text(priority.title),
        leading: Icon(
          Icons.flag,
          color: priority.color,
        ),
      ),
    );
  }).toList();
}
