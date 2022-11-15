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
  @override
  Widget build(BuildContext context) {
    var taskProvider = Provider.of<TaskProvider>(
      context,
      listen: true,
    );

    TextEditingController _subTaskController = TextEditingController(
      text: widget.subTask.title,
    );

    return Container(
      margin: EdgeInsets.only(bottom: 4),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Checkbox(
          value: widget.subTask.isFinished ?? false,
          onChanged: (v) {
            setState(() {
              widget.subTask.isFinished = v;
            });
          },
        ),
        trailing: IconButton(
          onPressed: () {
            taskProvider.removeSubTask(widget.task, widget.subTask);
          },
          icon: Icon(Icons.close, color: Colors.red),
        ),
        title: TextField(
          style: widget.subTask.isFinished == true
              ? TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: ThemeData().disabledColor,
                )
              : null,
          enabled: widget.subTask.isFinished == true ? false : true,
          onSubmitted: (value) {
            _subTaskController.text = value;
            /**
             * When click Add Sub Task Button, it will add a dummy subTask, also
             * it will add a dummy subTask record, here we got 2 subTasks, the
             * empty one and the one that we want to write its title, so we must
             * remove the last subTask (the empty one) and then we can add the new one.
             */
            taskProvider.removeLastSubTask(widget.task);
            taskProvider.addSubTask(
              widget.task,
              SubTask(
                title: _subTaskController.text,
              ),
            );
          },
          controller: _subTaskController,
          autofocus: _subTaskController.text.isEmpty ? true : false,
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
            ),
            hintText: 'new subtask',
          ),
        ),
      ),
    );
  }
}
