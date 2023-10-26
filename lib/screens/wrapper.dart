import 'package:cofee_flutter/model/users.dart';
import 'package:cofee_flutter/screens/authenticate/authenticate.dart';
import 'package:cofee_flutter/screens/home/Screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  static const screenRoute = '/wrapper';
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // accessing the user data from the provider
    final user = Provider.of<Users?>(context);

    //return either authenticate or screens widget
    if (user == null) {
      return Authenticate();
    } else {
      return Screens();
    }
  }
}
