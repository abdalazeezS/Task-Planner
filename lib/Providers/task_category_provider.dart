import 'package:Task_Planner/constants.dart';
import 'package:flutter/material.dart';

import '../models/category.dart';

class TaskCategoryProvider with ChangeNotifier {
  Category taskCategory = Categories.inbox;

  setTaskCategory(Category category) {
    taskCategory = category;
    notifyListeners();
  }
}
