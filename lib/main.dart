import 'package:Task_Planner/widgets/complete_tasks_section.dart';
import 'package:Task_Planner/widgets/tasks_section.dart';
import 'package:flutter/material.dart';

import 'models/task.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Planner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Inbox'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int bottomNavigationBarSelectedIndex = 0;
  TextEditingController newTaskController = TextEditingController();

  void checkTask(Task task) async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      finishedList.add(task);
      taskList.remove(task);
    });
  }

  var finishedList = [
    Task(title: 'saddsfasfdsafd', date: 'today', isFinished: false),
    Task(title: 'saddsfasfdsafd', date: 'today', isFinished: false),
    Task(title: 'saddsfasfdsafd', date: 'today', isFinished: false),
  ];
  var taskList = [
    Task(title: 'test', date: 'today', isFinished: false),
    Task(title: 'test1', date: 'today', isFinished: false),
    Task(title: 'test2', date: 'today', isFinished: false),
    Task(title: 'test3', date: 'today', isFinished: false),
    Task(title: 'test4', date: 'today', isFinished: false),
    Task(title: 'test5', date: 'today', isFinished: false)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F5FE),
      drawer: Drawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        title: Text(widget.title),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TasksSection(tasksList: taskList, onCheck: checkTask),
                const SizedBox(height: 16),
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
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: newTaskController,
                        autofocus: true,
                        decoration: const InputDecoration(
                          hintText: 'New Task',
                        ),
                      ),
                      const SizedBox(height: 16),
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
                                  onPressed: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.now().add(
                                        const Duration(days: 365),
                                      ),
                                    );
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
                                              date: 'Today',
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
      bottomNavigationBar: BottomNavigationBar(
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
      ),
    );
  }
}
