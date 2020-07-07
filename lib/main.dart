import 'package:flutter/material.dart';
import 'package:myapp/HomePage/HomeScreen.dart';

import 'SharedPref.dart';
import 'Welcome.dart';

void main() => runApp(MyApp());

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  String pipik = "";
  SharedPref sharedPref = SharedPref();
  get() async{
    pipik = await sharedPref.read("id_pass");
    debugPrint(pipik);
  }

  @override
  Widget build (BuildContext context) {
    get();
    bool isLogged = sharedPref.read("id_pass") == "" || sharedPref.read("id_pass") == null;
    return MaterialApp(
      title: "See it",
      home: isLogged
        ? Welcome()
        : HomeScreen(),
    );
  }
}
