import 'package:Task_Planner/constants.dart';
import 'package:flutter/material.dart';

import '../models/category.dart';

class TaskCategoryProvider with ChangeNotifier {
  Category taskCategory = Categories.inbox;

  resetTaskCategory() {
    taskCategory = Categories.inbox;
    notifyListeners();
  }

  setTaskCategory(Category category) {
    taskCategory = category;
    notifyListeners();
  }
}
