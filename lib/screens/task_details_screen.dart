import 'package:Task_Planner/models/sub_task.dart';
import 'package:Task_Planner/providers/database_provider.dart';
import 'package:Task_Planner/widgets/task_details/subtask_record.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Providers/task_provider.dart';
import '../constants.dart';
import '../models/task.dart';

class TaskDetails extends StatefulWidget {
  TaskDetails({
    Key? key,
    required this.task,
  }) : super(key: key);
  final Task task;

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  int calculateDifference(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
  }

  Future<Task> getTask() async {
    List<Task> tasksObject = await DatabaseProvider.db.getTasks();

    return tasksObject.firstWhere((element) => element.id == widget.task.id);
  }

  late Future<Task> task;

  Future<Task> getRealTask() async {
    Task task = await getTask();
    return task;
  }

  @override
  void initState() {
    task = getRealTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var taskProvider = Provider.of<TaskProvider>(
      context,
      listen: true,
    );

    TextEditingController _taskDescriptionController;

    var remainingDays = calculateDifference(widget.task.date);
    var remainingDaysText = '';

    if (remainingDays > 1) {
      remainingDaysText = '${remainingDays} days later, ';
    } else if (remainingDays == 1) {
      remainingDaysText = 'Tomorrow, ';
    } else if (remainingDays == 0) {
      remainingDaysText = 'Today, ';
    } else {
      remainingDaysText = 'Missing, ';
    }

    // Future<Task>? task = FutureBuilder<Task>(
    //   future: getTask(),
    //   builder: (context, snapshot) {
    //     if (snapshot.hasData){
    //       return snapshot.data;
    //     }
    //   },
    // ).future

    TextEditingController subTaskController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                FutureBuilder(
                  future: task,
                  builder: (context, snapshot) {
                    Task? task = snapshot.data;
                    if (snapshot.hasData) {
                      _taskDescriptionController =
                          TextEditingController(text: task?.description);
                      // _taskDescriptionController.selection =
                      //     TextSelection.collapsed(
                      //   offset: _taskDescriptionController.text.length,
                      // );
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(Icons.list_alt),
                            title: Text(
                              remainingDaysText +
                                  DateFormat('MMM dd').format(task!.date),
                              style: TextStyle(
                                color: remainingDaysText == 'Missing, '
                                    ? Colors.redAccent
                                    : Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            trailing: Icon(
                              Icons.flag,
                              color: priorityColorMap[task.taskPriority.name],
                            ),
                          ),
                          Text(
                            task.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.87),
                              fontSize: 25,
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            height: 50,
                            child: TextField(
                              controller: _taskDescriptionController,
                              maxLines: 3,
                              onChanged: (value) {
                                widget.task.description =
                                    _taskDescriptionController.text;
                                DatabaseProvider.db.updateTask(widget.task);
                                // setState(() {});
                                // print(
                                //     'task description===============================:${task.description}');
                                // task.description = _taskDescriptionController.text;
                                // taskProvider.setTaskDescription(
                                //   task,
                                //   task.description,
                                // );
                              },
                              decoration: InputDecoration(
                                hintText: 'Description',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 4,
                                  vertical: 8,
                                ),
                              ),
                            ),
                          ),
                          ListTile(
                            leading: null,
                            // minLeadingWidth: 500,
                            contentPadding: EdgeInsets.symmetric(horizontal: 0),
                            title: TextField(
                              controller: subTaskController,
                              // style: widget.subTask.isFinished == true
                              //     ? TextStyle(
                              //   decoration: TextDecoration.lineThrough,
                              //   color: ThemeData().disabledColor,
                              // )
                              //     : null,
                              // enabled: widget.subTask.isFinished == true ? false : true,
                              // onSubmitted: (value) async {
                              //   // _subTaskController.text = value;
                              //   /**
                              //    * When click Add Sub Task Button, it will add a dummy subTask, also
                              //    * it will add a dummy subTask record, here we got 2 subTasks, the
                              //    * empty one and the one that we want to write its title, so we must
                              //    * remove the last subTask (the empty one) and then we can add the new one.
                              //    */
                              //   // taskProvider.removeLastSubTask(widget.task);
                              //   // removeLastSubTask(widget.task);
                              //   await DatabaseProvider.db.updateTask(widget.task);
                              //   // setState(() {
                              //   //
                              //   // });
                              //
                              //   // taskProvider.addSubTask(
                              //   //   widget.task,
                              //   //   SubTask(
                              //   //     title: _subTaskController.text,
                              //   //   ),
                              //   // );
                              // },
                              // controller: _subTaskController,
                              // autofocus: _subTaskController.text.isEmpty ? true : false,
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black12),
                                ),
                                hintText: 'new subtask',
                              ),
                            ),
                            trailing: TextButton.icon(
                              onPressed: () async {
                                task.subTasks!.add(
                                    SubTask(title: subTaskController.text));
                                await DatabaseProvider.db.updateTask(task);
                                setState(() {});
                              },
                              icon: Icon(Icons.add),
                              label: Text('add'),
                            ),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      print(
                          'SubTasksError===============================${snapshot.error}');
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
                FutureBuilder(
                  future: DatabaseProvider.db.getSubTasks(widget.task),
                  builder: (context, snapshot) {
                    String? subTasks = snapshot.data;
                    print('SubTasks========================${subTasks}');

                    List<SubTask> getSubTasksFromString(String subTasksString) {
                      if (subTasksString.isNotEmpty) {
                        final splitNames = subTasksString.split(',');
                        List<SubTask> splitList = [];
                        for (int i = 0; i < splitNames.length; i++) {
                          splitList.add(SubTask(
                            title: splitNames[i],
                            isFinished: false,
                          ));
                        }
                        print(
                            'split================================${splitList}');
                        return splitList;
                      }
                      return [];
                    }

                    if (snapshot.hasData) {
                      return subTasks!.isEmpty
                          ? Container()
                          : Container(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  ...getSubTasksFromString(subTasks)
                                      .map((subTask) {
                                    print(
                                        "#############################${subTask.title.toString()}");
                                    return SubTaskRecord(
                                      task: widget.task,
                                      subTask: subTask,
                                    );
                                  }).toList(),
                                  // TextButton.icon(
                                  //   onPressed: () async {
                                  //     widget.task.subTasks?.add(SubTask(title: ''));
                                  //     await DatabaseProvider.db
                                  //         .updateTask(widget.task);
                                  //     print(
                                  //         "task==============================${widget.task.subTasks}");
                                  //     setState(() {});
                                  //     print(
                                  //         "subTasks=============${widget.task.subTasks}");
                                  //     setState(() {});
                                  //     // taskProvider.addSubTask(
                                  //     //   task,
                                  //     //   SubTask(),
                                  //     // );
                                  //   },
                                  //   icon: Icon(Icons.add),
                                  //   label: Text('Add SubTask'),
                                  // ),
                                ],
                              ),
                            );
                    } else if (snapshot.hasError) {
                      return Text('ERROR! ${snapshot.error}');
                    } else
                      return CircularProgressIndicator();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
