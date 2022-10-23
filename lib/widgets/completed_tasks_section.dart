import 'package:Task_Planner/models/task.dart';
import 'package:flutter/material.dart';

import 'completed_task_record.dart';

class CompletedTasksSection extends StatefulWidget {
  const CompletedTasksSection({
    Key? key,
    required this.finishedList,
  }) : super(key: key);
  final List<Task> finishedList;

  @override
  State<CompletedTasksSection> createState() => _CompletedTasksSectionState();
}

class _CompletedTasksSectionState extends State<CompletedTasksSection> {
  void removeCompletedTask(Task task) {
    setState(() {
      widget.finishedList.remove(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(
        minHeight: 150,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            horizontalTitleGap: 1,
            title: Text(
              'COMPLETE',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            trailing: Text(widget.finishedList.length.toString()),
          ),
          ...widget.finishedList.asMap().entries.map((e) {
            int index = e.key;
            return CompletedTaskRecord(
              task: e.value,
              onDrag: () {
                removeCompletedTask(e.value);
                print(widget.finishedList.toString());
              },
            );
          })
        ],
      ),
    );
  }
}
