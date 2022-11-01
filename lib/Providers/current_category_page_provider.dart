import 'package:Task_Planner/constants.dart';
import 'package:flutter/material.dart';

import '../models/category.dart';

class CurrentCategoryPageProvider with ChangeNotifier {
  Category currentCategory = Categories.inbox;

  setCurrentCategory(Category category) {
    currentCategory = category;
    notifyListeners();
  }
}
