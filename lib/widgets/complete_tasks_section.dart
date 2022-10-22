import 'package:flutter/material.dart';

import 'completed_task_record.dart';

class CompletedTasksSection extends StatelessWidget {
  const CompletedTasksSection({
    Key? key,
    required this.finishedList,
  }) : super(key: key);
  final List finishedList;

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
          const ListTile(
            horizontalTitleGap: 1,
            title: Text(
              'COMPLETE',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            trailing: Text('1'),
          ),
          ...finishedList.asMap().entries.map((e) {
            int index = e.key;
            return CompletedTaskRecord(task: e.value);
          })
        ],
      ),
    );
  }
}
