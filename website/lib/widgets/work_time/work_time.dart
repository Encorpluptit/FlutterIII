import 'package:flutter/material.dart';
import 'package:website/models/work_time.dart';

class WorkTime extends StatefulWidget {
  final WorkTimeModel workTime;

  WorkTime({Key? key, required this.workTime}) : super(key: key);

  @override
  _WorkTime createState() => _WorkTime();
}

class _WorkTime extends State<WorkTime> {
  var email_controller = TextEditingController();
  final password_controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  void initState() {
    email_controller =
        TextEditingController(text: widget.workTime.in_.toString());
    super.initState();
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber[600],
      child: Card(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // TextFormField(
                //   key: _formKey,
                //   autofocus: false,
                //   controller: password_controller,
                //   decoration: InputDecoration(
                //     hintText: 'Entry A',
                //   ),
                // ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 4.25,
                  child: TextFormField(
                    // key: _formKey,
                    autofocus: false,
                    controller: email_controller,
                    decoration: InputDecoration(
                      hintText: 'Entry A',
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 5,
                  child: TextFormField(
                    // key: _formKey,
                    autofocus: false,
                    controller: password_controller,
                    decoration: InputDecoration(
                      hintText: 'Entry A',
                    ),
                  ),
                ),
                Divider(),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _selectTime(context);
                      },
                      child: Text("In time"),
                    ),
                    Divider(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                      onPressed: () {
                        _selectTime(context);
                      },
                      child: Text("Out time"),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
      // child: Card(
      //   child: Column(
      //     children: [
      //       Row(
      //         children: [
      //           TextFormField(
      //             autofocus: false,
      //             controller: password_controller,
      //             decoration: InputDecoration(
      //               hintText: 'Entry A',
      //               contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      //             ),
      //           ),
      //           TextFormField(
      //             autofocus: false,
      //             // controller: password_controller,
      //             decoration: InputDecoration(
      //               hintText: 'Entry A',
      //               contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

// @override
// Widget build(BuildContext context) {
//   return Container(
//     height: 50,
//     color: Colors.amber[600],
//     child: const Center(child: Text('Entry A')),
//   );
// }
}
