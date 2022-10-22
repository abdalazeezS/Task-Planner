import 'package:flutter/material.dart';
import 'package:Task_Planner/widgets/task_record.dart';

import '../models/task.dart';

class TasksSection extends StatefulWidget {
  const TasksSection({
    Key? key,
    required this.tasksList,
    required this.onCheck,
  }) : super(key: key);
  final List<Task> tasksList;
  final Function onCheck;

  @override
  State<TasksSection> createState() => _TasksSectionState();
}

class _TasksSectionState extends State<TasksSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      width: double.infinity,
      constraints: const BoxConstraints(
        minHeight: 150,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          ...widget.tasksList.asMap().entries.map((e) {
            return TaskRecord(
              task: e.value,
              onChecked: () {
                setState(() {
                  widget.onCheck(e.value);
                });
              },
            );
          }).toList()
        ],
      ),
    );
  }
}
