import 'package:flutter/material.dart';
import 'package:website/utils/shared_preferences.dart';

class PrivateRoute extends StatefulWidget {
  final bool is_private;
  final Widget child;

  const PrivateRoute(this.is_private, this.child);

  @override
  _PrivateRoute createState() => _PrivateRoute();
}

class _PrivateRoute extends State<PrivateRoute> {
  @override
  void initState() {
    Future(() async {
      final auth = await MySharedPreferences().get("AUTH");
      if (widget.is_private == true) {
        if (auth == null) {
          Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
        }
      } else {
        if (auth != null) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/home', (route) => false);
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (widget.child);
  }
}
