import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timetracking/src/models/work_time.dart';

class WorkTimeEditDialog extends StatelessWidget {
  final WorkTime workTime;
  const WorkTimeEditDialog({Key? key, required this.workTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit'),
      content: const Text('Here goes the content to edit...'),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              _dismissDialog(context);
            },
            child: const Text('Save')),
        TextButton(
          onPressed: () {
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
