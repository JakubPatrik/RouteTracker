import 'package:flutter/material.dart';
import 'package:myapp/Animation/FadeAnimation.dart';

class SlideTwo extends StatelessWidget{

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
                child: Image.asset("assets/welcome_map.png",scale:1.2,width:sw*1.2,height: sh,),
              ),
            ),),
            FadeAnimation(1.5,Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Column(children:<Widget>[
                SizedBox(height: 60,),
                Padding(
                  padding: EdgeInsets.only(left:50,right:50),
                  child:Text("Your routes will be saved locally on the device for two weeks",
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