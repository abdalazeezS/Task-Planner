import 'package:flutter/material.dart';

import '../models/task.dart';
import 'package:Task_Planner/constants.dart' as constants;

import '../widgets/completed_tasks_section.dart';
import '../widgets/tasks_section.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var finishedList = [
    Task(title: 'Study for SW Exam', date: 'today', isFinished: false),
    Task(title: 'Clean up my room', date: 'today', isFinished: false),
    Task(title: 'Go to gym', date: 'today', isFinished: false),
  ];

  var taskList = [
    Task(title: 'Wash the car', date: 'today', isFinished: false),
    Task(title: 'buy new clothes', date: 'today', isFinished: false),
    Task(
        title: 'Start coding flutter project',
        date: 'today',
        isFinished: false),
    Task(
        title: 'Solve Machine Learning homework',
        date: 'today',
        isFinished: false),
    Task(title: 'Prepare RTIT project', date: 'today', isFinished: false),
    Task(title: 'buy a new perfume', date: 'today', isFinished: false)
  ];
  int bottomNavigationBarSelectedIndex = 0;
  TextEditingController newTaskController = TextEditingController();

  void checkTask(Task task) async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      finishedList.add(task);
      taskList.remove(task);
    });
  }

  var taskDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constants.backgroundColor,
      drawer: Drawer(),
      appBar: buildAppBar(),
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
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.now().add(
                                        const Duration(days: 365),
                                      ),
                                    );

                                    if (datePicked != null) {
                                      setState(() {
                                        taskDate = datePicked;
                                      });
                                    }
                                  },
                                ),
                                IconButton(
                                  color: ThemeData().disabledColor,
                                  icon: const Icon(Icons.flag),
                                  onPressed: () {},
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
                                              date: taskDate.toString(),
                                              isFinished: false,
                                            ),
                                          );
                                        });
                                        Navigator.of(context).pop();
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

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black,
      elevation: 0,
      title: Text('Inbox'),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.more_vert),
        ),
      ],
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
}
