import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Providers/task_provider.dart';
import '../constants.dart';
import '../models/task.dart';

class TaskDetails extends StatelessWidget {
  TaskDetails({
    Key? key,
    required this.task,
  }) : super(key: key);
  final Task task;

  int calculateDifference(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _taskDescriptionController = TextEditingController(
      text: Provider.of<TaskProvider>(
        context,
        listen: false,
      ).getTaskDescription(task),
    );

    _taskDescriptionController.selection =
        TextSelection.collapsed(offset: _taskDescriptionController.text.length);

    var remainingDays = calculateDifference(task.date);
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.list_alt),
                  title: Text(
                    remainingDaysText + DateFormat('MMM dd').format(task.date),
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
                  child: TextField(
                    controller: _taskDescriptionController,
                    maxLines: 3,
                    onChanged: (value) {
                      task.description = _taskDescriptionController.text;
                      Provider.of<TaskProvider>(
                        context,
                        listen: false,
                      ).setTaskDescription(task, task.description);
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
