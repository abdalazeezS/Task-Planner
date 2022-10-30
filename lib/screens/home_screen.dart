import 'package:Task_Planner/Providers/task_priority_provider.dart';
import 'package:Task_Planner/constants.dart' as constants;
import 'package:Task_Planner/widgets/app_bar.dart';
import 'package:flutter/material.dart';

import '../models/task.dart';
import '../widgets/app_drawer.dart';
import '../widgets/completed_tasks/completed_tasks_section.dart';
import '../widgets/current_tasks/tasks_section.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum TaskPriority { high, medium, low, none }

class _HomeScreenState extends State<HomeScreen> {
  var finishedList = [
    Task(title: 'Study for SW Exam', date: DateTime.now(), isFinished: false),
    Task(title: 'Clean up my room', date: DateTime.now(), isFinished: false),
    Task(title: 'Go to gym', date: DateTime.now(), isFinished: false),
  ];

  var taskList = [
    Task(title: 'Wash the car', date: DateTime.now(), isFinished: false),
    Task(title: 'buy new clothes', date: DateTime.now(), isFinished: false),
    Task(
        title: 'Start coding flutter project',
        date: DateTime.now(),
        isFinished: false),
    Task(
        title: 'Solve Machine Learning homework',
        date: DateTime.now(),
        isFinished: false),
    Task(
        title: 'Prepare RTIT project', date: DateTime.now(), isFinished: false),
    Task(title: 'buy a new perfume', date: DateTime.now(), isFinished: false)
  ];
  int bottomNavigationBarSelectedIndex = 0;

  var taskDate = DateTime.now();

  var taskPriority = '';

  TextEditingController newTaskController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constants.backgroundColor,
      drawer: AppDrawer(),
      appBar: CustomAppBar(
        title: 'Inbox',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: constants.space16,
            child: Column(
              children: [
                TasksSection(tasksList: taskList, onCheck: checkTask),
                constants.sizedBox16Height,
                CompletedTasksSection(finishedList: finishedList),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              context: context,
              builder: (_) {
                return Padding(
                  padding: constants.space8,
                  child: Column(
                    children: [
                      TextField(
                        controller: newTaskController,
                        autofocus: true,
                        decoration: const InputDecoration(
                          hintText: 'New Task',
                        ),
                      ),
                      constants.sizedBox16Height,
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                IconButton(
                                  color: ThemeData().disabledColor,
                                  icon: const Icon(
                                    Icons.calendar_month_rounded,
                                  ),
                                  onPressed: () async {
                                    DateTime? datePicked = await showDatePicker(
                                      context: context,
                                      currentDate: DateTime.now(),
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2022),
                                      lastDate: DateTime.now().add(
                                        const Duration(days: 365),
                                      ),
                                    );
                                    setState(() {
                                      if (datePicked != null)
                                        taskDate = datePicked;
                                    });
                                  },
                                ),
                                PopupMenuButton<TaskPriority>(
                                  onSelected: (item) {
                                    Provider.of<TaskPriorityProvider>(
                                      context,
                                      listen: false,
                                    ).setTaskPriority(item.name);

                                    newTaskController.text =
                                        Provider.of<TaskPriorityProvider>(
                                      context,
                                      listen: false,
                                    ).taskPriority;
                                  },
                                  icon: Icon(
                                    Icons.flag,
                                    color: ThemeData().disabledColor,
                                  ),
                                  itemBuilder: (BuildContext context) => [
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
                                  ],
                                ),
                                IconButton(
                                  color: ThemeData().disabledColor,
                                  icon: const Icon(Icons.local_offer),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  color: ThemeData().disabledColor,
                                  icon: const Icon(Icons.inbox),
                                  onPressed: () {},
                                ),
                                Text(
                                  'Inbox',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: ThemeData().disabledColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ValueListenableBuilder(
                            valueListenable: newTaskController,
                            builder: ((context, value, child) {
                              return ElevatedButton(
                                onPressed: value.text.isEmpty
                                    ? null
                                    : () {
                                        setState(() {
                                          taskList.add(
                                            Task(
                                              title: newTaskController.text,
                                              date: taskDate,
                                              isFinished: false,
                                            ),
                                          );
                                        });
                                        Navigator.of(context).pop();
                                        newTaskController.clear();
                                        print(taskDate);
                                      },
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                                child: const Icon(Icons.send),
                              );
                            }),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              });
        },
        tooltip: 'Add Task',
        child: const Icon(
          Icons.add_task,
          size: 30,
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      elevation: 1,
      currentIndex: bottomNavigationBarSelectedIndex,
      onTap: (v) {
        setState(() {
          bottomNavigationBarSelectedIndex = v;
        });
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.check_box),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today_outlined),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: '',
        ),
      ],
    );
  }

  void checkTask(Task task) async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      finishedList.add(task);
      taskList.remove(task);
    });
  }
}
