import 'package:Task_Planner/models/task_category.dart';
import 'package:flutter/material.dart';

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
