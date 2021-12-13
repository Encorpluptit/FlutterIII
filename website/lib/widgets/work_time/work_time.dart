import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    if (widget.workTime.in_ != null) {
      inTime = TimeOfDay.fromDateTime(widget.workTime.in_!.toDate());
      var inTmp = TimeOfDay.fromDateTime(widget.workTime.in_!.toDate());
      inController = TextEditingController(
        text:
            '${inTmp.hour}:${inTmp.minute} ${inTmp.period.name.toString().toUpperCase()}',
      );
    }
    if (widget.workTime.out != null) {
      inTime = TimeOfDay.fromDateTime(widget.workTime.out!.toDate());
      var outTmp = TimeOfDay.fromDateTime(widget.workTime.out!.toDate());
      outController = TextEditingController(
        text:
            '${outTmp.hour}:${outTmp.minute} ${outTmp.period.name.toString().toUpperCase()}',
      );
    }
    // super.initState();
  }

  _submitWorkTime(BuildContext context) async {}

  _selectTime(BuildContext context, TimeOfDay time,
      TextEditingController controller) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: time,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != time) {
      setState(() {
        controller.text = timeOfDay.format(context);
        time = timeOfDay;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // inController = TextEditingController(
    //   text:
    //       TimeOfDay.fromDateTime(widget.workTime.in_!.toDate()).format(context),
    // );
    // outController = TextEditingController(
    //   text:
    //       TimeOfDay.fromDateTime(widget.workTime.out!.toDate()).format(context),
    // );
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
                            onFieldSubmitted: (value) => {
                              print('In Time submitted ${inController.text}')
                            },
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _selectTime(context, inTime, inController);
                          },
                          child: Text("In time"),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 9,
                          child: TextFormField(
                            // initialValue: outTime.toString(),
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
                            _selectTime(context, outTime, outController);
                          },
                          child: Text("Out time"),
                        ),
                      ],
                    ),
                    Divider(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.green),
                      onPressed: () {
                        print('ICI');
                        _formKey.currentState
                            ?.validate(); // _selectTime(context, outTime);
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
                      // initialValue: widget.workTime.inLatitude.toString(),
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
                      // initialValue: widget.workTime.inLongitude.toString(),
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
