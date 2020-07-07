import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Animation/FadeAnimation.dart';
import 'package:myapp/HomePage/SettingsOnePage.dart';

class PasswordReset extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.of(context).size.height;
    double sw = MediaQuery.of(context).size.width;
    Future.delayed(Duration(seconds: 3),() => Navigator.push(context, MaterialPageRoute(builder: (context)=> SettingsOnePage())));
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
                height: sh*0.6,
                child: Image.asset("assets/password_reset.png",scale:1,width:sw*1.2,height: sh,),
              ),
            ),),
            FadeAnimation(1.5,Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Column(children:<Widget>[
                Text("Password Reset",style: TextStyle(fontSize: 32,fontFamily: 'Rockwell'),),
                SizedBox(height: 30,),
                Padding(
                  padding: EdgeInsets.only(left:40,right:40),
                  child:Text("Your password has been reset successfully",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20,fontFamily: 'Corbel'),),
                ),
                SizedBox(height:20),
                CircularProgressIndicator(),
              ]
              )
            ))
          ]
        )
      )
    );
  }
}