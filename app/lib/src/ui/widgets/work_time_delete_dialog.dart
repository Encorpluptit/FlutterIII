import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timetracking/src/models/work_time.dart';

class WorkTimeDeleteDialog extends StatelessWidget {
  final WorkTime workTime;
  final VoidCallback onDeletePressed;
  const WorkTimeDeleteDialog({
    Key? key,
    required this.workTime,
    required this.onDeletePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete'),
      content: const Text('Are you sure you want to delete this entry?'),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              onDeletePressed();
              _dismissDialog(context);
            },
            child: const Text('Delete')),
        TextButton(
          onPressed: () async {
            _dismissDialog(context);
          },
          child: const Text('Cancel'),
        )
      ],
    );
  }

  _dismissDialog(context) {
    Navigator.pop(context);
  }
}
