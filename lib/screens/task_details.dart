import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
                  trailing: Icon(Icons.flag),
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
                    maxLines: 3,
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
