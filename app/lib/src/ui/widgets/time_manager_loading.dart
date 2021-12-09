import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timetracking/src/blocs/time_manager/bloc.dart';
import 'package:timetracking/src/utils/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';

class TimeManagerLoadingPage extends StatefulWidget {
  const TimeManagerLoadingPage({Key? key}) : super(key: key);

  @override
  _TimeManagerLoadingPageState createState() => _TimeManagerLoadingPageState();
}

class _TimeManagerLoadingPageState extends State<TimeManagerLoadingPage> {
  @override
  Widget build(BuildContext context) {
    MySharedPreferences().get("USER_EMAIL").then((email) {
      if (email != null && email.isNotEmpty) {
        MySharedPreferences().get('CLOCK_STATE').then((clockState) {
          if (clockState == "IN") {
            BlocProvider.of<TimeManagerBloc>(context)
                .add(const TimeManagerLoadLoginEvent("Clock In"));
          } else if (clockState == "OUT") {
            BlocProvider.of<TimeManagerBloc>(context)
                .add(const TimeManagerLoadLoginEvent("Clock Out"));
          } else {
            //TODO Retrieve last action and check if it is clocked in or not
            BlocProvider.of<TimeManagerBloc>(context)
                .add(const TimeManagerLoadLoginEvent("Clock In"));
          }
        });
      } else {
        _checkLocation().then((value) {
          BlocProvider.of<TimeManagerBloc>(context)
              .add(const TimeManagerLoadErrorEvent("Please login first"));
        }).catchError((onError) {
          BlocProvider.of<TimeManagerBloc>(context)
              .add(TimeManagerLoadErrorEvent(onError.toString()));
        });
      }
    });
    return Center(
      child: Column(
        children: const [CircularProgressIndicator(), Text("Loading")],
      ),
    );
  }

  Future<bool> _checkLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return Future.value(true);
  }
}
