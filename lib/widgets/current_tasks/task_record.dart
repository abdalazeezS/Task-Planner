import 'package:Task_Planner/screens/task_details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/task.dart';

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
  int calculateDifference(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
  }

  String get taskDateText {
    var taskDate = widget.task.date;
    if (calculateDifference(taskDate) == 1) {
      return "Tomorrow";
    } else if (calculateDifference(taskDate) > 1) {
      return DateFormat('dd/MM/yyyy').format(taskDate);
    }
    if (calculateDifference(taskDate) <= -1) {
      return "Missing";
    } else
      return "Today";
  }

  @override
  Widget build(BuildContext context) {
    //var datePicked = DateTime.parse(widget.task.date);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TaskDetails(
              task: widget.task,
            ),
          ),
        );
      },
      child: ListTile(
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
          taskDateText,
          style: taskDateText == 'Missing'
              ? TextStyle(color: Colors.redAccent)
              : TextStyle(color: Colors.blueAccent),
        ),
      ),
    );
  }
}
