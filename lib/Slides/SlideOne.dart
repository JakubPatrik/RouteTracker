import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Animation/FadeAnimation.dart';

class SlideOne extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.of(context).size.height;
    double sw = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: sh,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            FadeAnimation(0.2,Padding(
              padding: EdgeInsets.only(top:30),
              child:Container(
              alignment: Alignment.topCenter,
              height: sh*0.5,
              child: Image.asset("assets/welcome_people.png",scale:1.2,width:sw*1.2,height: sh,),
              ),
            ),),
            FadeAnimation(1.5,Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Column(children:<Widget>[
                Text("Welcome to",style: TextStyle(fontSize: 32,fontFamily: 'Rockwell'),),
                Text("see it.",style: TextStyle(fontSize:46, color:Color(0xff008080),letterSpacing: 3.0),),
                SizedBox(height: 30,),
                Padding(
                  padding: EdgeInsets.only(left:40,right:40),
                  child:Text("This app keeps track of your routes and "
                    "inform you about possible threats",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20,fontFamily: 'Corbel'),),
                ),
              ]
            )
            ))
          ]
        )
      )
    );
  }
}