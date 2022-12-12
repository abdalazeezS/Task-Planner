import 'package:flutter/material.dart';
import 'package:Task_Planner/widgets/current_tasks/current_task_record.dart';

import '../../models/task.dart';

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
        minHeight: 50,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: widget.tasksList.isEmpty
          ? Container(
              padding: EdgeInsets.all(32),
              child: Column(
                children: [
                  Text(
                    'Your List is empty! Enjoy your time 🤩',
                    style: TextStyle(fontSize: 15),
                  ),
                  Image.asset('assets/images/tasks_img.png'),
                ],
              ),
            )
          : Column(
              children: [
                ...widget.tasksList.map((task) {
                  return TaskRecord(
                    task: task,
                    onChecked: () {
                      setState(() {
                        widget.onCheck(task);
                      });
                    },
                  );
                }).toList(),
                // ...widget.tasksList.asMap().entries.map((e) {
                //   return TaskRecord(
                //     task: e.value,
                //     onChecked: () {
                //       setState(() {
                //         widget.onCheck(e.value);
                //       });
                //     },
                //   );
                // }).toList()
              ],
            ),
    );
  }
}
