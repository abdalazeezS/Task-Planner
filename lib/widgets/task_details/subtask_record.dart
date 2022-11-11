import 'package:flutter/material.dart';

class SubTaskRecord extends StatelessWidget {
  const SubTaskRecord({
    Key? key,
    required this.subTaskTitle,
  }) : super(key: key);
  final String subTaskTitle;

  @override
  Widget build(BuildContext context) {
    TextEditingController _subTaskController =
        TextEditingController(text: subTaskTitle);
    return Container(
      margin: EdgeInsets.only(bottom: 4),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Checkbox(value: true, onChanged: (v) {}),
        trailing: IconButton(
          onPressed: () {},
          icon: Icon(Icons.close, color: Colors.red),
        ),
        title: TextField(
          controller: _subTaskController,
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
            ),
            hintText: 'new subtask',
          ),
        ),
      ),
    );
  }
}
