import 'package:flutter/material.dart';

import 'models/category.dart';
import 'models/task.dart';

const Color backgroundColor = Color(0xFFF2F5FE);
const EdgeInsets space16 = EdgeInsets.all(16.0);
const EdgeInsets space8 = EdgeInsets.all(8.0);
const SizedBox sizedBox16Height = SizedBox(height: 16);

class Categories {
  static Category today = Category(name: 'Today', icon: Icons.today);
  static Category inbox = Category(name: 'Inbox', icon: Icons.inbox);
  static Category welcome =
      Category(name: 'Welcome', icon: Icons.waving_hand_sharp);
  static Category work = Category(name: 'Work', icon: Icons.today);
  static Category personal = Category(name: 'Personal', icon: Icons.work);
  static Category shopping =
      Category(name: 'Shopping', icon: Icons.shopping_cart_rounded);
  static Category wishList =
      Category(name: 'Wish List', icon: Icons.hourglass_top);
  static Category birthday = Category(name: 'Birthday', icon: Icons.cake);

  static List<Category> categoriesList = [
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
    taskPriority: TaskPriority.none,
  ),
  Task(
    title: 'Clean up my room',
    date: DateTime.now(),
    isFinished: false,
    taskPriority: TaskPriority.none,
  ),
  Task(
    title: 'Go to gym',
    date: DateTime.now(),
    isFinished: false,
    taskPriority: TaskPriority.none,
  ),
];

var taskList = [
  Task(
    title: 'Wash the car',
    date: DateTime.now(),
    isFinished: false,
    taskPriority: TaskPriority.high,
  ),
  Task(
    title: 'buy new clothes',
    date: DateTime.now(),
    isFinished: false,
    taskPriority: TaskPriority.low,
  ),
  Task(
    title: 'Start coding flutter project',
    date: DateTime.now(),
    isFinished: false,
    taskPriority: TaskPriority.medium,
  ),
  Task(
    title: 'Prepare RTIT project',
    date: DateTime.now(),
    isFinished: false,
    taskPriority: TaskPriority.none,
  ),
  Task(
    title: 'buy a new perfume',
    date: DateTime.now(),
    isFinished: false,
    taskPriority: TaskPriority.none,
  )
];

enum TaskPriority { high, medium, low, none }

Map<String, Color> priorityColorMap = {
  'high': Colors.red,
  'medium': Colors.yellow,
  'low': Colors.blue,
  'none': Colors.black38,
};

Map<Category, List<Task>> tasksList = {
  Categories.inbox: [],
  Categories.welcome: [],
};

List<PopupMenuEntry<TaskPriority>> taskPriorityOptionList() {
  return [
    PopupMenuItem(
      value: TaskPriority.high,
      child: ListTile(
        title: Text('High Priority'),
        leading: Icon(
          Icons.flag,
          color: Colors.red,
        ),
      ),
    ),
    PopupMenuItem(
      value: TaskPriority.medium,
      child: ListTile(
        title: Text('Medium Priority'),
        leading: Icon(
          Icons.flag,
          color: Colors.yellow,
        ),
      ),
    ),
    PopupMenuItem(
      value: TaskPriority.low,
      child: ListTile(
        title: Text('Low Priority'),
        leading: Icon(
          Icons.flag,
          color: Colors.blue,
        ),
      ),
    ),
    PopupMenuItem(
      value: TaskPriority.none,
      child: ListTile(
        title: Text('No Priority'),
        leading: Icon(
          Icons.flag,
          color: Colors.grey,
        ),
      ),
    )
  ];
}
