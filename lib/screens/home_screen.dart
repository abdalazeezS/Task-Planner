import 'package:Task_Planner/Providers/task_provider.dart';
import 'package:Task_Planner/constants.dart';
import 'package:Task_Planner/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task_category.dart';
import '../models/task.dart';
import '../widgets/app_drawer.dart';
import '../widgets/completed_tasks/completed_tasks_section.dart';
import '../widgets/current_tasks/current_tasks_section.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key, this.title});

  final String? title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int bottomNavigationBarSelectedIndex = 0;

  TextEditingController newTaskController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    print('home build method');
    var taskProvider = Provider.of<TaskProvider>(
      context,
      listen: true,
    );

    var currentCategory = taskProvider.currentCategory;

    var currentCategoryTasks = taskProvider.tasksList
        .where((element) => element.category == currentCategory)
        .toList();

    var currentCategoryFinishedTasks = finishedList
        .where((element) => element.category == currentCategory)
        .toList();

    return Scaffold(
      backgroundColor: backgroundColor,
      drawer: AppDrawer(),
      appBar: CustomAppBar(title: currentCategory.name),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: space16,
            child: Column(
              children: [
                TasksSection(
                  tasksList: currentCategoryTasks,
                  onCheck: checkTask,
                ),
                sizedBox16Height,
                CompletedTasksSection(
                  finishedList: currentCategoryFinishedTasks,
                ),
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
                padding: space8,
                child: Column(
                  children: [
                    TextField(
                      controller: newTaskController,
                      autofocus: true,
                      decoration: const InputDecoration(
                        hintText: 'New Task',
                      ),
                    ),
                    sizedBox16Height,
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
                                  if (datePicked != null)
                                    taskProvider.taskDate = datePicked;
                                },
                              ),
                              PopupMenuButton<TaskPriorityType>(
                                child: TextButton.icon(
                                  onPressed: null,
                                  icon: Icon(
                                    Icons.flag,
                                    color: taskProvider.taskPriorityColor,
                                  ),
                                  label: Text(
                                    taskProvider.taskPriorityName,
                                    style: TextStyle(
                                      color: taskProvider.taskPriorityColor,
                                    ),
                                  ),
                                ),
                                onSelected: (item) {
                                  taskProvider.setTaskPriority(item);
                                },
                                itemBuilder: (BuildContext context) =>
                                    taskPriorityOptionList(),
                              ),
                              IconButton(
                                color: ThemeData().disabledColor,
                                icon: const Icon(Icons.local_offer),
                                onPressed: () {},
                              ),
                              PopupMenuButton<TaskCategory>(
                                child: TextButton.icon(
                                  onPressed: null,
                                  icon: Icon(
                                    taskProvider.taskCategory.icon,
                                  ),
                                  label: Text(
                                    taskProvider.taskCategory.name,
                                  ),
                                ),
                                onSelected: (item) {
                                  taskProvider.setTaskCategory(item);
                                },
                                itemBuilder: (BuildContext context) => [
                                  ...Categories.categoriesList
                                      .map(
                                        (category) =>
                                            PopupMenuItem<TaskCategory>(
                                          child: ListTile(
                                            leading: Icon(category.icon),
                                            title: Text(category.name),
                                          ),
                                          value: category,
                                        ),
                                      )
                                      .toList(),
                                ],
                              ),
                            ],
                          ),
                        ),
                        buildAddTaskButton(taskProvider)
                      ],
                    ),
                  ],
                ),
              );
            },
          ).whenComplete(() => resetBottomSheet(context));
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

  ValueListenableBuilder<TextEditingValue> buildAddTaskButton(
      TaskProvider taskProvider) {
    return ValueListenableBuilder(
      valueListenable: newTaskController,
      builder: ((context, value, child) {
        return ElevatedButton(
          onPressed: value.text.isEmpty
              ? null
              : () {
                  taskProvider.addTask(
                    Task(
                      title: newTaskController.text,
                      date: taskProvider.taskDate,
                      isFinished: false,
                      category: taskProvider.taskCategory,
                      taskPriority: taskProvider.taskPriority,
                      subTasks: [],
                    ),
                  );
                  Navigator.of(context).pop();
                  newTaskController.clear();
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
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
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
      Provider.of<TaskProvider>(context, listen: false).tasksList.remove(task);
    });
  }

  void resetBottomSheet(BuildContext ctx) {
    Provider.of<TaskProvider>(
      ctx,
      listen: false,
    ).resetTaskInfo();
  }
}
