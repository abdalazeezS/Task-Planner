import 'package:Task_Planner/models/task.dart';
import 'package:Task_Planner/providers/database_provider.dart';
import 'package:flutter/material.dart';

import 'completed_task_record.dart';

class CompletedTasksSection extends StatefulWidget {
  const CompletedTasksSection({
    Key? key,
  }) : super(key: key);

  @override
  State<CompletedTasksSection> createState() => _CompletedTasksSectionState();
}

class _CompletedTasksSectionState extends State<CompletedTasksSection> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DatabaseProvider.db.getCompletedTasks(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Task> tasks = snapshot.data as List<Task>;
          return Container(
            width: double.infinity,
            constraints: const BoxConstraints(
              minHeight: 50,
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
                  trailing: Text(tasks.length.toString()),
                ),
                ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: tasks.asMap().entries.map((e) {
                    return CompletedTaskRecord(
                      task: e.value,
                      onDrag: () async {
                        await DatabaseProvider.db.removeTask(e.value.id!);
                        setState(() {});
                        print(tasks.toString());
                      },
                    );
                  }).toList(),
                )
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text('ERROR ${snapshot.error}');
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
