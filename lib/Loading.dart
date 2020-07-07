import 'package:flutter/material.dart';
import 'file:///C:/Users/Jakub%20Patrik/Android_Apps/myapp/lib/HomePage/MainMap.dart';

class Loading extends StatefulWidget {

  @override
  _Loading createState() => _Loading();
}

class _Loading extends State<Loading>{

  @override
  void initState() {
    Future.delayed(Duration(seconds: 3)).then((value) =>
      Navigator.push(
        context, MaterialPageRoute(builder: (context) => MainMap(false))));
    super.initState();
  }
  
  @override
  build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.pink,
          ),
        )
      ),
    );
  }
}