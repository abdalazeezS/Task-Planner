import 'package:flutter/material.dart';

import 'models/category.dart';

const Color backgroundColor = Color(0xFFF2F5FE);
const EdgeInsets space16 = EdgeInsets.all(16.0);
const EdgeInsets space8 = EdgeInsets.all(8.0);
const SizedBox sizedBox16Height = SizedBox(height: 16);
var categories = [
  Category(name: 'Today', icon: Icons.today),
  Category(name: 'Inbox', icon: Icons.inbox),
  Category(name: 'Welcome', icon: Icons.waving_hand_sharp),
  Category(name: 'Work', icon: Icons.today),
  Category(name: 'Personal', icon: Icons.work),
  Category(name: 'Shopping', icon: Icons.shopping_cart_rounded),
  Category(name: 'Wish List', icon: Icons.hourglass_top),
  Category(name: 'Birthday', icon: Icons.cake),
];
