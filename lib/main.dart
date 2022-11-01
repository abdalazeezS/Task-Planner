import 'package:Task_Planner/Providers/current_category_page_provider.dart';
import 'package:Task_Planner/Providers/task_category_provider.dart';
import 'package:Task_Planner/Providers/task_priority_provider.dart';
import 'package:Task_Planner/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      MultiProvider(
        child: MyApp(),
        providers: [
          ChangeNotifierProvider(create: (_) => TaskPriorityProvider()),
          ChangeNotifierProvider(create: (_) => TaskCategoryProvider()),
          ChangeNotifierProvider(create: (_)=> CurrentCategoryPageProvider()),
        ],
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Planner',
      home: HomeScreen(),
      routes: {
        'home': (context) => HomeScreen(),
      },
    );
  }
}
