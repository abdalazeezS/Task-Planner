import 'package:flutter/material.dart';

import '../models/task.dart';

class TaskRecord extends StatefulWidget {
  const TaskRecord({
    Key? key,
    required this.onChecked,
    required this.task,
  }) : super(key: key);
  final Task task;
  final Function onChecked;

  @override
  State<TaskRecord> createState() => _TaskRecordState();
}

class _TaskRecordState extends State<TaskRecord> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 1,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      leading: Checkbox(
          value: widget.task.isFinished,
          onChanged: (v) {
            setState(() {
              widget.task.isFinished = v!;
              widget.onChecked();
            });
          }),
      title: Text(widget.task.title),
      trailing: Text(
        widget.task.date,
        style: const TextStyle(
          color: Colors.blueAccent,
        ),
      ),
    );
  }
}
