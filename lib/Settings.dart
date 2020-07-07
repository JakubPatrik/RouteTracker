import 'dart:math';
import 'package:flutter/material.dart';

import 'SharedPref.dart';

class Settings extends StatefulWidget{
  @override
  _Settings createState() => _Settings();
}

class _Settings extends State<Settings>{

  SharedPref sharedPref = SharedPref();
  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    double sh = MediaQuery.of(context).size.height;

    Positioned leftBox(){
      return Positioned(
        top: 0.45*sh,
        child: FlatButton(
          onPressed: (){},
          color: Colors.transparent,
          child: Container(
            width: 0.55*sw,
            height: 0.35*sh,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 60,left:50),
                  child: Text("NO threats",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.w100,fontFamily: 'Corbel',letterSpacing: 3),),
                ),
              ],
            ),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10.0),
              color: Color(0xff8DD29E),
            ),
          ),
        ),
      );
    } 

    Positioned rightBox(){
      return Positioned(
        top: 0.5*sh,right: -30,
        child: FlatButton(
          onPressed: (){},
          child: Container(
            width: 0.33*sw,
            height: 0.3*sh,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top:20),
                  child: Icon(Icons.not_listed_location,size: 75.0,),
                ),
                Padding(
                  padding: EdgeInsets.only(top:25),
                  child: Text("Go to ",
                  style: TextStyle(fontSize: 36,fontWeight: FontWeight.w100,fontFamily: 'Corbel'),),
                ),
              ],
            ),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10.0),
              color: Color(0xff76ABB2),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(
      children: <Widget> [
        Positioned(
          left:sw*0.25,bottom:-sh*0.1,
          child: Transform(
            transform: Matrix4.rotationZ(0.07*pi),
            child:Container(
              child: Image.asset("assets/ellipse_bg.png",scale: 0.1,width:0.9*sw),
            ),
          ),
        ),

        leftBox(),
        Positioned(
          left:sw*0.45,bottom:sh*0.2,
          child:Container(
            width: sw*0.8, height: sh*0.8,
            child: Image.asset("assets/sitting_man_nobox.png"),
          ),
        ), 

        rightBox(),
        Positioned(
          left:-sw*0.35,bottom:sh*0.02,
          child:Container(
            width: sw*0.8, height: sh*0.8,
            child: Image.asset("assets/doctor.png"),
          ),
        ),

        Positioned(
          top:0.05*sh,left:0.05*sw,
          child: Text ("Welcome back,",
            style: TextStyle(fontSize: 46.0, letterSpacing: 5.0,fontFamily: 'Microsoft'),),
        ),
        Positioned(
          top:0.10*sh,left:0.05*sw,
          child: Text (sharedPref.read("first_name").toString() + "!",
            style: TextStyle(fontSize: 50.0,letterSpacing: 3.0, fontFamily: 'Rockwell'),),
        ),
      ]
    ),
  );
}

/* ----------FUNCTIONS--------------------------------------- */

  String dayOfWeek(){
    List week = [null,"Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"];
    return week[DateTime.now().weekday];
  }

  @override
  void initState() {
    super.initState();
  }

}