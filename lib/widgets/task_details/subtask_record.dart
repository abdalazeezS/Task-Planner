import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/task_provider.dart';
import '../../models/sub_task.dart';
import '../../models/task.dart';

class SubTaskRecord extends StatefulWidget with WidgetsBindingObserver {
  const SubTaskRecord({
    Key? key,
    required this.subTask,
    required this.task,
  }) : super(key: key);

  final SubTask subTask;
  final Task task;

  @override
  State<SubTaskRecord> createState() => _SubTaskRecordState();
}

class _SubTaskRecordState extends State<SubTaskRecord> {
  removeLastSubTask(Task task) {
    task.subTasks?.removeLast();
  }

  bool isDone = false;

  @override
  Widget build(BuildContext context) {
    var taskProvider = Provider.of<TaskProvider>(
      context,
      listen: true,
    );

    return Container(
      margin: EdgeInsets.only(bottom: 4),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Checkbox(
          value: isDone,
          onChanged: isDone
              ? null
              : (v) {
                  setState(() {
                    isDone = v!;
                  });
                },
        ),
        trailing: IconButton(
          onPressed: () {
            taskProvider.removeSubTask(widget.task, widget.subTask);
          },
          icon: Icon(Icons.close, color: Colors.red),
        ),
        title: Text(
          widget.subTask.title!,
          style: isDone
              ? TextStyle(
                  decoration: TextDecoration.lineThrough, color: Colors.black38)
              : null,
        ),
      ),
    );
  }
}
