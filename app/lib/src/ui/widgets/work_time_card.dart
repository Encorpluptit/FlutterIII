import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timetracking/src/models/work_time.dart';
import 'package:timetracking/src/ui/widgets/work_time_delete_dialog.dart';
import 'package:timetracking/src/ui/widgets/work_time_edit_dialog.dart';

class WorkTimeCard extends StatelessWidget {
  final WorkTime workTime;
  const WorkTimeCard({Key? key, required this.workTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String clockIn =
        DateFormat('dd/MM/yyy – HH:mm').format(workTime.in_!.toDate());
    String clockOut = "Not yet clocked out";
    if (workTime.out != null) {
      clockOut = DateFormat('dd/MM/yyy – HH:mm').format(workTime.out!.toDate());
    }
    String approval = "Approved✅";
    TextStyle approvalStyle = const TextStyle(color: Colors.green);
    if (workTime.requiresApproval!) {
      approval = "Not approved yet❌";
      approvalStyle = const TextStyle(color: Colors.red);
    }
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Ink(
            width: 300,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: const Border(
                top: BorderSide(width: 2.5, color: Colors.grey),
                bottom: BorderSide(width: 2.5, color: Colors.grey),
                left: BorderSide(width: 2.5, color: Colors.grey),
                right: BorderSide(width: 2.5, color: Colors.grey),
              ),
            ),
            child: InkWell(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Clocked in at: $clockIn"),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Clocked out at: $clockOut"),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    approval,
                    style: approvalStyle,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return WorkTimeEditDialog(workTime: workTime);
                            },
                          );
                        },
                        child: const Text("Edit"),
                      ),
                      TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return WorkTimeDeleteDialog(workTime: workTime);
                            },
                          );
                        },
                        child: const Text("Delete"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
