import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/sub_task.dart';
import '../models/task_category.dart';
import '../models/task.dart';

class TaskProvider with ChangeNotifier {
  List<Task> tasksList = [
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
        subTasks: [
          SubTask(title: 'clothes sub 1', isFinished: false),
        ]),
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

  DateTime taskDate = DateTime.now();
  String taskPriorityName = '';
  Color taskPriorityColor = Colors.black38;
  TaskPriorityType taskPriority = TaskPriorityType.none;

  addSubTask(Task task, SubTask subTask) {
    task.subTasks!.add(subTask);
    notifyListeners();
  }

  addTask(Task task) {
    tasksList.add(task);
    notifyListeners();
  }

  setTaskPriority(TaskPriorityType priority) {
    if (priority.name == 'none') {
      taskPriorityName = '';
      taskPriorityColor = Colors.black38;
    } else {
      taskPriorityName = priority.name + ' ';
      taskPriorityColor = priorityColorMap[taskPriorityName.trim()]!;
    }
    taskPriority = priority;
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

  resetTaskInfo() {
    taskCategory = Categories.inbox;
    taskPriorityName = '';
    taskPriorityColor = Colors.black38;
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
