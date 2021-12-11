import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timetracking/src/models/work_time.dart';

// ignore: must_be_immutable
class WorkTimeEditDialog extends StatefulWidget {
  final WorkTime workTime;
  final Function(DateTime in_, DateTime? out) onSave;

  late String clockInHour;
  late String clockInDate;
  late String clockOutHour;
  late String clockOutDate;
  TimeOfDay? inHourPicked;
  DateTime? inDatePicked;
  TimeOfDay? outHourPicked;
  DateTime? outDatePicked;
  WorkTimeEditDialog({Key? key, required this.workTime, required this.onSave})
      : super(key: key) {
    clockInHour = DateFormat('HH:mm').format(workTime.in_!.toDate());
    clockInDate = DateFormat('dd/MM/yyy').format(workTime.in_!.toDate());
    if (workTime.out != null) {
      clockOutHour = DateFormat('HH:mm').format(workTime.out!.toDate());
      clockOutDate = DateFormat('dd/MM/yyy').format(workTime.out!.toDate());
    } else {
      clockOutHour = "Not yet clocked out";
      clockOutDate = "Not yet clocked out";
    }
  }
  @override
  State<WorkTimeEditDialog> createState() => _WorkTimeEditDialogState();
}

class _WorkTimeEditDialogState extends State<WorkTimeEditDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            const Text("In:"),
            const SizedBox(height: 5),
            const Text("Hour:"),
            CupertinoTextField(
              placeholder: widget.clockInHour,
              onTap: () async {
                TimeOfDay time =
                    TimeOfDay.fromDateTime(widget.workTime.in_!.toDate());
                FocusScope.of(context).requestFocus(FocusNode());
                widget.inHourPicked = await showTimePicker(
                  context: context,
                  initialTime: time,
                );
                if (widget.inHourPicked != null) {
                  widget.clockInHour = widget.inHourPicked!.format(context);
                }
              },
            ),
            const Text("Date:"),
            CupertinoTextField(
              placeholder: widget.clockInDate,
              onTap: () async {
                FocusScope.of(context).requestFocus(FocusNode());
                widget.inDatePicked = await showDatePicker(
                    context: context,
                    firstDate: DateTime(1970),
                    lastDate: DateTime.now(),
                    initialDate: widget.workTime.in_!.toDate());
                if (widget.inDatePicked != null) {
                  widget.clockInDate =
                      DateFormat('dd/MM/yyy').format(widget.inDatePicked!);
                }
              },
            ),
            const SizedBox(height: 10),
            const Text("Out:"),
            const SizedBox(height: 5),
            const Text("Hour:"),
            CupertinoTextField(
              placeholder: widget.clockOutHour,
              onTap: () async {
                TimeOfDay time =
                    TimeOfDay.fromDateTime(widget.workTime.in_!.toDate());
                FocusScope.of(context).requestFocus(FocusNode());
                widget.outHourPicked = await showTimePicker(
                  context: context,
                  initialTime: time,
                );
                if (widget.outHourPicked != null) {
                  widget.clockOutHour = widget.outHourPicked!.format(context);
                }
              },
            ),
            const Text("Date:"),
            CupertinoTextField(
              placeholder: widget.clockOutDate,
              onTap: () async {
                late DateTime time;
                if (widget.workTime.out != null) {
                  time = widget.workTime.out!.toDate();
                } else {
                  time = DateTime.now();
                }
                FocusScope.of(context).requestFocus(FocusNode());
                widget.outDatePicked = await showDatePicker(
                  context: context,
                  firstDate: DateTime(1970),
                  lastDate: DateTime.now(),
                  initialDate: time,
                );
                if (widget.outDatePicked != null) {
                  widget.clockOutDate =
                      DateFormat('dd/MM/yyy').format(widget.outDatePicked!);
                }
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              var inDate = widget.workTime.in_!.toDate();
              var newInDate = DateTime(
                widget.inDatePicked?.year ?? inDate.year,
                widget.inDatePicked?.month ?? inDate.month,
                widget.inDatePicked?.day ?? inDate.day,
                widget.inHourPicked?.hour ?? inDate.hour,
                widget.inHourPicked?.minute ?? inDate.minute,
              );
              DateTime? newOutDate;
              if (widget.outDatePicked == null ||
                  widget.outHourPicked == null) {
                newOutDate = widget.workTime.out == null
                    ? null
                    : widget.workTime.out!.toDate();
              } else {
                newOutDate = DateTime(
                  widget.outDatePicked!.year,
                  widget.outDatePicked!.month,
                  widget.outDatePicked!.day,
                  widget.outHourPicked!.hour,
                  widget.outHourPicked!.minute,
                );
              }
              widget.onSave(newInDate, newOutDate);
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
