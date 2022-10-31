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
              var taskPriorityColor = Provider.of<TaskPriorityProvider>(
                context,
                listen: false,
              ).taskPriorityColor;

              var taskPriorityName = Provider.of<TaskPriorityProvider>(
                context,
                listen: false,
              ).taskPriority;

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
                                child: TextButton.icon(
                                  onPressed: null,
                                  icon: Icon(
                                    Icons.flag,
                                    color: taskPriorityColor,
                                  ),
                                  label: Text(
                                    taskPriorityName,
                                    style: TextStyle(
                                      color: taskPriorityColor,
                                    ),
                                  ),
                                ),
                                onSelected: (item) {
                                  Provider.of<TaskPriorityProvider>(
                                    context,
                                    listen: false,
                                  ).setTaskPriority(item.name);
                                },
                                itemBuilder: (BuildContext context) =>
                                    taskPriorityOptionList(),
                              ),
                              IconButton(
                                color: ThemeData().disabledColor,
                                icon: const Icon(Icons.local_offer),
                                onPressed: () {},
                              ),
                              PopupMenuButton(
                                child: TextButton.icon(
                                  onPressed: null,
                                  icon: Icon(Icons.inbox),
                                  label: Text('Inbox'),
                                ),
                                onSelected: (item) {},
                                itemBuilder: (BuildContext context) => [
                                  ...constants.categories
                                      .map(
                                        (e) => PopupMenuItem(
                                          child: Text(e.name),
                                        ),
                                      )
                                      .toList(),
                                ],
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
            },
          ).whenComplete(
            () => Provider.of<TaskPriorityProvider>(context, listen: false)
                .resetPriority(),
          );
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

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      elevation: 1,
      currentIndex: bottomNavigationBarSelectedIndex,
      onTap: (v) {
        setState(() {
          bottomNavigationBarSelectedIndex = v;
        });
      },
      showUnselectedLabels: false,
      showSelectedLabels: false,
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
