import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:website/blocs/work_time/bloc.dart';
import 'package:website/models/work_time.dart';

class WorkTime extends StatefulWidget {
  final WorkTimeModel workTime;

  WorkTime({Key? key, required this.workTime}) : super(key: key);

  @override
  _WorkTime createState() => _WorkTime();
}

class _WorkTime extends State<WorkTime> {
  var inController = TextEditingController();
  var outController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  TimeOfDay inTime = TimeOfDay.now();
  TimeOfDay outTime = TimeOfDay.now();
  DateTime inDate = DateTime.now();
  DateTime outDate = DateTime.now();
  var inChanged = false;
  var outChanged = false;

  @override
  void initState() {
    super.initState();
    if (widget.workTime.in_ != null) {
      inDate = widget.workTime.in_!.toDate();
      inTime = TimeOfDay.fromDateTime(widget.workTime.in_!.toDate());
      var inTmp = TimeOfDay.fromDateTime(widget.workTime.in_!.toDate());
      inController = TextEditingController(
          text:
              '${inDate.year}-${inDate.month}-${inDate.day} ${inTmp.hour}:${inTmp.minute} ${inTmp.period.name.toString().toUpperCase()}');
    }
    if (widget.workTime.out != null) {
      outDate = widget.workTime.out!.toDate();
      outTime = TimeOfDay.fromDateTime(widget.workTime.out!.toDate());
      var outTmp = TimeOfDay.fromDateTime(widget.workTime.out!.toDate());
      outController = TextEditingController(
          text:
              '${outDate.year}-${outDate.month}-${outDate.day} ${outTmp.hour}:${outTmp.minute} ${outTmp.period.name.toString().toUpperCase()}');
    }
  }

  _submitWorkTime(BuildContext context) async {
    var newWorkTime = widget.workTime;
    if (widget.workTime.in_ != null && inChanged) {
      var modelDate = DateTime(
          inDate.year, inDate.month, inDate.day, inTime.hour, inTime.minute);
      newWorkTime.in_ = Timestamp.fromDate(modelDate);
    }
    if (widget.workTime.out != null && outChanged) {
      var modelDate = DateTime(outDate.year, outDate.month, outDate.day,
          outTime.hour, outTime.minute);
      print(modelDate.toString());
      newWorkTime.out = Timestamp.fromDate(modelDate);
    }
    newWorkTime.requiresApproval = false;
    BlocProvider.of<UserWorkTimeBloc>(context)
        .add(UserWorkTimeUpdateEvent(newWorkTime));
  }

  _selectInTime(BuildContext context) async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: inDate,
      firstDate: DateTime(1970),
      lastDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendar,
    );
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: inTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null &&
        date != null &&
        (date != inDate || timeOfDay != inTime)) {
      setState(() {
        inController.text =
            '${date.year}-${date.month}-${date.day} ${timeOfDay.format(context)}';
        inDate = date;
        inTime = timeOfDay;
        inChanged = true;
      });
    }
  }

  _selectOutTime(BuildContext context) async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: outDate,
      firstDate: DateTime(1970),
      lastDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendar,
    );
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: outTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null &&
        date != null &&
        (date != outDate || timeOfDay != outTime)) {
      setState(() {
        outController.text =
            '${date.year}-${date.month}-${date.day} ${timeOfDay.format(context)}';
        outDate = date;
        outTime = timeOfDay;
        outChanged = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 4.25,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 9,
                          child: TextFormField(
                            controller: inController,
                            readOnly: true,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'In Time',
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _selectInTime(context);
                          },
                          child: Text("Change"),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 9,
                          child: TextFormField(
                            controller: outController,
                            readOnly: true,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Out Time',
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                          onPressed: () {
                            _selectOutTime(context);
                          },
                          child: Text("Change"),
                        ),
                      ],
                    ),
                    Divider(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.green),
                      onPressed: () {
                        _submitWorkTime(context);
                      },
                      child: Text("Validate Work Time"),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 4.25,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: widget.workTime.inLatitude != null
                          ? widget.workTime.inLatitude.toString()
                          : '',
                      readOnly: true,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'In latitude',
                      ),
                    ),
                    TextFormField(
                      initialValue: widget.workTime.inLongitude != null
                          ? widget.workTime.inLongitude.toString()
                          : '',
                      readOnly: true,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'In longitude',
                      ),
                    ),
                    TextFormField(
                      initialValue: widget.workTime.outLatitude != null
                          ? widget.workTime.outLatitude.toString()
                          : '',
                      readOnly: true,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Out latitude',
                      ),
                    ),
                    TextFormField(
                      initialValue: widget.workTime.outLongitude != null
                          ? widget.workTime.outLongitude.toString()
                          : '',
                      readOnly: true,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Out longitude',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
