import 'package:flutter/material.dart';

import '../models/task.dart';

class CompletedTaskRecord extends StatelessWidget {
  const CompletedTaskRecord({
    Key? key,
    required this.task,
  }) : super(key: key);
  final Task task;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 1,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      leading: Checkbox(
        value: true,
        onChanged: null,
      ),
      title: Text(
        task.title,
        style: TextStyle(
          color: ThemeData().disabledColor,
        ),
      ),
    );
  }
}
